;;; gearup-magit.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(require 'gearup-utils)
(require 'magit)

(defun gearup-magit--commit-disable-automatic-diff ()
  "Do not show diffs in commit view."
  (remove-hook 'server-switch-hook 'magit-commit-diff))

(defun gearup-magit--disable-vc-for-git-repos ()
  "Disable vc for git repos."
  (setq vc-handled-backends (delq 'Git vc-handled-backends)))

(defun gearup-magit--debug-hook-performance ()
  "Toggle magit refresh output verbose."
  (interactive)
  (setq magit-refresh-verbose t))

(define-togglefun gearup-magit--toggle-revision-buffer-follow-log
  "Toggle revision buffer follow point in log buffer."
  (member 'magit-log-maybe-update-revision-buffer magit-section-movement-hook)
  (add-hook 'magit-section-movement-hook
            'magit-log-maybe-update-revision-buffer)
  (remove-hook 'magit-section-movement-hook
               'magit-log-maybe-update-revision-buffer)
  "Revision buffer follow log %s.")

(define-togglefun gearup-magit--toggle-blob-buffer-follow-log
  "Let blob buffers follow point in log buffer."
  (member 'magit-log-maybe-update-blob-buffer magit-section-movement-hook)
  (add-hook 'magit-section-movement-hook
            'magit-log-maybe-update-blob-buffer)
  (remove-hook 'magit-section-movement-hook
               'magit-log-maybe-update-blob-buffer)
  "Blob buffer follow log %s.")

(gearup-magit--commit-disable-automatic-diff)
(gearup-magit--disable-vc-for-git-repos)

;; tips
(setq prelude-tips
      (append prelude-tips
              '("Hit <C-c C-d> in magit commit to show diff.")))

(provide 'gearup-magit)
;;; gearup-magit.el ends here
