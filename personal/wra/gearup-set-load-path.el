;;; gearup-set-load-path.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(defun gearup--expand-file-names (files directory)
  "Expand file names in FILES in DIRECTORY.

FILES must be a list of strings."
  (let (names)
    (dolist (name files (reverse names))
      (setq names (cons (directory-file-name (expand-file-name name directory)) names)))))

(setq load-path
      (append
       (gearup--expand-file-names
        '(;;"lisp/org-mode/lisp"
          ;;"lisp/org-mode/contrib/lisp"
          "lisp/hydra"
          "wra"
          "modules/viztab"
          "modules/melpa/package-build"
          "lisp/hl-tags-mode"
          "lisp/essh"
          "lisp/vimgolf"
          "lisp/x-dict")
        prelude-personal-dir)
       load-path))

(provide 'gearup-set-load-path)
;;; gearup-set-load-path.el ends here
