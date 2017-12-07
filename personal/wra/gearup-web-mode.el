;;; gearup-web-mode.el --- My web-mode Configuration

;;; Commentary:
;; use web-mode to edit xml files; it provides superior folding

;;; Code:
(prelude-require-package 'web-mode)

;; open .xml files in web-mode
(add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))

(setq web-mode-enable-current-element-highlight t)
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2))

(add-hook 'web-mode-hook  'my-web-mode-hook)

(provide 'gearup-web-mode)
;;; gearup-web-mode.el ends here
