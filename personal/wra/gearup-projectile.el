;;; gearup-projectile.el --- Prelude mode configuration

;;; Commentary:

;;; Code:


(setq projectile-indexing-method 'alien)

;;
(setq projectile-switch-project-action 'helm-projectile)

;; tips

;; helm-projectile
(push "Press <C-c p h> to run helm-projectile." prelude-tips)

;; switch-project
(push "Hit <C-c p p> run helm-switch-project." prelude-tips)
(push "Hit <RET> in helm-projectile-switch-project to run helm-projectile." prelude-tips)
(push "Press <C-u C-s> in helm-projectile-switch-project to run recursive grep on selected projects." prelude-tips)

;; helm-find-file
(push "In helm-find-file hit <C-c o> to open file in other window." prelude-tips)
(push "In helm-find-file hit <C-c r> to open file as root" prelude-tips)
(push "In helm-find-file hit <M-R> to rename/move file(s)." prelude-tips)
(push "In helm-find-file hit <M-C> to copy file(s)." prelude-tips)
(push "In helm-find-file hit <M-D> to delete file(s)." prelude-tips)
(push "In helm-find-file hit <C-s> to grep file(s)." prelude-tips)
(push "In helm-find-file hit <C-@> to insert file(s) as org links." prelude-tips)
(push "In helm-find-file hit <C-c => to ediff file(s)." prelude-tips)
(push "In helm-find-file hit <M-=> to emerge file(s)." prelude-tips)

;; helm-find-dir
(push "In helm-find-dir hit <C-s> to run grep on directory." prelude-tips)
(push "In helm-find-dir hit <C-u C-s> to run recursive grep on directory." prelude-tips)
(push "Hit <C-c p i> to invalide projectile project cache." prelude-tips)

(provide 'gearup-projectile)
;;; gearup-projectile.el ends here
