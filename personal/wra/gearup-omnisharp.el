;;; gearup-omnisharp.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'omnisharp)
(require 'omnisharp)

(defun gearup--add-omnisharp-to-company-backends ()
  "Add omnisharp to company backends."
  (eval-after-load
      'company
    '(add-to-list 'company-backends 'company-omnisharp)))

(defun gearup--csharp-enable-company-completion ()
  "Enable company comletion in csharp mode."
  (gearup--add-omnisharp-to-company-backends)
  (add-hook 'csharp-mode-hook #'omnisharp-mode)
  (add-hook 'csharp-mode-hook #'company-mode))

(gearup--csharp-enable-company-completion)

(provide 'gearup-omnisharp)
;;; gearup-omnisharp.el ends here
