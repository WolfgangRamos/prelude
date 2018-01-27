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
(push "Hit <C-h r> to show emacs manual." prelude-tips)
(push "Hit <C-h r> to show emacs info page." prelude-tips)
(push "Hit <C-h l> to show the last 300 key and mouse events and functions they called." prelude-tips)
(push "Hit <C-h s> to show the current syntax table." prelude-tips)
(push "Hit <C-h b> to show the current key bindings." prelude-tips)

;; ediff
(push "Hit <n> in ediff to goto next difference." prelude-tips)
(push "Hit <p> in ediff to goto previous difference." prelude-tips)
(push "Hit <a> in ediff to copy current difference from A to B." prelude-tips)
(push "Hit <!> in ediff to recompute differences." prelude-tips)
(push "Hit <v> in ediff to scroll up." prelude-tips)
(push "Hit <V> in ediff to scroll down." prelude-tips)

;; hideshow
(push "Hit <C-c @ C-c> to toggle show/hide current block." prelude-tips)
(push "Hit <C-c @ C-s> to show current block." prelude-tips)
(push "Hit <C-c @ C-h> to hide current block." prelude-tips)
(push "Hit <C-c @ C-M-h> to hide all top-level blocks." prelude-tips)
(push "Hit <C-c @ C-M-s> to show all blocks." prelude-tips)
(push "Hit <C-c @ C-l> to hide all blocks n levels below current block." prelude-tips)

;; emacsclient
;;(push "Hit <C-x #> to close an emacs client frame." prelude-tips);; FIXME verify this

;; dired
(push "Hit <C-x C-q> in dired to make the buffer writable; Hit <C-c C-c> to save." prelude-tips)
(push "Hit <q> in dired to close dired buffer." prelude-tips)
(push "Hit <o> in dired to open file at point in another window." prelude-tips)
(push "Hit <d> in dired to flag file at poimt for deletion, then hit <x>." prelude-tips)
(push "Hit <% d> in dired to delete files using a regex." prelude-tips)
(push "Hit <* /> in dired to mark all directories." prelude-tips)
(push "Hit <* s> in dired to mark all files in current directory." prelude-tips)
(push "Hit <U> in dired to unmark all files." prelude-tips)
(push "Hit <* c> in dired to replace a mark char." prelude-tips)
(push "Hit <% m> in dired to mark all files matching a regex." prelude-tips)
(push "Hit <% g> in dired to mark all files whose content matches a regex." prelude-tips)
(push "Hit <=> in dired to run ediff on file at point." prelude-tips)
(push "Hit <C> in dired to copy marked files." prelude-tips)
(push "Hit <D> in dired to delete marked files." prelude-tips)
(push "Hit <R> in dired to move (rename) marked files." prelude-tips)
(push "Hit <Z> in dired to (un)compress files individually." prelude-tips)
(push "Hit <c> in dired to compress marked files in a single archive." prelude-tips)
(push "Hit <B> in dired to byte compile marked lisp files." prelude-tips)
(push "Hit <:d> in dired to decrypt marked files." prelude-tips)
(push "Hit <:v> in dired to verify signatures of marked files." prelude-tips)
(push "Hit <:s> in dired to sign marked files." prelude-tips)
(push "Hit <:e> in dired to encrypt marked files." prelude-tips)
(push "Hit <!> in dired to run a shell command on marked files." prelude-tips)
(push "Hit <&> in dired to run a shell command asynchronously on marked files." prelude-tips)
(push "Use < * > in command string to pass all marked files to a shell command from dired." prelude-tips)
(push "Use < ? > in command string to pass marked files individually to a shell command from dired." prelude-tips)
(push "Hit <% u> in dired to upcase names of marked files." prelude-tips)
(push "Hit <% l> in dired to downcase names of marked files." prelude-tips)
(push "Hit <% R> in dired to move (rename) marked files using regex. With <C-u 0> use absolute path." prelude-tips)
(push "Hit <% C> in dired to copy marked files using regex. With <C-u 0> use absolute path." prelude-tips)
(push "Hit <w> in dired to push files names of marked files to kill ring. With <C-u 0> use absolute path." prelude-tips)
(push "Hit <(> in dired to show/hide file details." prelude-tips)
(push "Hit <s> in dired to toggle sorting by name/date." prelude-tips)
(push "Hit <i> in dired to insert a subdirectory listing." prelude-tips)
(push "Hit <C-u k> in dired on subdirectory listing header to remove it." prelude-tips)

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
(push "Hit <C-x 8> to compose unicode chars." prelude-tips)
(push "Hit <C-o> to insert a new line below without moving point." prelude-tips)
(push "Hit <C-j> to insert a new line, move point forward and indent." prelude-tips)

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
(push "Hit <C-x SPC> to select a rectangular region." prelude-tips)

;; prefix args
(push "Hit <M--> or <C-u -> to enter negative prefix arg." prelude-tips)

;; move-text
(push "Hit <C-S-up/down> to move line/region up down." prelude-tips)

(provide 'gearup-misc-prelude-tips)
;;; gearup-misc-prelude-tips.el ends here
