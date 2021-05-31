;;; gearup-ms-windows.el --- Adjust emacs configuration for use on MS windows

;;; Commentary:

;;; Code
(defun gearup-w32--recentf-save-wrapper (terminal)
  "Save recentf list."
  (recentf-save-list))

(when (equal system-type 'windows-nt)
  (add-hook 'delete-terminal-functions 'gearup-w32--recentf-save-wrapper) ; Windows doesn't know how to gracefully exit emacs daemon. So we save recentf list not on emacs exit, but on closing last client frame."
  (setenv "GIT_ASKPASS" "git-gui--askpass")) ; allow magit to do https authentication by GUI

(prelude-require-packages '(powershell w32-browser))
(require 'w32-browser)

(provide 'gearup-ms-windows)
;;; gearup-ms-windows.el ends here
