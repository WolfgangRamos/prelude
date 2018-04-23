;;; gearup-ace-window.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'ace-window)
(prelude-require-package 'key-chord)
;; use home row for window selection
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; disable graphical effects
(setq aw-background nil)

(global-set-key (kbd "C-x o") 'ace-window)
(key-chord-define-global "ww" 'ace-window)

;; tips
(push "Press <x> to delete a window in ace window dispatch." prelude-tips)
(push "Press <i> to maximize a window in ace window dispatch." prelude-tips)
(push "Press <v> to vertically split a window in ace window dispatch." prelude-tips)
(push "Press <b> to horizontally split a window in ace window dispatch." prelude-tips)

(provide 'gearup-ace-window)
;;; gearup-ace-window.el ends here
