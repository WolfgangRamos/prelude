(prelude-require-package 'csharp-mode)
(require 'csharp-mode)

(add-hook 'csharp-mode-hook 'gearup-disable-whitespace-mode)
(add-hook 'csharp-mode-hook 'yas-minor-mode-on)

(provide 'gearup-csharp-mode)
