;;; gearup-avy.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'avy)
(require 'avy)

(defun gearup-avy-goto-line ()
  (interactive)
  (avy-goto-line)
  (crux-move-beginning-of-line 1))

(key-chord-define-global "jl" 'gearup-avy-goto-line)

(provide 'gearup-avy)
;;; gearup-avy.el ends here
