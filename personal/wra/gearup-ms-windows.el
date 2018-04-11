;;; gearup-ms-windows.el --- Adjust emacs configuration for use on MS windows

;;; Commentary:

;;; Code
(defun gearup-w32--recentf-save-wrapper (terminal)
  "Save recentf list."
  (recentf-save-list))

(defun gearup-w32--save-recentf-on-client-exit ()
  "Save `recentf' files when client frame is closed.

Windows doesn't know how to gracefully exit emacs daemon. So we
save recentf list not on emacs exit, but on closing last client frame."
  (add-hook 'delete-terminal-functions 'gearup-w32--recentf-save-wrapper))

(when (equal system-type 'windows-nt)
  (gearup-w32--save-recentf-on-client-exit))

(defun gearup-w32-maximize-frame ()
  "Maximize the current frame (windows only)"
  (interactive)
  (w32-send-sys-command 61488))

;; put Msys2 on path (if existing)
(defun gearup-for-windows ()
  "Configure Emacs for windows.

This command does nothing if the `system-type' is not `windows-nt'."
  (when (equal system-type 'windows-nt)
    (gearup-windows-set-path)
    ;; allow magit to do https authentication by GUI
    (setenv "GIT_ASKPASS" "git-gui--askpass")))

(setq gearup-windows-msys2-default-directories '("C:\\msys64\\usr\\bin" "C:\\msys64\\mingw64\\bin"))

(defun gearup-windows-set-path ()
  "Prepend msys2 bin path (if existing) to PATH environment variable."
  (let ((paths gearup-windows-msys2-default-directories))
    (while (car-safe paths)
      (when (file-exists-p (car-safe paths))
        (setenv "PATH" (concat (car paths) ";" (getenv "PATH"))))
      (setq paths (cdr-safe paths)))))

;; actually perform the changes to the configuration
(gearup-for-windows)



;; claim some keybindings (this is planned to work again in Emacs 26)
;;(w32-register-hot-key [C-=])

(provide 'gearup-ms-windows)
;;; gearup-ms-windows.el ends here
