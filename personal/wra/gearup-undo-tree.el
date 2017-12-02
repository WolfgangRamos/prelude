;;; gearup-undo-tree.el --- Prelude mode configuration

;;; Commentary:

;;; Code:

;; clear a buffer's undo tree
(defun gearup-clear-undo-tree ()
  (interactive)
  (setq buffer-undo-tree nil))

(provide 'gearup-undo-tree)
;;; gearup-undo-tree.el ends here
