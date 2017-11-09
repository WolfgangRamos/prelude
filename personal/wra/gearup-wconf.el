;; (prelude-require-package 'wconf)

(setq wconf-file (expand-file-name "savefile/.wconf-window-configs.el" prelude-personal-dir))
(wconf-load)
(wconf-restore)

;; (wconf-create)
;; (wconf-rename "test01")
;; ;;wconf--configs

(wconf-save)

;; (current-window-configuration)
;; (selected-window)
;; (selected-window-group)
;; ;;(window-resize )
;; (window-buffer)
;;(wconf-create)
;;(wconf--current-config)
