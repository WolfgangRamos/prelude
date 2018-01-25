;;; gearup-psvn.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'psvn)

;; TODO
;; define commang like <C-x s> to start psvn status


;;; Tips
(append prelude-tips
  '("Hit <g> in svn status buffer to refresh buffer."
    "Hit <=> in svn status buffer to run svn diff on file at point."
    "Hit <l> in svn status buffer to show log."
    "Hit <i> in svn status buffer to show svn info."
    "Hit <r> in svn status buffer to run svn revert."
    "Hit <c> in svn status buffer to run svn commit."
    "Hit <a> in svn status buffer to svn add file at point."
    "Hit <q> in svn status buffer to close buffer."
    "Hit <U> in svn status buffer to run svn update."
    "Hit <E> in svn status buffer to run ediff on file at point."
    ))

(provide 'gearup-psvn)
;;; gearup-psvn.el ends here
