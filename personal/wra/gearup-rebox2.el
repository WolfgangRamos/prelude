;;; gearup-rebox2.el --- Prelude mode configuration

;;; Commentary:
;;
;; When rebox-mode is enabled you cannot delete the active region with
;; <DEL> (withbackward-delete-char). rebox-mode might also brak other
;; functionality as it rebinds also <SPC> and <RET>, etc. Thus,
;; instead of relying on rebox-mode, we just bind it's most useful
;; command to a key sequence.

;;; Code:
(prelude-require-package 'rebox2)

(global-set-key (kbd "M-Q") 'rebox-dwim)

(provide 'gearup-rebox2)
;;; gearup-rebox2.el ends here
