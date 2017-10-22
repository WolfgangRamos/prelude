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

(defun gearup-new-yasnippet ()
  "Opens a new buffer for writing snippets.

Queries the user for most commonly snippet properties."
  (interactive)
  (let ((props (gearup-ido-multi-completing-read gearup-yasnippet-property-queries)))
    (yas-new-snippet t)
    (goto-char (point-min))
    (dolist (prop props)
      (insert "# " (car prop) ": " (cadr prop) "\n"))
    (insert "# --\n")))

;;(gearup-new-yasnippet)

;;(gearup-ido-multi-completing-read gearup-yasnippet-property-queries)
;;(ido-completing-read "Prompt: " '("foo" "bar") nil nil nil nil nil)

;; configure snippet-mode

;; associate snippet mode with *.snippet files
(add-to-list 'auto-mode-alist '("\\.snippet\\'" . snippet-mode))

;; whitespace highlighting configuration

(setq gearup-snippet-mode-whitespace-style
      '(face trailing tabs newline space-mark tab-mark newline-mark))

;; TODO adjust tabs color and long lines color

(setq gearup-snippet-mode-whitespace-display-mappings ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
      '((space-mark 32 [183] [46])
        (space-mark 160 [164] [95])
        (newline-mark 10 [182 10])
        (tab-mark 9 [9655 9] [92 9])
        ))

(add-hook 'snippet-mode-hook
          (lambda ()
            (whitespace-mode 0)
            (setq-local whitespace-style gearup-snippet-mode-whitespace-style)
            (setq-local whitespace-display-mappings gearup-snippet-mode-whitespace-display-mappings)
            (whitespace-mode 1)
            (show-paren-mode)   ; highlight matching brackets
            ))

(provide 'wra-yasnippet)
;;; wra-yasnippet.el ends here
