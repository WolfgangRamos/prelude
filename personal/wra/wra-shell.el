;;; wra-shell.el --- Shell Buffer Configuration

;;; Commentary

;;; Code

;; configure shell buffer
(setq comint-scroll-to-bottom-on-input t)  ; always insert at the bottom
(setq comint-scroll-to-bottom-on-output nil) ; always add output at the bottom
(setq comint-scroll-show-maximum-output t) ; scroll to show max possible output

(provide 'wra-shell)
;;; wra-shell.el ends here
