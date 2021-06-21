;;; wra-company.el --- My Company Configuration

;;; Commentary

;;; Code
(prelude-require-packages '(company))
(prelude-require-package 'helm-company)
(require 'company)
(prelude-require-package 'helm-company)


(custom-set-variables '(company-idle-delay nil))
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-mode-map (kbd "C-;") 'company-complete)

(define-key company-mode-map (kbd "C-M-;") 'helm-company)

(provide 'wra-company)
;;; wra-company.el ends here
