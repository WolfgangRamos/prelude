;;; wra-restclient.el --- My restclient Configuration

;;; Commentary

;;; Code

;; disable line wrap in response buffer
(add-hook 'restclient-response-loaded-hook (lambda () (setq truncate-lines t)))

(provide 'wra-restclient)
;;; wra-cdlatex.el ends here
