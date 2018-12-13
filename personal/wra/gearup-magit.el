;;; gearup-magit.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(require 'gearup-utils)
(require 'magit)
(prelude-require-package 'magit-svn)

(defun geraup-magit--revision-buffer-hide-additional-refs ()
  "Do not show parent commit ref in revision buffer."
  (custom-set-variables '(magit-revision-insert-related-refs nil)))

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

(define-togglefun gearup-magit--toggle-revision-buffer-follow-log-buffer
  "Toggle revision buffer follow point in log buffer."
  (member 'magit-log-maybe-update-revision-buffer magit-section-movement-hook)
  (add-hook 'magit-section-movement-hook
            'magit-log-maybe-update-revision-buffer)
  (remove-hook 'magit-section-movement-hook
               'magit-log-maybe-update-revision-buffer)
  "Revision buffer follow log %s.")

(define-togglefun gearup-magit--toggle-revision-buffer-follow-status-buffer
  "Toggle revision buffer follow point in status buffer."
  (member 'magit-status-maybe-update-revision-buffer magit-section-movement-hook)
  (add-hook 'magit-section-movement-hook
            'magit-status-maybe-update-revision-buffer)
  (remove-hook 'magit-section-movement-hook
               'magit-status-maybe-update-revision-buffer)
  "Status buffer follow log %s.")

(define-togglefun gearup-magit--toggle-blob-buffer-follow-log-buffer
  "Let blob buffers follow point in log buffer."
  (member 'magit-log-maybe-update-blob-buffer magit-section-movement-hook)
  (add-hook 'magit-section-movement-hook
            'magit-log-maybe-update-blob-buffer)
  (remove-hook 'magit-section-movement-hook
               'magit-log-maybe-update-blob-buffer)
  "Blob buffer follow log %s.")

(defun gearup-magit--bind-keys ()
  "Set keybindings for magit."
  (define-key magit-status-mode-map (kbd "C-c C-f") 'gearup-magit--toggle-revision-buffer-follow-status-buffer)
  (define-key magit-log-mode-map (kbd "C-c C-f") 'gearup-magit--toggle-revision-buffer-follow-log-buffer))

(defun gearup-magit--revision-buffer-wrap-lines ()
  "Turn on line wrapping in revision buffers."
  (add-hook 'magit-revision-mode-hook
            'visual-line-mode))

(defun gearup-magit--commit-disable-autofill ()
  "Disable auto-fill mode in commit message buffers."
  (remove-hook 'git-commit-setup-hook 'git-commit-turn-on-auto-fill))

(gearup-magit--commit-disable-automatic-diff)
(gearup-magit--disable-vc-for-git-repos)
(geraup-magit--revision-buffer-hide-additional-refs)
(gearup-magit--revision-buffer-wrap-lines)

(with-eval-after-load 'magit
  (gearup-magit--bind-keys))

;; tips
(setq prelude-tips
      (append prelude-tips
              '("Hit <C-c C-d> in magit commit to show diff.")))

(defun gearup-magit-generate-patch-dwim (range paths)
  (interactive
   (let* ((commit-hash (magit-commit-at-point))
          (range (read-string "Range: " (concat commit-hash "^.." commit-hash)))
          (paths (read-string "Included files/paths: " "source/vs2010/projects/FlsControlsForms/VisiTourClient/EmbeddedLayouts/LayoutControlDefinition.xml")))
     (list range paths)))
  (let ((paths-present (and (stringp paths) (not (string-empty-p paths))))
        (buffername (concat "*Patchfile " range "*")))
    (when (and (stringp range) (not (string-empty-p range)))
      (if paths-present
          (call-process "git" nil buffername nil
                        "diff"
                        "--unified=5"
                        "--binary"
                        range
                        "--"
                        paths)
          (call-process "git" nil buffername nil
                        "diff"
                        "--unified=5"
                        "--binary"
                        range))
      (when (get-buffer buffername) (switch-to-buffer-other-window buffername)))))

(defun gearup-magit--status-register-keybindings ()
  (define-key magit-status-mode-map (kbd "C-c f p") 'gearup-magit-generate-patch-dwim))
(add-hook 'magit-status-mode-hook 'gearup-magit--status-register-keybindings)

(provide 'gearup-magit)
;;; gearup-magit.el ends here
