;;; wra-helm.el --- Summary

;;; Commentary

;;; Code
;; open recent files with C-x C-r
(global-set-key (kbd "C-x C-r") 'helm-recentf)

;; TODO make C-u C-u C-SPC another way to jump to a specific mark: helm-mark-ring
;; (global-set-key (kbd "C-u C-u C-SPC") 'helm-mark-ring)

;; Helm
;;(require 'helm-config)
;;(helm-mode 1)
;;(define-key global-map [remap find-file] 'helm-find-files)
;;(define-key global-map [remap occur] 'helm-occur)
;;(define-key global-map [remap list-buffers] 'helm-buffers-list)
;;(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
;;(global-set-key (kbd "M-x") 'helm-M-x)
;;(unless (boundp 'completion-in-region-function)
;;  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
;;  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))
;;(add-hook 'kill-emacs-hook #'(lambda () (and (file-exists-p "/tmp/helm-cfg.el") (delete-file "/tmp/helm-cfg.el"))))

;; automatically resize suggestion window
;;(helm-autoresize-mode t)


(provide 'wra-helm)
;;; wra-helm.el ends here
