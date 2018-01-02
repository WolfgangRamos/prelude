;;; wra-helm.el --- Summary

;;; Commentary

;;; Code

(prelude-require-packages '(wgrep wgrep-helm wgrep-ag))

;; open recent files with C-x C-r
(global-set-key (kbd "C-x C-r") 'helm-recentf)

(setq helm-ag-base-command "c:/msys64/mingw64/bin/ag.exe --vimgrep")

;; TODO make C-u C-u C-SPC another way to jump to a specific mark: helm-mark-ring
;; (global-set-key (kbd "C-u C-u C-SPC") 'helm-mark-ring)

;; Helm
;;(require 'helm-config) ;; already part of prelude-helm

;; enable tranversion group boundaries in helm buffers
(setq helm-move-to-line-cycle-in-source nil)

;; helm-occure
(push "Press <C-c h o> to launch helm-occur." prelude-tips)
(push "Press <C-j> in helm-occur to jump to match." prelude-tips)
(push "Press <C-c C-f> in helm-occur to follow matches." prelude-tips)
(push "Press <C-x C-s> in helm-occur to save results." prelude-tips)
(push "Press <g> in saved helm occur results to update results." prelude-tips)

;; helm-info
(push "Use helm-info to open specific info page." prelude-tips)

;; general
(push "Press <C-w> to successively yank words from point into helm minibuffer." prelude-tips)
(push "Press <C-c o> to goto result in other window." prelude-tips)
(push "Press <M-a> to select all results in a helm buffer." prelude-tips)
(push "Press <M-m> to toggle selected results in a helm buffer." prelude-tips)
(push "Press <C-s> to run helm-multi-occur on selected buffers/files." prelude-tips)
(push "Press <C-c => to diff current buffer with seleced buffer/file." prelude-tips)
(push "Press <C-c C-p> to edit saved helm-occur results. Press <C-x C-s> to save." prelude-tips)
(push "Hit <C-c h b> to run helm-resume." prelude-tips)
(push "Hit <C-t> in any helm session to toggle horizontal/vertical split." prelude-tips)
(push "Hit <C-x C-f> in any helm session to call helm-find-files." prelude-tips)
(push "Hit <C-c C-k> in any helm session to copy candidate display value to kill ring. Use prefix argument to copy real value." prelude-tips)
(push "Hit <C-c TAB> in any helm session to copy candidate display value to current buffer." prelude-tips)
(push "Hit <C-o> to jump between groups in helm commands." prelude-tips)
(push "Hit <C-x b> in any helm session to call helm-resume." prelude-tips)
(push "Hit <C-x C-b> in any helm session to display a list of resumable helm sessions." prelude-tips)
(push "In helm-find-files hit <C-c f> to create a dired buffer with selected file(s)." prelude-tips)
(push "In helm-find-files hit <C-c a> to add selected file(s) to current dired buffer." prelude-tips)
(push "In helm-find-files hit <C-c d> to remove selected file(s) from current dired buffer." prelude-tips)
(push "Hit <C-c p s g> to run grep in project root." prelude-tips)
(push "Ht <C-c p s s> to run ag in project root." prelude-tips)

;; helm-mini
(push "In helm-mini use *<mode> to select buffers by major mode." prelude-tips)
(push "In helm-mini use *!<mode> to exclude buffers by major mode." prelude-tips)
(push "In helm-mini use /<dir> to select buffers by directory." prelude-tips)
(push "In helm-mini use /!<dir> to exclude buffers by directory." prelude-tips)
(push "In helm-mini use @<pattern> to select buffers containing <pattern>." prelude-tips)
(push "Hit <C-s> in helm-mini to run helm-moccur on selected buffers." prelude-tips)

(provide 'wra-helm)
;;; wra-helm.el ends here
