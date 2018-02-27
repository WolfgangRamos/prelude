;;; gearup-smart-mode-line.el --- Prelude mode configuration

;;; Commentary:

;;; Code:

(prelude-require-package 'smart-mode-line)
(prelude-require-package 'smart-mode-line-powerline-theme)
(prelude-require-package 'rich-minority)
(prelude-require-package 'diminish)

(setq sml/theme 'smart-mode-line-light-powerline)
(sml/setup)

(defun gearup-sml--show-eol-indicator-in-mode-line ()
  "Show end of line indicator in mode line."
  (setq sml/show-eol t))

(gearup-sml--show-eol-indicator-in-mode-line)

;; hide modes form mode line
(diminish 'guru-mode)
(diminish 'whitespace-mode)
(diminish 'smartparens-mode)
(diminish 'prelude-mode)

(provide 'gearup-smart-mode-line)
;;; gearup-smart-mode-line.el ends here
