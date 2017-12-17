;;; gearup-misc-prelude-tips.el --- Prelude mode configuration

;;; Commentary:
;;
;; Provide additional prelude tips that don't fit somewhere else.

;;; Code:

;; undo-tree
(push "Press <d> in undo-tree to toggle diff buffer (requires diff system command)" prelude-tips)

;; vc-mode
(push "In vc-mode-line '-' is shown when a file is unmodified." prelude-tips)
(push "In vc-mode-line ':' is shown when a file has been modified." prelude-tips)
(push "In vc-mode-line '!' is shown when a file contains conflicts." prelude-tips)

;; emacs help
(push "Hit <C-h r> to show emacs maual." prelude-tips)
(push "Hit <C-h r> to show emacs info page." prelude-tips)

;; ediff
(push "Hit <n> in ediff to goto next difference." prelude-tips)
(push "Hit <p> in ediff to goto previous difference." prelude-tips)
(push "Hit <a> in ediff to copy current difference from A to B." prelude-tips)
(push "Hit <!> in ediff to recompute differences." prelude-tips)
(push "Hit <v> in ediff to scroll up." prelude-tips)
(push "Hit <V> in ediff to scroll down." prelude-tips)

;; emacsclient
;;(push "Hit <C-x #> to close an emacs client frame." prelude-tips);; FIXME verify this

;; dired
(push "Hit <C-q> in dired to make the buffer writable; Hit <C-x C-s> to save." prelude-tips)

;; sexp
(push "Hit <C-M-k> to forward kill sexp" prelude-tips)
(push "Hit <C-M-- k> to backward kill sexp." prelude-tips)
(push "Hit <C-M-b> to move backward over sexp." prelude-tips)
(push "Hit <C-M-f> to move forward over sexp." prelude-tips)
(push "Hit <C-M-t> to transpose sexp." prelude-tips)
(push "Hit <C-M-SPC> to forward mark sexp." prelude-tips)
(push "Hit <C-M-n> to move forward over sexp staying at same level in sexp structure." prelude-tips)
(push "Hit <C-M-p> to move backward over sexp staying at the same level in sexp structure." prelude-tips)
(push "Hit <C-M-u> to move upward in sexp structure." prelude-tips)
(push "Hit <C-M-d> to move downward in sexp structure." prelude-tips)

;; general
(push "Hit <C-x z> to repeat last command." prelude-tips)
(push "Hit <M-z> to zap to char." prelude-tips)

;; frames
(push "Hit <C-x 5 0> to delete current frame." prelude-tips)
(push "Hit <C-x 5 2> to spawn new frame." prelude-tips)

;; calc
(push "Hit <C-x *> to run calc dispatch. Then hit <C> or <*> to run calc." prelude-tips)
(push "Hit <q> in calc to quit." prelude-tips)

;; rectangle commands
(push "Hit <C-x r k> to kill rectangle." prelude-tips)
(push "Hit <C-x r c> to clear rectangle." prelude-tips)
(push "Hit <C-x r y> to yank rectangle." prelude-tips)
(push "Hit <C-x r t> to directly type text to rectangle." prelude-tips)

;; prefix args
(push "Hit <M--> or <C-u -> to enter negative prefix arg." prelude-tips)

;; move-text
(push "Hit <C-S-up/down> to move line/region up down." prelude-tips)

(provide 'gearup-misc-prelude-tips)
;;; gearup-misc-prelude-tips.el ends here
