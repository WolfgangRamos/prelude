;;; wra-helm.el --- Summary

;;; Commentary

;;; Code

(prelude-require-packages '(wgrep wgrep-helm wgrep-ag))
(require 'helm)

(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-S-s") 'helm-occur)

(defun gearup-helm--quit-and-enter-isearch ()
  "Quit helm session and enter `isearch-forward'."
  (interactive)
  (with-helm-alive-p
    (let ((user-input (minibuffer-contents-no-properties)))
      (helm-run-after-exit (lambda (search-str)
                             (isearch-forward nil t)
                             (isearch-yank-string search-str)) user-input))))

(defun gearup-helm--occur-add-isearch-keybinding ()
  "Bind `isearch-forward' to C-s in `helm-source-occur' keymap."
  (define-key (alist-get 'keymap helm-source-occur) (kbd "C-s") 'gearup-helm--quit-and-enter-isearch))

(advice-add 'helm-occur-init-source :after #'gearup-helm--occur-add-isearch-keybinding)

(when (equal system-type 'windows-nt)
  (setq helm-ag-base-command "c:/msys64/mingw64/bin/ag.exe --vimgrep"))

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
(setq prelude-tips (append prelude-tips
                           '("Press <C-w> to successively yank words from point into helm minibuffer."
                              "Press <C-c o> to goto result in other window."
                              "Press <M-a> to select all results in a helm buffer."
                              "Press <M-m> to toggle selected results in a helm buffer."
                              "Press <C-s> to run helm-multi-occur on selected buffers/files."
                              "Press <C-c => to diff current buffer with seleced buffer/file."
                              "Press <C-c C-p> to edit saved helm-occur results. Press <C-x C-s> to save."
                              "Hit <C-c h b> to run helm-resume."
                              "Hit <C-t> in any helm session to toggle horizontal/vertical split."
                              "Hit <C-x C-f> in any helm session to call helm-find-files."
                              "Hit <C-c C-k> in any helm session to copy candidate display value to kill ring. Use prefix argument to copy real value."
                              "Hit <C-c TAB> in any helm session to copy candidate display value to current buffer."
                              "Hit <C-o> to jump between groups in helm commands."
                              "Hit <C-x b> in any helm session to call helm-resume."
                              "Hit <C-x C-b> in any helm session to display a list of resumable helm sessions."
                              "In helm-find-files hit <C-c f> to create a dired buffer with selected file(s)."
                              "In helm-find-files hit <C-c a> to add selected file(s) to current dired buffer."
                              "In helm-find-files hit <C-c d> to remove selected file(s) from current dired buffer."
                              "Hit <C-c p s g> to run grep in project root."
                              "Hit <C-c p s s> to run ag in project root."
                              "In helm-mini use *<mode> to select buffers by major mode."
                              "In helm-mini use *!<mode> to exclude buffers by major mode."
                              "In helm-mini use /<dir> to select buffers by directory."
                              "In helm-mini use /!<dir> to exclude buffers by directory."
                              "In helm-mini use @<pattern> to select buffers containing <pattern>."
                              "Hit <C-s> in helm-mini to run helm-moccur on selected buffers.")))

(provide 'wra-helm)
;;; wra-helm.el ends here
