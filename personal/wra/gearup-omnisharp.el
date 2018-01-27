;;; gearup-omnisharp.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'omnisharp)
(require 'omnisharp)
(setq omnisharp-server-executable-path "C:\\Users\\wra\\Downloads\\omnisharp-win-x86\\OmniSharp.exe")

(eval-after-load
    'company
  '(add-to-list 'company-backends 'company-omnisharp))

(add-hook 'csharp-mode-hook #'company-mode)

(provide 'gearup-omnisharp)
;;; gearup-omnisharp.el ends here
