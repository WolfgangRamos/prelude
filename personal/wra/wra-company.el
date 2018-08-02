;;; wra-company.el --- My Company Configuration

;;; Commentary

;;; Code
(prelude-require-packages '(company))
(prelude-require-package 'helm-company)
(require 'company)


(custom-set-variables '(company-idle-delay nil))

(defun gearup-company--set-company-keybindings ()
  "Set keybindings for `company-mode'."
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-mode-map (kbd "M-#") 'company-complete))

(gearup-company--set-company-keybindings)

(provide 'wra-company)
;;; wra-company.el ends here
