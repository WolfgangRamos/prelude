;;; gearup-ms-windows.el --- Adjust emacs configuration for use on MS windows

;;; Commentary:

;;; Code


(when (equal system-type 'windows-nt)
  (setq w32-pass-lwindow-to-system t)
  (setq w32-pass-rwindow-to-system t)
  (setq w32-pass-apps-to-system t)
  
  (defun gearup-w32--recentf-save-wrapper (terminal)
    "Save recentf list."
    (recentf-save-list))

  (prelude-require-packages '(powershell w32-browser))
  (require 'w32-browser)

  ;; setting GPG related variables
  (custom-set-variables
   '(epg-gpg-home-directory "~/.gnupg")
   '(epg-gpg-program "c:/msys64/usr/bin/gpg.exe")
   '(epg-gpgconf-program "c:/msys64/usr/bin/gpgconf.exe"))

  (add-hook 'delete-terminal-functions 'gearup-w32--recentf-save-wrapper) ; Windows doesn't know how to gracefully exit emacs daemon. So we save recentf list not on emacs exit, but on closing last client frame."
  (setenv "GIT_ASKPASS" "git-gui--askpass")) ; allow magit to do https authentication by GUI

(provide 'gearup-ms-windows)
;;; gearup-ms-windows.el ends here
