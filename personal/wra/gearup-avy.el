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
(global-set-key (kbd "C-.") 'avy-goto-word-1)

(provide 'gearup-avy)
;;; gearup-avy.el ends here
