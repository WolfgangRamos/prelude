;;; gearup-cc-mode.el --- CC-mode configuration

;;; Commentary:

;;; Code:
(setq-default sp-escape-quotes-after-inser nil)

(add-hook 'c-mode-hook 'lsp)
(provide 'gearup-cc-mode)
;;; gearup-cc-mode.el ends here
