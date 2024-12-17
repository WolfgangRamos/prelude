;;; gearup-ggtags.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'ggtags)
(require 'ggtags)

(setq projectile-tags-backend 'ggtags)
(add-hook 'csharp-mode-hook #'ggtags-mode)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

;; bind pop-tag-mark
;;(global-set-key (kbd "M-*") 'pop-tag-mark)

(provide 'gearup-ggtags)
;;; gearup-ggtags.el ends here
