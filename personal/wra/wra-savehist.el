;;; wra-savehist.el --- Summary
;;; TODO

;;; Commentary:
;;
;; savehist.el can persist the minibuffer history and recent directories
;; for sunrise-commander.el.

;;; Code:
(savehist-mode)                         ; enable savehist mode
;;(setq savehist-file "") ; set savehist file

;; save recent directories for sunrise-commander.el
(add-to-list 'savehist-additional-variables 'sr-history-registry)

(provide 'wra-savehist)
;;; wra-savehist.el ends here
