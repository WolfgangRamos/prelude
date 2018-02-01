;;; lambda.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(require 'vimgolf)

(defun host-lambda-set-emacs-server-authentication-directory ()
  "set auth directory for emacs daemon"
  (setq server-auth-dir (expand-file-name "server/" prelude-personal-dir)))

(defun host-lambda-set-omnisharp-path ()
  "Set path to omnisharp executable on host lambda."
  (setq omnisharp-server-executable-path "C:\\Users\\wra\\Downloads\\omnisharp-win-x86\\OmniSharp.exe"))

(host-lambda-set-emacs-server-authentication-directory)
(host-lambda-set-omnisharp-path)

(message "Loaded host config for lambda.")

(provide 'lambda)
;;; lambda.el ends here
