;;; gearup-nxml-mode.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
;;(require 'nxml-mode)
;;(require 'hideshow)
;;(require 'sgml-mode)
;;(require 'gearup-hl-tags-mode)

(add-hook 'nxml-mode-hook 'gearup-disable-whitespace-mode)
(add-hook 'nxml-mode-hook 'yas-minor-mode-on)

(defun gearup-nxml--disable-auto-validation ()
  "Disable Validation for XML buffers."
  (custom-set-variables '(rng-nxml-auto-validate-flag nil)))

(defun gearup-nxml--setup-hideshow ()
  "Setup hideshow-mode for XML."
  (require 'hideshow)
  (require 'sgml-mode)
  (add-to-list 'hs-special-modes-alist
               '(nxml-mode
                 "<!--\\|<[^/>]*[^/]>"
                 "-->\\|</[^/>]*[^/]>"
                 "<!--"
                 sgml-skip-tag-forward
                 nil))
  (add-hook 'nxml-mode-hook 'hs-minor-mode))

(defun gearup-nxml--set-child-indent-two-spaces ()
  "Set indentation of child elements."
  (setq nxml-child-indent 2))

(with-eval-after-load 'nxml-mode
  (gearup-nxml--set-child-indent-two-spaces)
  (gearup-nxml--setup-hideshow)
  (gearup-nxml--disable-auto-validation))

(setq rng-complete-end-tags-after-< nil)

(defun gearup-nxml--increase-performance-for-large-buffers ()
  "Increase performance of nxml mode in large buffers."
   ;; disable validation
  (when (> (buffer-size) 80000)
    (turn-off-show-smartparens-mode)
    (hl-tags-mode 1)
    (flycheck-mode -1)))

(add-hook 'nxml-mode-hook
          'gearup-nxml--increase-performance-for-large-buffers)

(provide 'gearup-nxml-mode)
;;; gearup-nxml-mode.el ends here
