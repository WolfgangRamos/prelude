;;; gearup-multiple-cursors.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'multiple-cursors)

(defun gearup-mc--toggle-prelude-easy-kill-remapping ()
  "Disable or enable preludes remapping of `kill-ring-save' to
`easy-kill' when entering `multiple-cursors-mode'.

Prelude remaps `kill-ring-save' to `easy-kill'. However,
multiple-cursors-mode chokes on this remapping. So we have to
undo the remapping of kill-ring-save to easy-kill while in
`multiple-cursors-mode' and afterward restore it."
  (if (and (local-variable-p 'multiple-cursors-mode) multiple-cursors-mode)
      (global-set-key [remap kill-ring-save] nil)
    (global-set-key [remap kill-ring-save] 'easy-kill)))

;; set file for storing run-once and run-all command lists
(custom-set-variables
 '(mc/list-file (expand-file-name "savefile/.mc-lists.el" prelude-personal-dir))
 '(mc/insert-numbers-default 1))

(require 'multiple-cursors)

(add-hook 'multiple-cursors-mode-hook 'gearup-mc--toggle-prelude-easy-kill-remapping)

;; make return insert a newline
(define-key mc/keymap (kbd "<return>") nil)
(global-set-key (kbd "C-c SPC") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

(push "Hit <C-c SPC> to create a rectangular region with multiple cursors." prelude-tips)
(push "Hit <C-x r y> to yank from the kill ring of multiple cursors." prelude-tips)
(push "Hit <C-S-<mouse-1>> to add multiple cursors using the mouse." prelude-tips)

;; hydra menu
(global-set-key (kbd "C-c m")
                (defhydra gearup-multiple-cursors-hydra (:foreign-keys nil)
                  "
^Line^     ^Unmark^      ^Skip^        ^Misc^          ^Insert^
^-^-----   ^-^--------   ^-^--------   ^-^----------   ^-^--------
_j_ next   _k_ lowest    _h_ lowest    _r_ rectangle   _n_ numbers
_f_ prev   _d_ highest   _g_ highest   _a_ mark all    _c_ chars
^ ^        ^ ^           ^ ^           _u_ each line
^ ^        ^ ^           ^ ^           _s_ sort
^ ^        ^ ^           ^ ^           _S_ reverse
"
                  ("j" mc/mark-next-like-this nil)
                  ("f" mc/mark-previous-like-this nil)
                  ("k" mc/unmark-next-like-this nil)
                  ("d" mc/unmark-previous-like-this nil)
                  ("h" mc/skip-to-next-like-this nil)
                  ("g" mc/skip-to-previous-like-this nil)
                  ("r" set-rectangular-region-anchor nil)
                  ("a" mc/mark-all-dwim nil)
                  ("u" mc/edit-lines nil)
                  ("n" mc/insert-numbers nil)
                  ("c" mc/insert-letters nil)
                  ("s" mc/sort-regions nil)
                  ("S" mc/reverse-regions nil)
                  ("q" nil "quit")))

(push "Hit <C-c m> to open multiple cursors menu." prelude-tips)

(provide 'gearup-multiple-cursors)
;;; gearup-multiple-cursors.el ends here
