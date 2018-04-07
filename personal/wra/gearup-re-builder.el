;;; gearup-re-builder.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(defun gearup-rebuilder--set-emacs-regex-syntax ()
  "Make re-builder use emacs lisp regex, i.e. require double escaping."
  (setq reb-re-syntax 'read))

(with-eval-after-load 're-builder
  (gearup-rebuilder--set-emacs-regex-syntax))

(push "Hit <C-c TAB> in re-builder to toggle syntax; double-escaped -> single-escaped -> rx." prelude-tips)


(provide 'gearup-re-builder)
;;; gearup-re-builder.el ends here
