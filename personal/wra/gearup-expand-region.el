;;; gearup-expand-region.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'expand-region)

(global-set-key (kbd "C-+") 'er/contract-region)

;;; Tips:
(push "Hit <M-=> to expand region to word, symbol, sexp, ..." prelude-tips)

(provide 'gearup-expand-region)
;;; gearup-expand-region.el ends here
