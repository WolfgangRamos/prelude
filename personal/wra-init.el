;;; wra-init.el --- My Prelude User Init File

;;; Commentary

;;; Code

;; install require packages through prelude
(prelude-require-package 'yasnippet)
(prelude-require-package 'image+)
(prelude-require-package 'dired+)
(prelude-require-package 'cdlatex)
(prelude-require-package 'auctex)
(prelude-require-package 'helm-c-yasnippet)
;;(prelude-require-package 'sunrise-commander)

;;;; TODO move general setup stuff from wra-emacs-setup.el to this file (init.el)
(add-to-list 'load-path (expand-file-name "wra" prelude-personal-dir))
(let ((default-directory (expand-file-name "lisp" prelude-personal-dir)))
  (normal-top-level-add-subdirs-to-load-path))

;; require personalizations in 'wra' subdir
(require 'wra-helm)
(require 'wra-image)
;;(require 'wra-ispell)
(require 'wra-essh)
(require 'wra-ess)
(require 'wra-dired)
(require 'wra-org)
(require 'wra-yasnippet) ;; must  be loaded before auto complete?
(require 'wra-auctex)
(require 'wra-cdlatex)
(require 'wra-shell)
(require 'wra-company)
(require 'x-dict)
(require 'restclient)
;;(require 'wra-restclient)
(require 'wra-nameses)
(require 'wra-sunrise-commander)
(require 'wra-savehist)
(require 'wra-isearch)
(require 'wra-xml)

;; set home directory
(defun wra-try-get-home-dir ()
  "Returns environment variable HOME if set. Otherwise guess Wolfgang's standard wra directory"
  (if (getenv "HOME")
      (getenv "HOME")
    (if (equal system-type 'windows-nt)
        "c:/Users/wra/"
      "/home/wra"/)))

(setq default-directory (wra-try-get-home-dir))

(menu-bar-mode 1)
(add-to-list 'default-frame-alist '(fullscreen . fullboth)) ;; start in fullscreen mode (toggle with <F11>)
(setq display-time-default-load-average nil) ;; hide system load
(setq display-time-format "%a, %d.%m.%Y %H:%M")
(display-time-mode 1)

(setq guru-warn-only nil)

;; Tabs
;; tab stops at: 4, 8, 12, ..., 80
;;(setq tab-stop-list (number-sequence 4 80 4))
;;(setq tab-width 4)
(setq-default tab-width 4)

;; always insert spaces instead of tabs
;;(setq-default indent-tabs-mode nil)

;; allow fast cycling throught the mark ring with: C-u C-Space, C-Space, ...
(setq set-mark-command-repeat-pop 1)

;; set default grep command
;;(grep-apply-setting 'grep-command "grep -Hnrwi \".\" -e ")
(setq grep-command "grep -Hnrwi \".\" -e ")

;; enable global hl-line-mode
(global-hl-line-mode nil)

;; keybindings for movement by paragraph
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)

;; delete bindings from prelude-mode-map
(define-key prelude-mode-map [(shift return)] nil) ;; masks org-table-copy-down
(define-key prelude-mode-map [(meta shift up)] nil)
(define-key prelude-mode-map [(meta shift down)] nil)
(define-key prelude-mode-map (kbd "C-c t") 'eshell) ;; replaced default ansi-term with eshell :)

(setq register-preview-delay 0)

;; bind pop-tag-mark
(global-set-key (kbd "M-*") 'pop-tag-mark)


;; set re-builder style to 'read (needs double escaping)
(setq reb-re-syntax 'read)

;;----------------------------------------------------------------------------;;
;; Modes                                                                      ;;
;;----------------------------------------------------------------------------;;

;; avy & ace window
;; (global-set-key (kbd "M-s") 'avy-goto-word-1)
;; (global-set-key (kbd "M-S") 'avy-goto-char-timer)
;; (global-set-key (kbd "M-l") 'avy-goto-line)
(global-set-key (kbd "M-W") 'ace-window)


;; DocView Mode (pdf viewer)
;; (put 'set-goal-column 'disabled nil) ;; enable continuous scrolling

;; PDF Tools
;; (pdf-tools-install)
;; (add-Hook 'doc-view-mode-hook
;;           (lambda()
;;             (pdf-view-mode)))

;; ;; Paren-Mode (shows matching brackets)
;; (setq show-paren-delay 0)


;; Haskell
;; (require 'haskell-interactive-mode)
;; (require 'haskell-process)
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(doc-view-continuous t)
;;  '(haskell-process-auto-import-loaded-modules t)
;;  '(haskell-process-log t)
;;  '(haskell-process-suggest-remove-import-lines t))
;; (add-hook 'haskell-mode-hook
;; 	  (lambda ()
;; 	    column-number-mode 1))

;; Prolog (from: https://bruda.ca/emacs/prolog_mode_for_emacs)
;; (autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
;; (autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
;; (autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
;; (setq prolog-system 'swi)
;; (setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
;;                                 ("\\.m$" . mercury-mode))
;;                               auto-mode-alist))


;; Math preview
;; (autoload 'latex-math-preview-expression "latex-math-preview" nil t)
;; (autoload 'latex-math-preview-insert-symbol "latex-math-preview" nil t)
;; (autoload 'latex-math-preview-save-image-file "latex-math-preview" nil t)
;; (autoload 'latex-math-preview-beamer-frame "latex-math-preview" nil t)



;; Markdown-Mode
;; (autoload 'markdown-mode "markdown-mode"
;;   "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;; (setq markdown-enable-math t) ;; enable math highlighting
;; (add-hook 'markdown-mode-hook
;; 	  (lambda ()
;; 	    (flyspell-mode-off)
;; 	    (electric-indent-mode nil)
;; 	    (setq indent-tabs-mode nil)))

;; (add-hook 'markdown-mode-hook #'yas-minor-mode)

;; ;; unbind ⟨M-<UP>⟩ and ⟨M-<DOWN>⟩
;; (eval-after-load "markdown-mode"
;;   '(define-key markdown-mode-map (kbd "<M-down>") nil))
;; ;;'(local-unset-key (kbd "<M-down>")))

;; (eval-after-load "markdown-mode"
;;   '(define-key markdown-mode-map (kbd "<M-up>") nil))
;; ;;  '(local-unset-key (kbd "<M-up>")))

;; useful shortcuts:
;; S-TAB: cycle global visibility (in outline view)
;; TAB: cycle local visibility (in outline view)
;; C-c C-s s: make word at point bold
;; C-c C-s e: make word at point italic



;; pandoc (Minor) Mode
;; customize default pandoc settings file
;; pandoc-load-default-settings
;; setting directory for settings files
;; (setq pandoc-data-dir "~/cnf/emacs/pandoc_mode_settings_files/")
;; (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)



;; make RET auto indent
;; (define-key global-map (kbd "RET") 'newline-and-indent)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customize Editing in Emacs
;;
;; the following commands and key bindings are defined
;; - ⟨C-x C-x⟩ exchange point and mark without selecting a region

;; exchange point and mark without selcting a region with C-x C-x
;; (defun exchange-point-and-mark-no-activate ()
;;   "Identical to \\[exchange-point-and-mark] but will not activate the region."
;;   (interactive)
;;   (exchange-point-and-mark)
;;   (deactivate-mark nil))
;; (define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)


;; toggle the case of a word with M-ö
;; -> taken from: http://ergoemacs.org/emacs/modernization_upcase-word.html
(defun wra-toggle-case ()
  "Toggle the letter case of current word or text selection.
Toggles between: “all lower”, “Init Caps”, “ALL CAPS”."
  (interactive)

  (let (p1 p2 (deactivate-mark nil) (case-fold-search nil))
    (if (use-region-p)
        (setq p1 (region-beginning) p2 (region-end))
      (let ((bds (bounds-of-thing-at-point 'word)))
        (setq p1 (car bds) p2 (cdr bds))))

    (when (not (eq last-command this-command))
      (save-excursion
        (goto-char p1)
        (cond
         ((looking-at "[[:lower:]][[:lower:]]") (put this-command 'state "all lower"))
         ((looking-at "[[:upper:]][[:upper:]]") (put this-command 'state "all caps"))
         ((looking-at "[[:upper:]][[:lower:]]") (put this-command 'state "init caps"))
         ((looking-at "[[:lower:]]") (put this-command 'state "all lower"))
         ((looking-at "[[:upper:]]") (put this-command 'state "all caps"))
         (t (put this-command 'state "all lower")))))

    (cond
     ((string= "all lower" (get this-command 'state))
      (upcase-initials-region p1 p2) (put this-command 'state "init caps"))
     ((string= "init caps" (get this-command 'state))
      (upcase-region p1 p2) (put this-command 'state "all caps"))
     ((string= "all caps" (get this-command 'state))
      (downcase-region p1 p2) (put this-command 'state "all lower")))))

;; replace build in case toggeling functions
(global-set-key (kbd "M-c") 'wra-toggle-case)
(global-set-key (kbd "M-l") 'wra-toggle-case)
(global-set-key (kbd "M-u") 'wra-toggle-case)


;; edit current file as root
(defun wra-edit-current-file-as-root ()
  "Edit the file that is associated with the current buffer as root"
  (interactive)
  (let ((filep (buffer-file-name)))
    (if filep (find-file (concat "/sudo::" filep))
      (message "Current buffer does not have an associated file."))))


;; insert math right or left angle bracket
(defun wra-insert-char-left-chevron ()
  "Insert left mathematical angle bracket"
  (interactive)
  (insert-char 10216))

(defun wra-insert-char-right-chevron ()
  "Insert rigth mathematical angle bracket"
  (interactive)
  (insert-char 10217))

(global-set-key (kbd "C-(") 'wra-insert-char-left-chevron)
(global-set-key (kbd "C-)") 'wra-insert-char-right-chevron)


;; display ascii table in a buffer
(defun wra-display-ascii-table ()
  "Display basic ASCII table (0 thru 128)."
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (setq buffer-read-only nil)        ;; Not need to edit the content, just read mode (added)
  (local-set-key "q" 'bury-buffer)   ;; Nice to have the option to bury the buffer (added)
  (save-excursion (let ((i -1))
                    (insert "ASCII characters 0 thru 127.\n\n")
                    (insert " Hex  Dec  Char|  Hex  Dec  Char|  Hex  Dec  Char|  Hex  Dec  Char\n")
                    (while (< i 31)
                      (insert (format "%4x %4d %4s | %4x %4d %4s | %4x %4d %4s | %4x %4d %4s\n"
                                      (setq i (+ 1  i)) i (single-key-description i)
                                      (setq i (+ 32 i)) i (single-key-description i)
                                      (setq i (+ 32 i)) i (single-key-description i)
                                      (setq i (+ 32 i)) i (single-key-description i)))
                      (setq i (- i 96))))))

;;; init.el ends here
