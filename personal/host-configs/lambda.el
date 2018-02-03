(require 'vimgolf)
(require 'gearup-omnisharp)

(defun host-lambda-set-emacs-server-authentication-directory ()
  "set auth directory for emacs daemon"
  (setq server-auth-dir (expand-file-name "server/" prelude-personal-dir)))

(host-lambda-set-emacs-server-authentication-directory)
(gearup-omnisharp--setup-omnisharp-completion "C:\\Users\\wra\\Downloads\\omnisharp-win-x86\\OmniSharp.exe")

(message "Loaded host config for lambda.")
