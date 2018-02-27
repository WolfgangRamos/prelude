;;; gearup-prelude.el --- Prelude mode configuration

;;; Commentary:

;;; Code:

(defun gearup-prelude--disable-global-diff-hl-mode ()
  "Disable global-diff-hl-mode loaded by prelude."
  (global-diff-hl-mode 0))

(gearup-prelude--disable-global-diff-hl-mode)

;; remove bindings
(define-key prelude-mode-map (kbd "C-c y") nil)
(define-key prelude-mode-map (kbd "C-c s") nil)

;; tips
(push "Hit <C-Backsp> to backward kill line." prelude-tips)
(push "Hit <C-c e> to replace preceding sexp with its value." prelude-tips)
(push "Hit <C-+> to increase font size." prelude-tips)
(push "Hit <C--> to decrease font size." prelude-tips)

(provide 'gearup-prelude)
;;; gearup-prelude.el ends here
