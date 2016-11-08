;;; wra-helm.el --- Summary

;;; Commentary

;;; Code
;; open recent files with C-x C-r
(global-set-key (kbd "C-x C-r") 'helm-recentf)

;; TODO make C-u C-u C-SPC another way to jump to a specific mark: helm-mark-ring
;; (global-set-key (kbd "C-u C-u C-SPC") 'helm-mark-ring)

(provide 'wra-helm)
;;; wra-helm.el ends here
