;;; wra-company.el --- My Company Configuration

;;; Commentary

;;; Code
(prelude-require-packages '(company))
(require 'company)
(prelude-require-package 'helm-company)

(setq company-idle-delay 0.1)

(define-key company-mode-map (kbd "M-j") 'helm-company)

(provide 'wra-company)
;;; wra-company.el ends here
