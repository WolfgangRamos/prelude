;;; gearup-host-config.el --- Prelude mode configuration

;;; Commentary:

;; This package provides a function that loads a host-specific init
;; file. The init file is identified by name. The naming pattern is
;; <hostname>.el. The files recide in host-config directory.

;;; Code:

(defun gearup-require-host-config (dir)
  "Loads host-specific init file.
The init file is identified by name. The naming pattern is
<hostname>.el. The files are searched in host-config directory
DIR. If DIR is a relative path, it is assumed to be in
`user-emacs-directory'."
  (let ((filename
         (expand-file-name system-name
                           (expand-file-name dir))))
    (when (file-exists-p (concat filename ".el"))
      (message "Loading host init file %s" (concat filename ".el"))
      (condition-case
          err
          (load filename)
        (error
         (message "Error while loading host init file %s" filename))))))

(gearup-require-host-config (expand-file-name "host-configs" prelude-personal-dir))

(provide 'gearup-host-config)
;;; gearup-host-config.el ends here
