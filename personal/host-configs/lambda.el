(require 'vimgolf)
(require 'gearup-omnisharp)

(defun host-lambda-set-emacs-server-authentication-directory ()
  "set auth directory for emacs daemon"
  (setq server-auth-dir (expand-file-name "server/" prelude-personal-dir)))

(host-lambda-set-emacs-server-authentication-directory)
(gearup-omnisharp--setup-omnisharp-completion (expand-file-name "omnisharp-server/v1.26.3/OmniSharp.exe" prelude-personal-dir))

(gearup-gnus--set-gnus-init-file "lambda.gnus")

(message "Loaded host config for lambda.")
