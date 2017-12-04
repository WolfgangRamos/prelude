;;; gearup-misc-prelude-tips.el --- Prelude mode configuration

;;; Commentary:
;;
;; Provide additional prelude tips that don't fit somewhere else.

;;; Code:

(push "Press <d> in undo-tree to toggle diff buffer (requires diff system command)" prelude-tips)
(push "In vc-mode-line '-' is shown when a file is unmodified." prelude-tips)
(push "In vc-mode-line ':' is shown when a file has been modified." prelude-tips)
(push "In vc-mode-line '!' is shown when a file contains conflicts." prelude-tips)

(provide 'gearup-misc-prelude-tips)
;;; gearup-misc-prelude-tips.el ends here
