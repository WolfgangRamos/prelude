;;; gearup-base.el --- Basic emacs configuration.

;;; Commentary:
;;; Anything not directly related to a significant emacs package.

;;; Code:
(set-language-environment "English")
(setq-default tab-width 4)
(menu-bar-mode 1)

;; improve performance
(custom-set-variables '(gc-cons-threshold 100000000)
                      '(read-process-output-max 1048576))

;; Show clock in mode line
(setq display-time-default-load-average nil)
(setq display-time-format "%a, %d.%m.%Y %H:%M")
(display-time-mode 1)

;; Additional commands
(prelude-require-package 'crux)
(global-set-key (kbd "C-S-k") 'crux-kill-whole-line)
(global-set-key (kbd "C-o") 'crux-smart-open-line)
(global-set-key (kbd "C-S-o") 'crux-smart-open-line-above)
(global-set-key (kbd "C-S-p") 'move-text-up)
(global-set-key (kbd "C-S-n") 'move-text-down)

;; Sometimes I want to separate the characters I am currently typing
;; from some follow-up characters by one space without moving the
;; curser (aka point) forward.
(defun gearup-shove-one-space-forward (arg)
  (interactive "p")
  (save-excursion
    (insert (make-string arg ? ))))

(global-set-key (kbd "S-SPC") 'gearup-shove-one-space-forward)

;; CONTINUE CLEANUP HERE
(custom-set-variables '(grep-command "grep --with-filename --line-number --recursive --ignore-case --regexp <REGEX> <FILES>"))
(global-set-key (kbd "C-,") 'cycle-spacing)

(defconst smerge-begin-re "^<<<<<<< \\{0,1\\}\\(.*\\)\r\\{0,1\\}\n")
(defconst smerge-end-re "^>>>>>>> \\{0,1\\}\\(.*\\)\r\\{0,1\\}\n")
(defconst smerge-base-re "^||||||| \\{0,1\\}\\(.*\\)\r\\{0,1\\}\n")
(defconst smerge-other-re "^=======\r\\{0,1\\}\n")


(defun gearup--assert-savefile-dir-exists ()
  "Assert gearup's savefile dir exists. If not create it."
  (let ((savefile-dir (expand-file-name "savefile" prelude-personal-dir)))
    (unless (file-directory-p savefile-dir)
      (message "Creating geraup savefile directory.")
      (make-directory savefile-dir t))))

(defun gearup-base--show-fringe-indicators-in-visual-line-mode ()
  "Show right and left arrow in visual line mode."
  (custom-set-variables '(visual-line-fringe-indicators (quote (left-curly-arrow right-curly-arrow)))))

;; set save file for abbrev mode (i think ess is somehow using it???)
(custom-set-variables '(abbrev-file-name (expand-file-name "savefile/abbrev_defs" prelude-personal-dir)))

;; newort security manager
(setq nsm-settings-file (expand-file-name "savefile/network-security.data" prelude-personal-dir))


(if (equal system-type 'windows-nt)
    (add-to-list 'default-frame-alist '(fullscreen . maximized))
  (add-to-list 'default-frame-alist '(fullscreen . fullboth))) ;; start in fullscreen mode (toggle with <F11>)

(defun gearup--immediately-show-register-preview ()
  "Do not wait before showing register content preview."
  (custom-set-variables '(register-preview-delay 0)))

(defun gearup-toggle-case ()
  "Toggle case of current word or text in region and move over it.
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

(global-set-key (kbd "M-c") 'gearup-toggle-case)

(defun gearup--enable-fast-mark-ring-cycling ()
  "Allow for fast mark ring cycling with <C-u C-SPC> (first) <C-SPC> (next)."
  (setq set-mark-command-repeat-pop 1))

(defun gearup--set-font-size-12 ()
  (set-face-attribute 'default nil :height 120))

(defun gearup-ediff---make-split-window-horizontally()
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-merge-split-window-function 'split-window-horizontally))

(defun gearup--set-utf-8-with-signature-coding-system-mode-line-mnemonic-to-B ()
  "Set the mode line indicator mnemonic for utf-8-with-signature to \"B\"."
  (coding-system-put 'utf-8-with-signature :mnemonic 66))

(defun gearup--set-preferred-coding-system-utf-8 ()
  (prefer-coding-system 'utf-8))

(defun gearup-force-utf-8-for-read ()
  (setq-local coding-system-for-read 'utf-8))

(defun gearup-force-utf-8-for-write ()
  (interactive)
  (setq-local coding-system-for-write 'utf-8))

(defun gearup-force-utf-8-with-signature-for-write ()
  (interactive)
  (setq-local coding-system-for-write 'utf-8-with-signature))

(defun gearup-force-utf-8-with-signature-for-read ()
  (interactive)
  (setq-local coding-system-for-read 'utf-8-with-signature))

(defun gearup-try-get-home-dir-windows ()
  "Returns environment variable HOME if set. Otherwise guess Wolfgang's standard wra directory"
  (let ((home (getenv "HOME")))
    (if home
        (if (string= (substring home -2) "\\")
            home
          (concat home "\\"))
      "c:\\Users\\wra\\")))

(defun wra-try-get-home-dir ()
  "Returns environment variable HOME if set. Otherwise guess Wolfgang's standard wra directory"
  (if (equal system-type 'windows-nt)
      (gearup-try-get-home-dir-windows)
    (getenv "HOME")))

(setq default-directory (wra-try-get-home-dir))

(gearup--set-font-size-12)
(gearup-ediff---make-split-window-horizontally)
(gearup--set-preferred-coding-system-utf-8)
(gearup--set-utf-8-with-signature-coding-system-mode-line-mnemonic-to-B)
(gearup--enable-fast-mark-ring-cycling)
(gearup--immediately-show-register-preview)
(gearup-base--show-fringe-indicators-in-visual-line-mode)
(gearup--assert-savefile-dir-exists)

(provide 'gearup-base)
;;; gearup-base.el ends here
