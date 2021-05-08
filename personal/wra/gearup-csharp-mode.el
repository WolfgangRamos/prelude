(prelude-require-package 'csharp-mode)
(prelude-require-package 'lsp-mode)
(require 'csharp-mode)

(add-hook 'csharp-mode-hook 'gearup-disable-whitespace-mode)
;; TODO re-register hook when yasnippet is loaded
;;(add-hook 'csharp-mode-hook 'yas-minor-mode-on)
(add-hook 'csharp-mode-hook #'lsp)

(provide 'gearup-csharp-mode)
