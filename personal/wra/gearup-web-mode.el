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

;; tips
(push "Hit <C-c C-e a> in web-mode to select element content." prelude-tips)
(push "Hit <C-c C-e s> in web-mode to select element." prelude-tips)
(push "Hit <C-c C-e b> to go to element beginning." prelude-tips)
(push "Hit <C-c C-e e> to go to element end." prelude-tips)
(push "Hit <C-c C-e p> to go to previous element." prelude-tips)
(push "Hit <C-c C-e n> to go to next element." prelude-tips)
(push "Hit <C-c C-e u> to go to parent element." prelude-tips)
(push "Hit <C-c C-e d> to go to child element." prelude-tips)
(push "Hit <C-c C-e m> to remove blank lines between child elements." prelude-tips)
(push "Hit <C-c C-e t> to transpose elements." prelude-tips)

(provide 'gearup-web-mode)
;;; gearup-web-mode.el ends here
