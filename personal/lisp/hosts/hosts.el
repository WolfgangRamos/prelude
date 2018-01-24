;;; hosts.el --- Prelude mode configuration

;;; Commentary:

;; This package provides a function that loads a host-specific init
;; file. The init file is identified by name. The naming pattern is
;; <hostname>.el. The files recide in host-config directory.

;;; Code:
(defcustom hosts-default-config-file-dir nil
 "Directory for default host config files.
A files is considered to be a default host config file if it is located in the `hosts-default-config-file-dir' and has the name \"<host-name>.el\". If `hosts-default-config-file-dir' is a relative path, it is assumed to be in `user-emacs-directory' or in `prelude-personal-dir' if this variable is set. Note that hosts names are not cases sensitive. Therefore the case of \"<host-name>.el\" is ignored. For conditionally loading arbitrary lists of lisp files by host name see TODO.")

(defcustom hosts-enable-default-host-config-files nil
  "If non-nil enable loading default host config file if available.
  For information on default host config files see `hosts-default-config-file-dir'.")
  
(defcustom hosts-config-files-alist nil
 "Alist of files to load, keyed by host name.
  Each element must be a list with the car of the list beeing the host-name and the cdr beeing a list of files to load. If a file is not given by an absolute path, it is assumed to be in `user-emacs-directory'.")

(defcustom hosts-enable-config-files-alist nil
  "If non-nil enable loading files in `hosts-config-files-alist'.")

(defun hosts--get-default-config-file-dir ()
  "Get default config file directory.
  If prelude is enabled use a directory in prelude-personal-dir."
  (let ((dir-name "host-configs")
        (base-path 
         (if (featurep 'prelude)
             prelude-personal-dir
           user-emacs-directory)))
    (expand-file-name dir-name base-path)))

(defun hcf--load-default-host-config-file ()
  "Loads host-specific init file.
The default host config file is identified by name. The naming pattern is
<hostname>.el. The files are searched in `hosts-default-config-file-dir'."
  (let ((filename
         (expand-file-name
          system-name
          (expand-file-name hosts-default-config-file-dir))))
    (when (file-exists-p (concat filename ".el"))
      (message "Loading host init file %s" (concat filename ".el"))
      (condition-case
          err
          (load filename)
        (error
         (message "Error while loading host init file %s" filename))))))

(gearup-require-host-config (expand-file-name "host-configs" prelude-personal-dir))

(defun hcf--expand-default-config-file-dir (path)
  "Expand PATH to an absolute path if necessary."
  (let (default-directory 
        (or 
         (and 
          (boundp prelude-personal-dir)
          prelude-personal-dir)
         ))))


(defun hcf-load-config-files ()
  "Load host specific config files.
  Which files are loaded is specified by `hosts-enable-default-host-config-files' and ` hosts-enable-config-files-alist'."
  (let (dir)
   (when hosts-default-config-file-dir
     (setq dir (hcf--expand-default-config-file-dir
                hosts-default-config-file-dir))
     (hcf--load-default-host-config-file dir))
   (when )))

(provide 'hosts)
;;; hosts.el ends here
