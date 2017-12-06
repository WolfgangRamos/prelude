;;; wra-xml.el --- My nXML Configuration

;;; Commentary:

;;; Code

;; configure hideshow minor mode for xml mode
;;(require 'hideshow)
;;(require 'sgml-mode)
(require 'nxml-mode)
(prelude-require-package 'web-mode)

;; set indetation to 2 spaces
(setq nxml-child-indent 2)
(setq rng-nxml-auto-validate-flag nil)
(setq rng-complete-end-tags-after-< nil)
(add-hook 'nxml-mode-hook
          (lambda ()
            ;;(hs-minor-mode 1) ;; enable hide-show
            (whitespace-mode -1)
            (rng-validate-mode 0) ;; disable validation
            (yas-minor-mode-on)
            (when (> (buffer-size) 80000)
              (turn-off-show-smartparens-mode)
              (hl-tags-mode 1)
              (flycheck-mode -1)
              )))

(defun gearup-nxml-where ()
  "Display the hierarchy of XML elements the point is on as a
path. from http://www.emacswiki.org/emacs/NxmlMode"
  (interactive)
  (let ((path nil))
    (save-excursion
      (save-restriction
        (widen)
        (while
            (and (< (point-min) (point)) ;; Doesn't error if point is at
                 ;; beginning of buffer
                 (condition-case nil
                     (progn
                       (nxml-backward-up-element) ; always returns nil
                       t)
                   (error nil)))
          (setq path (cons (xmltok-start-tag-local-name) path)))
        (if (called-interactively-p t)
            (message "/%s" (mapconcat 'identity path "/"))
          (format "/%s" (mapconcat 'identity path "/")))))))

;; use web-mode to edit xml files; it provides superior folding
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

(provide 'wra-xml)
;;; wra-xml.el ends here
