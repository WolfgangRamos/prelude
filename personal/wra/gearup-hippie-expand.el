;;; gearup-hippie-expand.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'hippie-exp)

(global-set-key (kbd "S-SPC") 'hippie-expand)

(provide 'gearup-hippie-expand)
;;; gearup-hippie-expand.el ends here
