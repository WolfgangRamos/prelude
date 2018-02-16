(defmacro define-togglefun (function-name doc-string test on-action off-action msg-format-string)
"Define interactive function to perform a toggle operation based on TEST.

TEST must be an (unquoted) expression. If TEST evaluates to non-nil OFF-ACTION is evaluated. Otherwise ON-ACTION. DOC-STRING is the doc-string of the generated function. MSG-FORMAT-STRING is a format string used to generate a message in the minibuffer. MSG-FORMAT-STRING can contain one %s placeholder. This placeholder will be filled with the string 'enabled' or 'disabled'.

If the generated function is called with one prefix arg (ie. C-u), ON-ACTION is evaluated no matter what TEST returns"
(list 'defun function-name (list 'arg)
  doc-string
  (list 'interactive "p")
  (list 'if (list 'or (list '= 'arg 4) (list 'not test))
    (list 'progn 
      on-action 
      (list 'message msg-format-string "enabled"))
    (list 'progn)
      off-action
      (list 'message msg-format-string "disabled"))))


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

(define-tooglefun gearup-magit--toggle-revision-buffer-follow-log
  "Toggle revision buffer follow point in log buffer."
  (not (member 'magit-log-maybe-update-revision-buffer magit-section-movement-hook))
  (add-hook 'magit-section-movement-hook
            'magit-log-maybe-update-revision-buffer)
  (remove-hook 'magit-section-movement-hook
               'magit-log-maybe-update-revision-buffer)
  "Revision buffer follow log %s.")
            
(defun gearup-magit--log-enable-blob-buffee-follow ()
  "Let blob buffers follow point in log buffer."
  (add-hook 'magit-section-movement-hook
            'magit-log-maybe-update-blob-buffer))
;; tips
(setq prelude-tips 
  (append prelude-tips
    '("Hit <C-c C-d> in magit commit to show diff.")))