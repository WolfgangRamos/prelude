;;; gearup-undo-tree.el --- Prelude mode configuration

;;; Commentary:

;;; Code:

;; clear a buffer's undo tree
(defun gearup-clear-undo-tree ()
  "Clear current buffer's undo-tree.
Undo-tree can cause problems with file encoding when characters
are inserted that cannot be represented using the files current
encoding. This is even the case when characters are only
temporarily inserted, e.g. pasted from another source and then
instantly deleted. In these situations it can be necessary to
clear the buffers undo-tree before saving the file."
  (interactive)
  (let ((buff (current-buffer)))
    (if (local-variable-p 'buffer-undo-tree)
        (if (y-or-n-p "Clear buffer-undo-tree? ")
            (progn
              (setq buffer-undo-tree nil)
              (message "Cleared undo-tree of buffer: %s" (buffer-name buff)))
          (message "Cancelled clearing undo-tree of buffer: %s" (buffer-name buff)))
      (error "Buffer %s has no local binding of `buffer-undo-tree'" (buffer-name buff)))))

(push "Hit <d> in undo-tree-visualizer to toggle diff display." prelude-tips)
(push "Hit <t> in undo-tree-visualizer to toggle display of timestamps." prelude-tips)
(push "Hit <q> in undo-tree-visualizer to exit visualizer at selected undo node." prelude-tips)
(push "Hit <C-q> in undo-tree-visualizer to exit visualizer without changing undo node." prelude-tips)
(push "Hit <f> in undo-tree-visualizer to select next branch." prelude-tips)
(push "Hit <b> in undo-tree-visualizer to select previous branch." prelude-tips)

;; undo tree appears to cause overflows
(global-undo-tree-mode -1)

(provide 'gearup-undo-tree)
;;; gearup-undo-tree.el ends here
