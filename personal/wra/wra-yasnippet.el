;;; wra-yasnippet.el --- My Yasnippet Configuration

;;; Commentary:

;;; Code:

;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(require 'helm-c-yasnippet) ;; use helm interface
(setq helm-yas-space-match-any-greedy t) ;[default: nil]
(global-set-key (kbd "C-c y") 'helm-yas-complete)

;; snippets dirs (new snippets are stored in the first one)
(setq yas-snippet-dirs
      (list
       (expand-file-name "fls-snippets" prelude-personal-dir)
       (expand-file-name "snippets" prelude-personal-dir) ;; personal snippet collection))
       yas-installed-snippets-dir)) ;; build in snippet collection

;; i activate yasnippet on per-mode basis
;; use `(yas-global-mode 1)` to activate yasnippet in all modes
(yas-reload-all)

;; configure snippet-mode

;; whitespace highlighting configuration

(setq gearup-snippet-mode-whitespace-style '(face trailing tabs newline space-mark tab-mark newline-mark))

;; TODO adjust tabs color and long lines color

(setq gearup-snippet-mode-whitespace-display-mappings ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
      '((space-mark 32 [183] [46])
        (space-mark 160 [164] [95])
        (newline-mark 10 [182 10])
        (tab-mark 9 [9655 9] [92 9])
        ))

(add-hook 'snippet-mode-hook
          (lambda ()
            (set (make-local-variable 'whitespace-style) gearup-snippet-mode-whitespace-style)
            (set (make-local-variable 'whitespace-display-mappings) gearup-snippet-mode-whitespace-display-mappings)
            (whitespace-mode)
            (show-paren-mode)   ; highlight matching brackets
            ))

(provide 'wra-yasnippet)
;;; wra-yasnippet.el ends here
