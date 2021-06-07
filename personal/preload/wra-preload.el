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

;; add org ELPA repo
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(provide 'wra-preload)
;;; wra-preload.el ends here
