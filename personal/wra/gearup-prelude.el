;;; gearup-prelude.el --- Prelude mode configuration

;;; Commentary:

;;; Code:

(defun gearup-prelude--disable-global-diff-hl-mode ()
  "Disable global-diff-hl-mode loaded by prelude."
  (global-diff-hl-mode 0))

(defun gearup-prelude--set-eshell-as-default-shell ()
  "Set eshell as default shell in prelude's keymap."
  (define-key prelude-mode-map (kbd "C-c t") 'eshell))

(defun gearup-prelude--disable-beacon-mode ()
  "Disable beacon mode."
  (beacon-mode -1))

(defun gearup-prelude--disable-whitespace-cleanup-on-save ()
  "Disable prelude's auto whitespace cleanup on save feature."
  (setq prelude-clean-whitespace-on-save nil))

(define-togglefun gearup-toggle-prelude-auto-save-command
  "Toggle `prelude-auto-save' to disable `prelude-auto-save-command'."
  (and (local-variable-p 'prelude-auto-save) prelude-auto-save)
  (setq-local prelude-auto-save t)
  (setq-local prelude-auto-save nil)
  "Prelude auto save %s")

(gearup-prelude--disable-global-diff-hl-mode)
(gearup-prelude--set-eshell-as-default-shell)
(gearup-prelude--disable-whitespace-cleanup-on-save)
(gearup-prelude--disable-beacon-mode)

;; remove bindings
(define-key prelude-mode-map (kbd "C-c y") nil) ;; my expand-yasnippet command
(define-key prelude-mode-map (kbd "C-c s") nil)
(define-key prelude-mode-map [(shift return)] nil) ;; masks org-table-copy-down
(define-key prelude-mode-map [(meta shift up)] nil)
(define-key prelude-mode-map [(meta shift down)] nil)

;; tips
(push "Hit <C-Backsp> to backward kill line." prelude-tips)
(push "Hit <C-c e> to replace preceding sexp with its value." prelude-tips)
(push "Hit <C-+> to increase font size." prelude-tips)
(push "Hit <C--> to decrease font size." prelude-tips)

(provide 'gearup-prelude)
;;; gearup-prelude.el ends here
