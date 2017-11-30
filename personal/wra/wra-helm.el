;;; wra-helm.el --- Summary

;;; Commentary

;;; Code

(prelude-require-packages '(wgrep wgrep-helm wgrep-ag))

;; open recent files with C-x C-r
(global-set-key (kbd "C-x C-r") 'helm-recentf)

;; TODO make C-u C-u C-SPC another way to jump to a specific mark: helm-mark-ring
;; (global-set-key (kbd "C-u C-u C-SPC") 'helm-mark-ring)

;; Helm
;;(require 'helm-config) ;; already part of prelude-helm

;; enable tranversion group boundaries in helm buffers
(setq helm-move-to-line-cycle-in-source nil)

;; Tips
(push "Press <C-c h o> to launch helm-occur." prelude-tips)
(push "Press <C-j> in helm-occur to jump to match." prelude-tips)
(push "Press <C-c C-f> in helm-occur to follow matches." prelude-tips)
(push "Press <C-x C-s> in helm-occur to save results." prelude-tips)
(push "Press <g> in saved helm occur results to update results." prelude-tips)
(push "Press <C-w> to successively yank words from point into helm minibuffer." prelude-tips)
(push "Press <C-c o> to goto result in other window." prelude-tips)
(push "Press <M-a> to select all results in a helm buffer." prelude-tips)
(push "Press <M-m> to toggle selected results in a helm buffer." prelude-tips)
(push "Press <C-s> to run helm-multi-occur on selected buffers/files." prelude-tips)
(push "Press <C-c => to diff current buffer with seleced buffer/file." prelude-tips)
(push "Press <C-c C-p> to edit saved helm-occur results. Press <C-x C-s> to save." prelude-tips)
(push "Hit <C-c h b> to run helm-resume." prelude-tips)

(provide 'wra-helm)
;;; wra-helm.el ends here
