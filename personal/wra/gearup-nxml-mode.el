;;; gearup-nxml-mode.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(require 'nxml-mode)

;; set indetation to 2 spaces
(setq nxml-child-indent 2)
;; pom files should be treated as xml files
;;(add-to-list 'auto-mode-alist '("\\.pom$" . nxml-mode))

(setq nxml-attribute-indent 4)
(setq nxml-auto-insert-xml-declaration-flag nil)
(setq nxml-bind-meta-tab-to-complete-flag t)
(setq nxml-slash-auto-complete-flag t)


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

(provide 'gearup-nxml-mode)
;;; gearup-nxml-mode.el ends here

