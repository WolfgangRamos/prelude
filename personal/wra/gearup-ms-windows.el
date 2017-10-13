;;; gearup-ms-windows.el --- Adjust emacs configuration for use on MS windows

;;; Commentary:

;;; Code

;; put Msys2 on path (if existing)
(defun gearup-for-windows ()
  "Configure Emacs for windows.

This command does nothing if the `system-type' is not `windows-nt'."
  (when (equal system-type 'windows-nt)
    (gearup-windows-set-path)))

(setq gearup-windows-msys2-default-directories '("C:\\msys64\\usr\\bin"))

(defun gearup-windows-set-path ()
  "Prepend msys2 bin path (if existing) to PATH environment variable."
  (let ((paths gearup-windows-msys2-default-directories)
        (found nil))
    (while (and (not found) (car-safe paths))
      (if (file-exists-p (car-safe paths))
          (progn
            (setenv "PATH" (concat (car paths) ";" (getenv "PATH")))
            (setq found t))
        (setq paths (cdr-safe paths))))))

;; actually perform the changes to the configuration
(gearup-for-windows)

(provide 'gearup-ms-windows)
;;; gearup-ms-windows.el ends here
