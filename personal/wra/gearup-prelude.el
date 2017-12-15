;;; gearup-prelude.el --- Prelude mode configuration

;;; Commentary:

;;; Code:


;; remoce bindings
(define-key prelude-mode-map (kbd "C-c y") nil)

;; tips

(push "Hit <C-Backsp> to backward kill line." prelude-tips)
(provide 'gearup-prelude)
;;; gearup-prelude.el ends here
