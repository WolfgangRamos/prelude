;;; lambda.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
;; set auth directory for emacs daemon
(setq server-auth-dir (expand-file-name "server/" prelude-personal-dir))

(message "Loaded host config for lambda.")

(provide 'lambda)
;;; lambda.el ends here
