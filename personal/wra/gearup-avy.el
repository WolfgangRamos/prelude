;;; gearup-avy.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'avy)
(require 'avy)

(defun gearup-avy-goto-line ()
  (interactive)
  (avy-goto-line)
  (crux-move-beginning-of-line 1))

(global-set-key (kbd "C-.") 'avy-goto-char-timer)
(define-key isearch-mode-map (kbd "C-.") 'avy-isearch)

(defun avy-action-embark (pt)
  (unwind-protect
      (save-excursion
        (goto-char pt)
        (embark-act))
    (select-window
     (cdr (ring-ref avy-ring 0))))
  t)

(setf (alist-get ?. avy-dispatch-alist) 'avy-action-embark)
(setf (alist-get ?z avy-dispatch-alist) 'zop-to-char)

(provide 'gearup-avy)
;;; gearup-avy.el ends here
