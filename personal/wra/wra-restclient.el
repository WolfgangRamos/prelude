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

(provide 'wra-restclient)
;;; wra-restclient.el ends here
