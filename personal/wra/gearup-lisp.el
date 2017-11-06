;;; gearup-lisp.el --- Prelude mode configuration

;;; Commentary:

;;; Code:

(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (yas-minor-mode 1)))

(provide 'gearup-lisp)
;;; gearup-lisp.el ends here
