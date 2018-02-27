;;; gearup-ggtags.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'ggtags)
(require 'ggtags)

(setq projectile-tags-backend 'ggtags)
(add-hook 'csharp-mode-hook #'ggtags-mode)

(provide 'gearup-ggtags)
;;; gearup-ggtags.el ends here
