;;; wra-yasnippet.el --- My Yasnippet Configuration

;;; Commentary:

;;; Code:

;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(require 'helm-c-yasnippet) ;; use helm interface
(setq helm-yas-space-match-any-greedy t) ;[default: nil]
(global-set-key (kbd "C-c y") 'helm-yas-complete)

;; snippets dirs (new snippets are stored in the first one)
(setq yas-snippet-dirs
      (list
       (expand-file-name "fls-snippets" prelude-personal-dir)
       (expand-file-name "snippets" prelude-personal-dir) ;; personal snippet collection))
       yas-installed-snippets-dir)) ;; build in snippet collection

;; i activate yasnippet on per-mode basis
;; use `(yas-global-mode 1)` to activate yasnippet in all modes
(yas-reload-all)

(defun gearup-author ()
  "Get name/name + email/abbreviation of author"
  "Wolfgang Ramos")

(setq gearup-yasnippet-property-queries
      `(("contributor" ,(list (gearup-author)))
        ("name"
         " (used in menu and helm completion)"
         nil)
        ("key"
         " (the abbreviation to expand the snippet after)"
         nil)
        ("group"
         " (for grouping snippets in menu and helm completion)"
         nil)
        ("condition"
         " (elisp code; use t for unconditional inclusion otherwise use a symbol)"
         ("t" "'yas-cond-in-code" "'yas-cond-in-comment"))
        ("type"
         " (use command to interpret snippet as elisp)"
         ("snippet" "command"))
        ("expand-env"
         " (a let varlist; used to set/override variables during expansion)"
         ("((yas-indent-line 'fixed) (yas-wrap-around-region 'nil))"))))

(defun gearup-ido-multi-completing-read (queries)
  "Perform multiple ido completing reads; return the user inputs as assoc list.

Each element in Queries must be a list of length 2 or 3. If length is
2: The first element must be string and the last must be a list. The
first is used as prompt and as key in the result associative list. The
last is used as choices. If length is 3: The second element must be a
string. It is appended to the prompt and can be used to supply
additional information in the prompt. The information string must be
provided seperately because the prompt (the first element) is also
used as key for the result associative list. The first and the last
element are used as in the 2-element case."

  (if (not (listp queries))
      (error "QUERIES must be a list")
    (let ((values nil))
      ;; collect user inputs
      (dolist (query queries values)
        (if (not (listp query))
            (error "Each element of QUERIES must be a list")
          (let ((prompt (car-safe query))
                (prompt-suppl "")
                (choices (car (last query)))
                (input ""))
            (cond
             ((= (length query) 3)
              (if (not (stringp (car-safe (cdr-safe query))))
                  (error "If a query has 3 elements, the second one must be string")
                (setq prompt-suppl (car-safe (cdr-safe query))))))
            (if (not (stringp prompt))
                (error "The first element of each query must be a string")
              (progn
                (setq input (ido-completing-read (concat prompt prompt-suppl ": ") choices nil nil))
                (when (not (equal input ""))
                  (setq values
                        (append values (list (list prompt input)))))))))))))

(defun gearup-new-yasnippet (begin end)
  "Opens a new buffer for writing snippets.

Queries the user for most commonly snippet properties."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list nil nil)))
  (let ((props (gearup-ido-multi-completing-read gearup-yasnippet-property-queries))
        (selection ""))
    (when (and begin end)
        (setq selection (buffer-substring-no-properties begin end))
        (deactivate-mark))
    (yas-new-snippet t)
    (goto-char (point-min))
    (dolist (prop props)
      (insert "# " (car prop) ": " (cadr prop) "\n"))
    (insert "# --\n" selection)))

;;(gearup-new-yasnippet)

;;(gearup-ido-multi-completing-read gearup-yasnippet-property-queries)
;;(ido-completing-read "Prompt: " '("foo" "bar") nil nil nil nil nil)

;; configure snippet-mode

;; associate snippet mode with *.snippet files
(add-to-list 'auto-mode-alist '("\\.snippet\\'" . snippet-mode))

(setq gearup-yas-known-properties '("condition" "contributor" "expand-env" "group" "key"  "name" "type"))

(defun gearup-yas-find-props ()
  "Detect yasnippet properties in current buffer.
Return a list of plists. Each plist represents one found property. The
properties of such a plist are:

- `:name': the name of the found property

- `:start': the starting position of the property

- `:line': the line number of the property

- `:value': the value assigned to the property."

  (if (not (eq major-mode 'snippet-mode))
      (progn
        (message "Buffer is not in snippet-mode")
        nil)
    (save-excursion
      (goto-char (point-min))
      (let ((props nil)
            (bound (search-forward "# --" nil t))
            (propsort
             (lambda (p q)
               (let ((pname (plist-get p :name))
                     (ppos (plist-get p :start))
                     (qname (plist-get q :name))
                     (qpos (plist-get q :start)))
                 (or (string< pname qname)
                     (and (string= pname qname)
                          (< ppos qpos)))))))
        (if (not bound)
            nil
          (progn
            (goto-char (point-min))
            (while (re-search-forward
                    "^# \\([^:]+?\\): \\([[:print:]]*\\)[[:blank:]]*$"
                    (- bound 3)
                    t)
              (setq props
                    (cons
                     (list :name (match-string-no-properties 1)
                           :start (match-beginning 0)
                           :line (line-number-at-pos)
                           :value (match-string-no-properties 2))
                     props)))
            (cl-stable-sort props propsort)))))))


(defun gearup-util-create-compare (geta getb compare)
"Return a function to compare two arbitrary data structures.
GETA and GETB must be functions that generate compareable values from the desired input data structures. COMPARE must be a function that takes two comparable values.
The returned function takes two data structures A and B and compares them using the following procedure:
1. call GETA on A to get the first comparable value
2. call GETB on B to get the second compareable value
3. compare the first and second value using COMPARE amd return the result."

(lambda (a b)
(funcall compare (funcall geta a) (funcall getb b))))


(defun gearup-yas-classify-props (&optional present getname)
"Detect duplicate, unknown, and missing properties.
If suppplied, PRESENT must be a list structure containing property
names. PRESENT must be sorted by property names and - in second order
- by property positions. If supllied, GETNAME must be a function that
extracts a yas property name from each element of PRESENT as string.

The return value is a plist with properties:

- `:nodups' contains the valid and non-duplicate elements from PRESENT

- `:dups' lists the valid but duplicate

- `:unknown' lists the unknown

- `:missing' lists property names that are recognized by yasnippet but
  were not found in PRESENT."

(let* ( ;; list of known yasnippet properties. keep this list in
        ;; alphabetical order
       (names '("condition"
                "contributor"
                "expand-env"
                "group"
                "key"
                "name"
                "type"))
       (present (or present (gearup-yas-find-props)))
       (getname (or getname
                    (lambda (x)
                      (plist-get x :name))))
       (current (car-safe present))
       (rst (cdr-safe present))
       nodups dups missing unknown p n)
  (while (and (setq p (funcall getname current))
              (setq n (car-safe names)))
    (cond
      ((string< p n)
       (while (string< p n)
         (setq unknown (cons current unknown))
         (setq current (car-safe rst))
         (setq p (funcall getname current))
         (setq rst (cdr-safe rst))))
      ((string= n p)
       (setq nodups (cons current nodups))
       (setq current (car-safe rst))
       (setq p (funcall getname current))
       (setq rst (cdr rst))
       (while (string= p n)
         (setq dups (cons current dups))
         (setq current (car-safe rst))
         (setq p (funcall getname current))
         (setq rst (cdr rst)))
       (setq names (cdr-safe names)))
      (t ;; p > n
       (setq missing (cons n missing))
       (setq names (cdr names)))))
  (list
   :nodups nodups
   :dups dups
   :missing (append missing names)
   :unknown (append unknown rst))))

(defun gearup-yas-generate-error-messages (&optional classification)
  ""
  (let ((classification (or classification
                            (gearup-yas-classify-props))))
    ))


(defun gearup-yas-check-buffer ()
  ""
  (interactive)
  (let ((input-buffer (current-buffer))
        (filename (buffer-file-name))
        props
        validation-result
        (getname (lambda (x) (plist-get x :name)))
        (output-buffer (get-buffer-create "*Snippet Validation Result*")))
    (if (not (eq (major-mode) 'snippet-mode)))
    (message "Current buffer's major mode is not snippet-mode")
    (setq props (gearup-yas-find-props))
    (setq validation-result (gearup-yas-classify-props props getname))
    (set-buffer output-buffer)
    (insert )
    (switch-to-buffer-other-windows output-buffer)
    ))

;; whitespace highlighting configuration
(setq gearup-snippet-mode-whitespace-style
      '(face spaces trailing tabs newline space-mark tab-mark))

(add-hook 'snippet-mode-hook
          (lambda ()
            (whitespace-mode 0)
            (setq-local whitespace-style gearup-snippet-mode-whitespace-style)
            (whitespace-mode 1)
            (show-paren-mode)   ; highlight matching brackets
            (yas-minor-mode 1)))

(provide 'wra-yasnippet)
;;; wra-yasnippet.el ends here
