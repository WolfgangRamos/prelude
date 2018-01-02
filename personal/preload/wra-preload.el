;;; wra-preload --- Summary

;;; Commentary

;;; Code

; disable theming through prelude
(setq prelude-theme nil)

;; disable flyspell
(setq prelude-flyspell nil)

;; add sunrise commanders ELPA repo
(add-to-list 'package-archives '("SC"   . "http://joseito.republika.pl/sunrise-commander/") t)

;; add org ELPA repo
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(provide 'wra-preload)
;;; wra-preload.el ends here
