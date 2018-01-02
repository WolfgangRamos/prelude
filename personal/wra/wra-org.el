;;; wra-org --- Summary
;;; TODO

;;; Commentary:

;;; Code
(require 'org)
(require 'yasnippet)
(require 'cdlatex)
(require 'org-wc) ;; provides function 'org-word-count
(prelude-require-package 'org-ref)


(setq org-image-actual-width nil)

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
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; enable yasnippet
(add-hook 'org-mode-hook #'yas-minor-mode)

;; map org-time-stamp to
(add-hook 'org-mode-hook (lambda ()
                           (define-key org-mode-map (kbd "C-c .") nil)))

;; enable evaluation of code blocks for specific languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sql . t)
   (sh . t)))

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

(provide 'wra-org)
;;; wra-org.el ends here
