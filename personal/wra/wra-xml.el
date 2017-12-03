;;; wra-xml.el --- My nXML Configuration

;;; Commentary:

;;; Code

;; configure hideshow minor mode for xml mode
(require 'hideshow)
(require 'sgml-mode)
(require 'nxml-mode)
(prelude-require-package 'web-mode)

;; set indetation to 2 spaces
(setq nxml-child-indent 2)
(setq rng-nxml-auto-validate-flag nil)
(setq rng-complete-end-tags-after-< nil)
(add-hook 'nxml-mode-hook
          (lambda ()
            (hs-minor-mode 1) ;; enable hide-show
            (whitespace-mode -1)
            (rng-validate-mode 0) ;; disable validation
            (yas-minor-mode-on)
            (when (> (buffer-size) 80000)
              (turn-off-show-smartparens-mode)
              (hl-tags-mode 1)
              (flycheck-mode -1)
              )))

;; use web-mode to edit xml files; it provides superior folding
(add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))

(setq web-mode-enable-current-element-highlight t)
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2))

(add-hook 'web-mode-hook  'my-web-mode-hook)

(provide 'wra-xml)
;;; wra-xml.el ends here
