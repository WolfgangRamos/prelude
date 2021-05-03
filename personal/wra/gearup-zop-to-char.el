;;; gearup-zop-to-char.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'zop-to-char)

(defun gearup-zop-to-char-reverse ()
  "Start zop to char in backward search mode."
  (interactive)
  (setq current-prefix-arg -1)
  (call-interactively 'zop-to-char))

(setq zop-to-char-kill-keys '(?\C-w))
(setq zop-to-char-mark-region-keys '(?\r ?\C- ))
(setq zop-to-char-copy-keys '(?\M-w))

(global-set-key (kbd "M-z") 'zop-to-char)
(global-set-key (kbd "M-Z") 'gearup-zop-to-char-reverse)

(provide 'gearup-zop-to-char)
;;; gearup-zop-to-char.el ends here
