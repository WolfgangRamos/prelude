;;; gearup-ace-window.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'ace-window)

;; use home row for window selection
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; disable graphical effects
(setq aw-background nil)

(global-set-key (kbd "C-x o") 'ace-window)

;; tips
(setq prelude-tips (append prelude-tips
                           '("Press <x> to delete a window in ace window dispatch."
                             "Press <i> to maximize a window in ace window dispatch."
                             "Press <v> to vertically split a window in ace window dispatch."
                             "Press <b> to horizontally split a window in ace window dispatch.")))

(provide 'gearup-ace-window)
;;; gearup-ace-window.el ends here
