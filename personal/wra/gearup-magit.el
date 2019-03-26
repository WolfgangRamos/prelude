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

(magit-define-popup-switch 'magit-rebase-popup ?n "No Fast-Forward" "--no-ff")

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

(defun gearup-magit-generate-patch-dwim (range paths &optional filename)
  (interactive
   (let* ((repo-root-dir default-directory)
          (commit-range-end (if (region-active-p)
                                (save-excursion
                                  (goto-char (region-beginning))
                                  (magit-commit-at-point))
                              (magit-commit-at-point)))
          (commit-range-start (if (region-active-p)
                                  (save-excursion
                                    (goto-char (region-end))
                                    (magit-commit-at-point))
                                nil))
          (ticket-id (or
                      (gearup-magit--get-ticket-id-from-commit commit-range-end)
                      (gearup-magit--get-ticket-id-from-branch-name)))
          (range (read-string "Range: " (format "%s^..%s" (or commit-range-start commit-range-end) commit-range-end)))
          (preselected-file (if (file-exists-p "DefaultEntities.xml")
                                "DefaultEntities.xml"
                              "source/vs2010/projects/FlsControlsForms/VisiTourClient/EmbeddedLayouts/LayoutControlDefinition.xml"))
          (paths (helm-comp-read "Files to include: " (split-string (shell-command-to-string "git ls-files") "\n" t) :marked-candidates t :initial-input preselected-file))
          (filename (or (and ticket-id (format "%s%s.patch" repo-root-dir ticket-id))
                        (helm-read-file-name "Save patch to: " :initial-input repo-root-dir))))
     (list range paths filename)))
  (let* ((paths-present (and (listp paths) (not (null paths))))

         (buffername (concat "*Patchfile " range "*")))
    (when (and (stringp range) (not (string-empty-p range)))
      (if paths-present
          (call-process "git" nil buffername nil
                        "diff"
                        "--unified=5"
                        "--binary"
                        range
                        "--"
                        (mapconcat 'identity paths " "))
        (call-process "git" nil buffername nil
                      "diff"
                      "--unified=5"
                      "--binary"
                      range))
      (when (get-buffer buffername)
        (switch-to-buffer-other-window buffername)
        (when (stringp filename)
          (write-file filename))))))

(defun gearup-magit--get-ticket-id-from-commit (commit-hash)
  (let* ((commit-msg (shell-command-to-string (format "git --no-pager log -1 --format=format:'%%B' %s" commit-hash)))
         (commit-msg-head-line (if (stringp commit-msg)
                                   (car (split-string commit-msg "[\r\n]"))
                                 nil)))
    (if (and (stringp commit-msg-head-line)
             (string-match "^[\t ]*\(ANF-[0-9]\\{5\\}-[0-9A-Z]\\{6\\}\)" commit-msg-head-line))
        (match-string 1)
      nil)))

(defun gearup-magit--get-ticket-id-from-branch-name ()
  (let ((branch-name (shell-command-to-string "git rev-parse --abbrev-ref HEAD")))
    (if (string-match "^ANF-[0-9]\\{5\\}-[0-9A-Z]\\{6\\}" branch-name)
        (match-string 0 branch-name)
      nil)))

(defun gearup-magit--status-register-keybindings ()
  (define-key magit-status-mode-map (kbd "C-c f p") 'gearup-magit-generate-patch-dwim))
(add-hook 'magit-status-mode-hook 'gearup-magit--status-register-keybindings)

(provide 'gearup-magit)
;;; gearup-magit.el ends here
