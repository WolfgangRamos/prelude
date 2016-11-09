;;; wra-yasnippet.el --- My Yasnippet Configuration

;;; Commentary

;;; Code

;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(require 'helm-c-yasnippet) ;; use helm interface
(setq helm-yas-space-match-any-greedy t) ;[default: nil]
(global-set-key (kbd "C-c y") 'helm-yas-complete)

;; snippets dirs (new snippets are stored in the first one)
(setq yas-snippet-dirs
      (list
       (expand-file-name "snippets" prelude-personal-dir) ;; personal snippet collection))
       yas-installed-snippets-dir)) ;; build in snippet collection

;; i activate yasnippet on per-mode basis
;; use `(yas-global-mode 1)` to activate yasnippet in all modes
(yas-reload-all)

(provide 'wra-yasnippet)
;;; wra-yasnippet.el ends here
