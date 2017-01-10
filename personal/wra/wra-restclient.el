;;; wra-restclient.el --- My restclient Configuration

;;; Commentary:

;;; Code

;; disable line wrap in response buffer
(add-hook 'restclient-response-loaded-hook
          (lambda ()
            (setq truncate-lines t)
            (whitespace-mode 0)))

(provide 'wra-restclient)
;;; wra-restclient.el ends here
