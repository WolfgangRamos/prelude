;;; wra-org --- Summary
;;; TODO

;;; Commentary:

;;; Code
(prelude-require-package 'org-plus-contrib)
(require 'org)
(require 'yasnippet)
(require 'cdlatex)
(require 'org-wc) ;; provides function 'org-word-count
(prelude-require-package 'org-ref)
(prelude-require-package 'ob-restclient)
(require 'ob-restclient)
(require 'ob-sql)
(require 'org-inlinetask)

(define-key org-mode-map (kbd "C-,") nil)
(global-set-key (kbd "C-c b") nil)


(setq org-image-actual-width nil)

(defun gearup--org-id-cache-use-gearup-savefile-dir ()
  "Point org-id cache location to gearup savefile dir."
  (custom-set-variables '(org-id-locations-file (expand-file-name "~/.emacs.d/personal/savefile/.org-id-locations"))))

(gearup--org-id-cache-use-gearup-savefile-dir)

;; allow alphabetical lists, like a), b) ... or a., b. ...
(setq org-list-allow-alphabetical t)

;; hide markup for bold and italic text
(setq org-hide-emphasis-markers t)

;; set agenda files
(setq org-agenda-files
      '("~/prj/bsc_thesis"
        "~/prj/bsc_thesis/proposal"
        "~/prj/bsc_thesis/thesis"))

;; set scrum-like todo keywords
(setq org-todo-keywords
      '((sequence "TODO(t!)" "|" "DONE(d@)")
        (sequence "NEW(n@)" "ACTIVE(a@)" "BLOCKED(b@)" "|" "CLOSED(c@)" "CANCELLED(k@)")))

;; set font faces for TODO keywords
(defface wra-org-keyword-new '((default (:foreground "#9400d3" :weight bold))) "Face for a new task." :group 'org-faces)
(defface wra-org-keyword-active '((default (:foreground "#9400d3" :box t :weight bold))) "Face for task that is currently beeing worked on." :group 'org-faces)
(defface wra-org-keyword-blocked '((default (:foreground "#ff8c00" :weight bold))) "Face for a blocked task." :group 'org-faces)
(defface wra-org-keyword-cancelled '((default (:foreground "#696969" :weight bold))) "Face for a cancelled task." :group 'org-faces)

(setq org-todo-keyword-faces
      '(("TODO" . org-todo)
        ("DONE" . org-done)
        ("NEW" . wra-org-keyword-new)
        ("ACTIVE" . wra-org-keyword-active)
        ("BLOCKED" . wra-org-keyword-blocked)
        ("CLOSED" . org-done)
        ("CANCELLED" . wra-org-keyword-cancelled)))

;; set shortcut for agenda dispatcher
(define-key global-map "\C-ca" 'org-agenda)

;; custom searches
(defun wra-skip-entry-if-older-than-a-week ()
  "Skip entries that are older than a week from today."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    ;;(debug)
    (if (re-search-forward "^[[:space:]]*- State \\\"[A-Z]*\\\"[^\\[]*\\[\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} [A-Z][a-z] [0-9]\\{2\\}:[0-9]\\{2\\}\\)\\]" subtree-end t)
        ;; the entry contains a log entry
        (let* ((ts (match-string 1)) ; found timestamp
               (x (org-time-stamp-to-now ts)) ; difference between the time stamp and now in days
               (within-last-week (and (< x 1) (> x -8)))) ;; is -8 < x < 1
          (if within-last-week
              nil           ; the most recent log entry matches the todo-keyword an is from within the last week -> do not skip this item
            subtree-end))   ; else -> return end position of the current subtree
      ;; if the entry does not contain a log entry -> skip it
      subtree-end)))

(defun wra-skip-entry-if-older-than-last-thursday ()
  "Skip entries that are older than last thursday."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    ;;(debug)
    (if (re-search-forward "^[[:space:]]*- State \\\"[A-Z]*\\\"[^\\[]*\\[\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} \\)\\([A-Z][a-z]\\)\\( [0-9]\\{2\\}:[0-9]\\{2\\}\\)\\]" subtree-end t)
        ;; the entry contains a log entry
        (let* ((ts (concat (match-string 1) (match-string 2) (match-string 3))) ; found timestamp
               (day (match-string 2))
               (day-diff (cond ((string-equal day "Fr") -1)
                               ((string-equal day "Sa") -2)
                               ((string-equal day "So") -3)
                               ((string-equal day "Mo") -4)
                               ((string-equal day "Di") -5)
                               ((string-equal day "Mi") -6)
                               ((string-equal day "Do") -7)))
               (x (org-time-stamp-to-now ts)) ; difference between the time stamp and now in days
               (within-last-week (and (< x 1) (> x day-diff)))) ;; is day-diff < x < 1
          (if within-last-week
              nil           ; the most recent log entry matches the todo-keyword an is not older than last thursday -> do not skip this item
            subtree-end))   ; else -> return end position of the current subtree
      ;; if the entry does not contain a log entry -> skip it
      subtree-end)))

;; shortcut C-c a f?
(setq org-agenda-custom-commands
      '(("f" . "Agendas for my bachelor thesis project")
        ("fw" "Last week' activities"
         ((todo "CLOSED"
                ((org-agenda-overriding-header "Last week's closed tasks:")
                 (org-agenda-skip-function 'wra-skip-entry-if-older-than-a-week)
                 ))
          (todo "NEW"
                ((org-agenda-overriding-header "Last week's newly created tasks:")
                 (org-agenda-skip-function 'wra-skip-entry-if-older-than-a-week)
                 ))
          (todo "CANCELLED"
                ((org-agenda-overriding-header "Last week's cancelled tasks:")
                 (org-agenda-skip-function 'wra-skip-entry-if-older-than-a-week)
                 ))
          (todo "BLOCKED"
                ((org-agenda-overriding-header "Currently blocked tasks:")
                 ))
          (todo "ACTIVE"
                ((org-agenda-overriding-header "Tasks I'm currently working on:")
                 ))
          )
         ((org-agenda-files '("~/prj/bsc_thesis" "~/prj/bsc_thesis/proposal" "~/prj/bsc_thesis/thesis")))
         ("~/prj/bsc_thesis/last_weeks_activities.html"))
        ("ft" "Activity since last thursday"
         ((todo "CLOSED"
                ((org-agenda-overriding-header "Last week's closed tasks:")
                 (org-agenda-skip-function 'wra-skip-entry-if-older-than-last-thursday)
                 ))
          (todo "NEW"
                ((org-agenda-overriding-header "Last week's newly created tasks:")
                 (org-agenda-skip-function 'wra-skip-entry-if-older-than-last-thursday)
                 ))
          (todo "CANCELLED"
                ((org-agenda-overriding-header "Last week's cancelled tasks:")
                 (org-agenda-skip-function 'wra-skip-entry-if-older-than-last-thursday)
                 ))
          (todo "BLOCKED"
                ((org-agenda-overriding-header "Currently blocked tasks:")
                 ))
          (todo "ACTIVE"
                ((org-agenda-overriding-header "Tasks I'm currently working on:")
                 ))
          )
         ((org-agenda-files '("~/prj/bsc_thesis" "~/prj/bsc_thesis/proposal" "~/prj/bsc_thesis/thesis")))
         ("~/prj/bsc_thesis/activities_since_last_thursday.html"))
        ))

;; turn on cdlatex in org mode
;;(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; enable yasnippet
(add-hook 'org-mode-hook #'yas-minor-mode)

(defun gearup-org-mode-free-user-keybindings ()
  "Adjust org-mode keybindings"
  (define-key org-mode-map (kbd "C-c SPC") nil)
  (define-key org-mode-map (kbd "C-c .") nil))

(add-hook 'org-mode-hook 'gearup-org-mode-free-user-keybindings)

;; enable evaluation of code blocks for specific languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sql . t)
   (restclient . t)
   (shell . t)))



;; latex math fragments preview
;;(setq org-latex-create-formula-image-program 'dvipng)
(setq org-latex-create-formula-image-program 'imagemagick)

;; translator orgtbl -> java array
(defun orgtbl-to-java-array (table params)
  "Convert the orgtbl-mode TABLE to a java array."
  (orgtbl-to-generic
   table
   (org-combine-plists
    '(:splice t :lstart "{" :lend "}," :llend "}" :sep ",")
    params)))


;; latex export
(require 'ox-latex)

;; allow '#+BIND' keyword in org header
(setq org-export-allow-bind-keywords t)

;; additional packages
;;(add-to-list 'org-latex-packages-alist '("" "wraorgpreview" t))
;;(add-to-list 'org-latex-packages-alist '("" "hyperref" t))
(setq org-latex-packages-alist '(("" "wrabscpreview" t) ("binary-units = true" "siunitx" t))) ;; for bsc thesis

;; add latex class 'kcssproposal'
(add-to-list 'org-latex-classes
             '("kcss"
               "\\documentclass{kcss}
                [NO-DEFAULT-PACKAGES]
                [NO-PACKAGES]
                [EXTRA]"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
             )

;; add latex class 'beamer'
(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass{beamer}
                [NO-DEFAULT-PACKAGES]
                [NO-PACKAGES]
                [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
             )

;; globally disable export of pdf meta data using hyperref
(setq org-latex-with-hyperref t)

;; set latex-to-pdf export process
(setq org-latex-pdf-process '("latexmk -pdf %f"))

;; remove default org labels in latex export
(defun wra-org-export-remove-latex-labels (string backend info)
  "Remove section labels generated by org-mode"
  (when (org-export-derived-backend-p backend 'latex)
    (replace-regexp-in-string "\\\\label{sec-[0-9][^}]*}\n" "" string)))

(defun wra-org-export-remove-orgref-labels (backend)
  "Remove all orgref labels before parsing"
  (when (org-export-derived-backend-p backend 'ascii)
    (beginning-of-buffer)
    (wra-remove-labels)))

(defun wra-remove-labels ()
  ;; (interactive)
  (while (re-search-forward "^label:.*\\s-" nil t)
    (replace-match "")))
;; (add-to-list 'org-export-filter-final-output-functions 'remove-orgmode-latex-labels)


;; org bibtex support
;;(require 'ox-bibtex)


;; org beamer export
(require 'ox-beamer)

;; functions to publish my cs_wiki
(require 'ox-publish)

(setq org-publish-project-alist
      '(
        ("org-wra-cs-wiki"
         ;; Path to your org files.
         :base-directory "~/wiki/cs_wiki/org/"
         :base-extension "org"

         ;; Path to your Jekyll project.
         :publishing-directory "~/wiki/cs_wiki/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :html-extension "html"
         :body-only t ;; Only export section between <body> </body>
         )


        ("org-static-wra-cs-wiki"
         :base-directory "~/wiki/cs_wiki/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php\\|java\\|hs\\|erl"
         :publishing-directory "~/wiki/cs_wiki/"
         :recursive t
         :publishing-function org-publish-attachment)

        ("cs-wiki" :components ("org-wra-cs-wiki" "org-static-wra-cs-wiki"))

        ))

;;; Tips
(push "Hit <M-S-left> to kill the current column." prelude-tips)
(push "Hit <M-S-right> to insert a new column left of the cursor." prelude-tips)

;;; Playground
(prelude-require-package 'org-mime)
;;(require 'org-mime)
;;(custom-set-variables '(epg-gpg-program "c:/Program Files (x86)/GnuPG/bin/gpg.exe"))


;; export to confluence
(require 'ox-confluence)

(org-export-define-derived-backend 'confluence-improved 'confluence
  :translate-alist '((paragraph . gearup-ox--confluence-paragraph)
                     (table-cell . gearup-ox--confluence-table-cell)
                     (item . gearup-ox--confluence-item)
                     (target . gearup-ox--confluence-target)
                     (headline . gearup-ox--confluence-headline)
                     (src-block . geraup-ox--confluence-src-block)
                     (link . gearup-ox--confluence-link))
  :menu-entry '(?w "Wiki"
                   ((?C "As confluence wiki buffer" gearup-ox--export-as-confluence-wiki)
                    (?c "As confluence wiki file" gearup-ox--export-to-confluence-wiki))))

(defun geraup-ox--confluence-src-block (src-block contents info)
  ;; FIXME: provide a user-controlled variable for theme
  (let* ((lang (org-element-property :language src-block))
         (caption (org-export-get-caption src-block))
         (language (or (cdr (assoc lang org-confluence-lang-alist)) lang))
         (content (org-export-format-code-default src-block info)))
    (concat "\{code:theme=Emacs"
            (when language (format "|language=%s" language))
            (when caption (format "|title=%s" (substring-no-properties (org-export-data caption info))))
            "|collapse=true\}\n"
            content
            "\{code\}\n")))

(defun gearup-ox--confluence-target (target contents info)
  "Transcode org targets to Confluence anchors."
  (let ((name (org-element-property :value target)))
    (when (org-string-nw-p name)
      (gearup-ox--confluence-create-target name))))

(defun gearup-ox--confluence-create-target (name)
  "Create anchor markup for target NAME."
  (format "{anchor:%s}" name))

(defun gearup-ox--confluence-headline (headline contents info)
  "Transcode org headlines as confluence headlines.

`:CUSTOM_ID' properties of headlines are transcoded transcoded as
confluence anchors."
  (let* ((low-level-rank (org-export-low-level-p headline info))
         (text (org-export-data (org-element-property :title headline)
                                info))
         (todo (org-export-data (org-element-property :todo-keyword headline)
                                info))
         (level (org-export-get-relative-level headline info))
         (todo-text (if (or (not (plist-get info :with-todo-keywords))
                            (string= todo ""))
                        ""
                      (format "*{{%s}}* " todo)))
         (custom-id (org-export-get-node-property :CUSTOM_ID headline)))
    (format "h%s. %s%s%s\n%s" level todo-text text
            (if (org-string-nw-p custom-id) (format "\n%s" (gearup-ox--confluence-create-target custom-id)) "")
            (if (org-string-nw-p contents) contents ""))))

(defun gearup-ox--confluence-link (link desc info)
  "Transcode org links to confluence links.

Confluence only supports a subset of the link types provided by org mode. Currently only the following link types are transcoded correctly:

- Links to targets
- Links to `:CUSTOM_ID's."
  (let ((type (org-element-property :type link))
        (raw-link (org-element-property :raw-link link))
        (path (org-element-property :path link)))
    (cond
     ((string= type "fuzzy")
      (let* ((target (org-export-resolve-fuzzy-link link info))
             (target-type (when target (org-element-type target))))
        (cond
         ((eq target-type 'target)
          (format "[#%s]" raw-link)))))
     ((string= type "file")
      (if (org-file-image-p raw-link)
          (format "!%s|width=400!" (file-name-nondirectory path))
        (format "[^%s]" (file-name-nondirectory raw-link))))
     (t
      (concat "["
              (when (org-string-nw-p desc) (format "%s|" desc))
              (cond
               ((string-match "^confluence:" raw-link)
                (replace-regexp-in-string "^confluence:" "" raw-link))
               (t
                raw-link))
              "]")))))

(defun gearup-ox--confluence-parse-properties-alist (content)
  "Parse the text CONTENT of an org mode buffer")
(defun gearup-ox--confluence-checkbox (item info)
  "Return checkbox string for ITEM or nil.
INFO is a plist used as a communication channel."
  (cl-case (org-element-property :checkbox item)
    (on "☑ ")
    (off "☐ ")
    (trans "☒ ")))

(defun gearup-ox--confluence-item (item contents info)
  (let ((list-type (org-element-property :type (org-export-get-parent item)))
        (checkbox (gearup-ox--confluence-checkbox item info))
        (depth (1+ (org-confluence--li-depth item))))
    (cl-case list-type
      (descriptive
       (concat (make-string depth ?-) " "
               (org-export-data (org-element-property :tag item) info) ": "
               (org-trim contents)))
      (ordered
       (concat (make-string depth ?#) " " checkbox
               (org-trim contents)))
      (t
       (concat (make-string depth ?-)
               " " checkbox
               (org-trim contents))))))

(defun gearup-ox--confluence-table-cell  (table-cell contents info)
  "Wrap table cell contents in whitespace.
Without the extra whitespace, cells will collapse together thanks
to confluence's table header syntax being multiple pipes."
  (let ((table-row (org-export-get-parent table-cell)))
    (concat
     (when (org-export-table-row-starts-header-p table-row info)
       "|")
     " " contents " |")))

(defun gearup-ox--confluence-paragraph (paragraph contents info)
  "Strip newlines from paragraphs.
Confluence will include any line breaks in the paragraph, rather
than treating it as reflowable whitespace."
  (replace-regexp-in-string "\n" " " contents))

(defun gearup-ox--export-as-confluence-wiki (&optional a s v b e)
  "Export buffer as confluence wiki."
  (interactive)
  (org-export-to-buffer 'confluence-improved "*Org CONFLUENCE Wiki Markup Export*" a s v b e (lambda () (text-mode))))

(defun gearup-ox--export-to-confluence-wiki (&optional a s v b e)
  "Export buffer to confluence wiki file."
  (interactive)
  (let ((file (org-export-output-file-name ".txt" subtreep)))
    (org-export-to-file 'confluence-improved file a s v b)))

;; reduced ascii backend
(org-export-define-derived-backend 'ascii-reduced 'ascii
  :translate-alist '((italic . gearup-ox--ascii-reduced-no-formatting)
                     (bold . gearup-ox--ascii-reduced-no-formatting)
                     (strike-through . gearup-ox--ascii-reduced-no-formatting))
  :menu-entry '(?t 1
                   ((?R "As ASCII buffer with reduced markup" gearup-ox--export-as-ascii-reduced)
                    (?r "As ASCII file with reduced markup" gearup-ox--export-to-ascii-reduced))))

(defun gearup-ox--ascii-reduced-no-formatting (_italic contents _info)
  "Return CONTENTS without adding formatting."
  contents)

(defun gearup-ox--export-as-ascii-reduced (&optional a s v b e)
  "Export buffer as reduced ascii."
  (interactive)
  (org-export-to-buffer 'ascii-reduced "*Org ASCII Reduced Markup Export*" a s v b e (lambda () (text-mode))))

(defun gearup-ox--export-to-ascii-reduced (&optional a s v b e)
  "Export buffer to reduced ascii file."
  (interactive)
  (let ((file (org-export-output-file-name ".txt" subtreep)))
    (org-export-to-file 'ascii-reduced file a s v b)))

;;; Tips:

(setq prelude-tips
      (append prelude-tips
              '("Hit <C-c C-x t> in org mode to insert an inline task."
                "Hit <C-c C-x p> in org mode to insert a property.")))

(provide 'wra-org)
;;; wra-org.el ends here
