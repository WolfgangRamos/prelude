;;; gearup-bookmarkp.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
;; as of Emacs 26.1 bookmark+ can only be opatined from emacswiki
;; bookmark+ is now added as git submodule to gearup.
(let ((generated-autoload-file (expand-file-name "bookmark-plus/bookmark+-autoloads.el" gearup-foreign-modules-dir)))
  (update-directory-autoloads (expand-file-name "bookmark-plus" gearup-foreign-modules-dir)))
(byte-recompile-directory (expand-file-name "bookmark-plus" gearup-foreign-modules-dir) 0)
(require 'bookmark+-autoloads)

(provide 'gearup-bookmarkp)
;;; gearup-bookmarkp.el ends here
