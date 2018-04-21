;;; gearup-easy-kill.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'easy-kill)

;;; Tips:
(setq prelude-tips
      (append prelude-tips
              '("Hit <C-M-SPC> to run easy-mark."
                "Hit <M-w> to run easy-kill."
                "Hit <l> in easy-mark/easy-kill state to mark enclosing sexp."
                "Hit <+> or <=> in easy-mark/easy-kill state to expand region by selected thing (word, sexp, etc)."
                "Hit <d> in easy-mark/easy-kill state to mark defun."
                "Hit <D> in easy-kill state to save defun's name to kill-ring."
                "Hit <b> in easy-kill state to save buffer file's name to kill-ring.")))

(provide 'gearup-easy-kill)
;;; gearup-easy-kill.el ends here
