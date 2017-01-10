;;; wra-sunrise-commander --- Summary
;;; TODO

;;; Commentary:

;;; Code:
(require 'sunrise-commander)
;; disable mouse
(setq sr-cursor-follows-mouse nil)
(define-key sr-mode-map [mouse-1] nil)
(define-key sr-mode-map [mouse-movement] nil)

;; use full frame hight
;; (setq sr-windows-default-ratio 66)

;; set keys for sunrise commander
(global-set-key (kbd "C-c x") 'sunrise)
;;(global-set-key (kbd "C-c X") 'sunrise-cd)

(provide 'wra-sunrise-commander)
;;; wra-sunrise-commander.el ends here
