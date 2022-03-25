;;; gearup-avy.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'avy)
(require 'avy)

(defun gearup-avy-goto-line ()
  (interactive)
  (avy-goto-line)
  (crux-move-beginning-of-line 1))

(global-set-key (kbd "C-.") 'avy-goto-char-timer)
(define-key isearch-mode-map (kbd "C-.") 'avy-isearch)

(provide 'gearup-avy)
;;; gearup-avy.el ends here
