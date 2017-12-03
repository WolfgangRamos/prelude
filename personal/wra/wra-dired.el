;;; wra-dired.el --- My dired config

;;; Commentary:

;;; Code

;; dired
(require 'dired)
(prelude-require-package 'ace-window)

;; configure default shell commands for (a)synchronous shell commands with ! or &
(setq dired-guess-shell-alist-user
      '(("\\.pdf\\'" "okular")))
        ;; ("\\.eps\\'" "evince")
        ;; ("\\.jpe?g\\'" "eog")
        ;; ("\\.png\\'" "eog")
        ;; ("\\.gif\\'" "eog")
        ;; ("\\.xpm\\'" "eog")
        ;; ("\\.csv\\'" "libreoffice")
        ;; ("\\.tex\\'" "pdflatex" "latex")
        ;; ("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|ogv\\)\\'" "vlc")
        ;; ("\\.\\(?:mp3\\|flac\\)\\'" "rhythmbox")
        ;; ("\\.html?\\'" "firefox")
        ;; ("\\.cue?\\'" "audacious")))


;; Dired
;; adjust find-dired
(require 'find-dired)
(setq find-ls-option '("-print0 | xargs -0 ls -ld" . "-ld"))

;; find-file in specific buffer
(defun gearup-find-file-ace-window ()
  "Select a window."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (if (> (length (aw-window-list)) 1)
        (aw-select "" (lambda (window)
                        (aw-switch-to-window window)
                        (find-file file)))
      (find-file-other-window file))))

(define-key dired-mode-map "o" 'gearup-find-file-ace-window)


;; X-dired
(require 'dired-x)
(add-hook 'dired-load-hook
          (function (lambda () (load "dired-x"))))

;; dired+
(require 'dired+)
(diredp-toggle-find-file-reuse-dir 1)

;; borrowed from steve purcell
;;(require-package 'dired+)
;; (require-package 'dired-sort)

;;


;; (setq-default diredp-hide-details-initially-flag nil
;;               dired-dwim-target t)

;; (after-load 'dired
;; 			(require 'dired+)
;; 			(diredp-toggle-find-file-reuse-dir 1))
;;   (require 'dired-sort)
;;   (when (fboundp 'global-dired-hide-details-mode)
;;     (global-dired-hide-details-mode -1))
;;   (setq dired-recursive-deletes 'top)
;;   (define-key dired-mode-map [mouse-2] 'dired-find-file)
;;   (add-hook 'dired-mode-hook
;;             (lambda () (guide-key/add-local-guide-key-sequence "%"))))

(provide 'wra-dired)
;;; wra-dired.el ends here
