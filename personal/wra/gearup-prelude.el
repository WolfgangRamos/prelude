;;; gearup-prelude.el --- Prelude mode configuration

;;; Commentary:

;;; Code:


;; remove bindings
(define-key prelude-mode-map (kbd "C-c y") nil)
(define-key prelude-mode-map (kbd "C-c s") nil)

(defun gearup-prelude--disable-whitespace-cleanup-on-save ()
  "Disable prelude's auto whitespace cleanup on save feature."
  (remove-hook 'before-save-hook 'prelude-cleanup-maybe)
  (setq prelude-clean-whitespace-on-save nil))

(gearup-prelude--disable-whitespace-cleanup-on-save)

;; tips
(push "Hit <C-Backsp> to backward kill line." prelude-tips)
(push "Hit <C-c e> to replace preceding sexp with its value." prelude-tips)
(push "Hit <C-+> to increase font size." prelude-tips)
(push "Hit <C--> to decrease font size." prelude-tips)

(provide 'gearup-prelude)
;;; gearup-prelude.el ends here
