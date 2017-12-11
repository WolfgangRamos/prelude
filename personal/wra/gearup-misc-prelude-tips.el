;;; gearup-misc-prelude-tips.el --- Prelude mode configuration

;;; Commentary:
;;
;; Provide additional prelude tips that don't fit somewhere else.

;;; Code:

(push "Press <d> in undo-tree to toggle diff buffer (requires diff system command)" prelude-tips)
(push "In vc-mode-line '-' is shown when a file is unmodified." prelude-tips)
(push "In vc-mode-line ':' is shown when a file has been modified." prelude-tips)
(push "In vc-mode-line '!' is shown when a file contains conflicts." prelude-tips)

;; emacs help
(push "Hit <C-h r> to read emacs' manual in emacs." prelude-tips)

;; ediff
(push "Hit <n> in ediff to goto next difference." prelude-tips)
(push "Hit <p> in ediff to goto previous difference." prelude-tips)
(push "Hit <a> in ediff to copy current difference from A to B." prelude-tips)
(push "Hit <!> in ediff to recompute differences." prelude-tips)
(push "Hit <v> in ediff to scroll up." prelude-tips)
(push "Hit <V> in ediff to scroll down." prelude-tips)

;; emacsclient
(push "Hit <C-x #> to close an emacs client frame." prelude-tips);; FIXME verify this

;; dired
(push "Hit <C-q> in dired to make the buffer writable; Hit <C-x C-s> to save." prelude-tips)

(provide 'gearup-misc-prelude-tips)
;;; gearup-misc-prelude-tips.el ends here
