;;; gearup-omnisharp.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'omnisharp)
(require 'omnisharp)

(defun gearup-omnisharp--setup-omnisharp-completion (path)
  "Enable company completion in csharp mode.

PATH must be the path to the omnisharp executable."
  (if (file-exists-p path)
      (progn
        (require 'omnisharp)
        (setq omnisharp-server-executable-path path)
        (add-to-list 'company-backends 'company-omnisharp)
        (add-hook 'csharp-mode-hook #'omnisharp-mode)
        (add-hook 'csharp-mode-hook #'company-mode)
        (define-key csharp-mode-map (kbd "TAB") 'company-complete))
    (error "Could not setup omnisharp completion: Omnisharp executable was not found. Path given was %s" path)))

(provide 'gearup-omnisharp)
;;; gearup-omnisharp.el ends here
