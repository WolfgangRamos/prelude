;;; wra-nameses --- Summary
;;; TODO

;;; Commentary

;;; Code
(require 'desktop)
(require 'nameses)
(require 'ido);; or (setq nameses-ido-mode nil)
(global-set-key (kbd "<f9>")     'nameses-load)
(global-set-key (kbd "C-<f9>")   'nameses-prev)
(global-set-key (kbd "C-S-<f9>") 'nameses-save)

;; set dir to save sessions
(setq nameses-dir (file-name-as-directory (expand-file-name "nameses-sessions/" prelude-personal-dir)))

(provide 'wra-nameses)
;;; wra-nameses.el ends here
