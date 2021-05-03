;;; gearup-hl-tags-mode.el --- Highlight tags mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'hl-tags-mode-loaddefs)

(defun gearup-hl-tags-mode--set-face ()
  "Set face used to higlight tags."
  (set-face-attribute 'hl-tags-face nil :background "turquoise"))

(with-eval-after-load 'hl-tags-mode
  (gearup-hl-tags-mode--set-face))

(provide 'gearup-hl-tags-mode)
;;; gearup-hl-tags-mode.el ends here.
