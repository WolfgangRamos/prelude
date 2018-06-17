;;; wra-dired.el --- My dired config

;;; Commentary:

;;; Code

;; dired
(require 'dired)

(defun gearup--allow-edit-file-permissions ()
  "Make file permisions editable in wdired mode."
  (setq wdired-allow-to-change-permissions t))

(defun gearup--use-system-trash ()
  "Make deletion in dired move files to system trash."
  (setq delete-by-moving-to-trash t))
  
(defun gearup--use-other-dired-buffer-as-default-target-directory ()
  "Make copy, move commands use other dired buffer as target (if there is one)."
  (setq dired-dwim-target t))
  
(with-eval-after-load 'wdired 
  (gearup--allow-edit-file-permissions)
  (gearup--use-system-trash)
  (gearup--use-other-dired-buffer-as-default-target-directory))
  
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
;; As of Emacs 26.1 dired+ is no longer available from MELPA.
;; Dired+ is added as git submodule to gearup.
(let ((generated-autoload-file (expand-file-name "dired-plus/dired+-autoloads.el" gearup-foreign-modules-dir)))
  (update-directory-autoloads (expand-file-name "dired-plus" gearup-foreign-modules-dir)))
(byte-recompile-directory (expand-file-name "dired-plus" gearup-foreign-modules-dir) 0)

(require 'dired+-autoloads)
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
