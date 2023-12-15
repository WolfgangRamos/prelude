;;; wra-preload --- Summary

;;; Commentary

;;; Code

; disable theming through prelude
(setq prelude-theme nil)
(setq prelude-minimalistic-ui t)

;; disable flyspell
(setq prelude-flyspell nil)

;; disable global whitespace-mode
(setq prelude-whitespace nil)

;; https://emacs-lsp.github.io/lsp-mode/page/performance/
;;(setq lsp-use-plists t)

(provide 'wra-preload)
;;; wra-preload.el ends here
