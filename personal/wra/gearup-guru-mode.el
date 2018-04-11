;;; gearup-guru-mode.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'guru-mode)

(with-eval-after-load 'guru-mode
  (setq guru-warn-only nil))

(provide 'gearup-guru-mode)
;;; gearup-guru-mode.el ends here
