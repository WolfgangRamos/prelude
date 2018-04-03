;;; gearup-base.el --- Basic emacs configuration.

;;; Commentary:
;;; Anything not directly related to a significant emacs package.

;;; Code:
(set-language-environment "English")

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

(gearup--set-font-size-12)
(gearup-ediff---make-split-window-horizontally)
(gearup--set-preferred-coding-system-utf-8)
(gearup--set-utf-8-with-signature-coding-system-mode-line-mnemonic-to-B)

(provide 'gearup-base)
;;; gearup-base.el ends here
