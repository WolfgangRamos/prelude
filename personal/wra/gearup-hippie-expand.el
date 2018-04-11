;;; gearup-hippie-expand.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'hippie-exp)

(global-set-key (kbd "M-SPC") 'hippie-expand)

(provide 'gearup-hippie-expand)
;;; gearup-hippie-expand.el ends here
