(setq projectile-indexing-method 'alien)

;; 
(setq projectile-switch-project-action 'helm-projectile)

(push "Press <C-c p p> to switch projects, then hit <RET> to run helm-projectile." prelude-tips)
(push "In helm-finde file hit <C-c o> to open file in other window." prelude-tips)
(push "In helm-find-file hit <C-c r> to open file aa root" prelude-tips)
(push "In helm-find-files hit <M-R> to rename/move file(s)." prelude-tips)
(push "In helm-find-files hit <M-C> to copy file(s)." prelude-tips)
(push "In helm-find-files hit <M-D> to delete file(s)." prelude-tips)
(push "In helm-find-files hit <C-s> to grep file(s)." prelude-tips)
(push "In helm-find-files hit <C-@> to insert file(s) as org links." prelude-tips)
(push "In helm-find-files hit <C-=> to ediff file(s)." prelude-tips)
(push "In helm-find-files hit <C-c => to emerge file(s)." prelude-tips)
(push "In helm-find-dir hit <C-s> to run grep on directory." prelude-tips)