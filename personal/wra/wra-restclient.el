;;; wra-restclient.el --- My restclient Configuration

;;; Commentary:

;;; Code

;; require restclient (install if necessary)
;;(prelude-require-package 'restclient)

;; disable line wrap in response buffer
(add-hook 'restclient-response-loaded-hook
          (lambda ()
            (setq truncate-lines t)
            (whitespace-mode 0)))

(add-hook 'restclient-mode-hook
          (lambda ()
            (yas-minor-mode 1)))
(provide 'wra-restclient)
;;; wra-restclient.el ends here
