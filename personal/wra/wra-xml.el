;;; wra-xml.el --- My nXML Configuration

;;; Commentary:

;;; Code

;; configure hideshow minor mode for xml mode
(require 'hideshow)
(require 'sgml-mode)
(require 'nxml-mode)

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<!--\\|<[^/>]*[^/]>"
               "-->\\|</[^/>]*[^/]>"

               "<!--"
               sgml-skip-tag-forward
               nil))
;; set indetation to 2 spaces
(setq nxml-child-indent 2)
(setq rng-nxml-auto-validate-flag nil)
(setq rng-complete-end-tags-after-< nil)
(add-hook 'nxml-mode-hook
          (lambda ()
            (hs-minor-mode 1) ;; enable hide-show
            (whitespace-mode -1)
            ;;(flycheck-mode -1)
            (rng-validate-mode 0) ;; disable validation
            (when (> (buffer-size) 80000)
              (turn-off-show-smartparens-mode)
              (hl-tags-mode 1)
              ;;(flycheck-mode -1)
              )))

;; optional key bindings, easier than hs defaults
(define-key nxml-mode-map (kbd "C-c h") 'hs-toggle-hiding)

(provide 'wra-xml)
;;; wra-xml.el ends here
