;;; gearup-utils.el --- Gearup utility functions

;;; Commentary:

;;; Code:
(prelude-require-package 'hydra)

;; copy buffer file name (full path) to kill ring and clipboard
(defun gearup-file-name-to-clipboard ()
  "Copy buffer file name to kill ring and clipboard.
If called from dired copy path of marked files to kill ring and clipboard."
  (interactive)
  (cond
   ((eq major-mode 'dired-mode)
    (dired-copy-filename-as-kill 0))
   (t
    (kill-new (buffer-file-name)))))

;; gearup sizing menu
(global-set-key (kbd "C-c s")
                (defhydra hydra-sizing (:foreign-keys warn)
                  "
^Font size^    ^Vertical window size^   ^Horizontal window size
^----------^   ^--------------------^   ^----------------------
_j_ increase   _k_ enlage               _l_ enlage
_f_ decrease   _d_ shrink               _s_ shrink
"
                  ("j" text-scale-increase nil)
                  ("f" text-scale-decrease nil)
                  ("k" enlarge-window nil)
                  ("d" shrink-window nil)
                  ("l" enlarge-window-horizontally nil)
                  ("s" shrink-window-horizontally nil)
                  ("q" nil "quit")))

(push "Hit <C-c s> to open gearup sizing menu." prelude-tips)

;; reverse kill sexp
(defun gearup-reverse-kill-sexp (&optional arg)
  "Kill sexp before point.
With ARG kill that many sexp before point."
  (interactive "p")
  (kill-sexp (if (> arg 1)
                 (- arg)
               -1)))

(global-set-key (kbd "<C-M-backspace>") 'gearup-reverse-kill-sexp)
(push "Hit <C-M-backs to backward kill sexp" prelude-tips)


;; Whitespace mode configuration
(setq whitespace-display-mappings ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
      '((space-mark 32 [183] [46])
        (space-mark 160 [164] [95])
        (newline-mark 10 [182 10])
        (tab-mark 9 [187 9] [92 9] [9655 9])
        ))

(setq gearup-whitespace-light-gray "gray74")
(setq gearup-whitespace-lighter-gray "gray81")
(set-face-attribute 'whitespace-tab nil :background "unspecified" :foreground gearup-whitespace-light-gray)
(set-face-attribute 'whitespace-space nil :background "unspecified" :foreground gearup-whitespace-light-gray)
(set-face-attribute 'whitespace-newline nil :background nil :foreground gearup-whitespace-lighter-gray)
(set-face-attribute 'whitespace-trailing nil :background "#ffffaa")

;; smarparens is slow in large files
;; see also https://github.com/syl20bnr/spacemacs/issues/3828
(add-hook 'change-major-mode-after-body-hook
          (lambda ()
            (when (> (buffer-size) 80000)
              (turn-off-show-smartparens-mode)
              (flycheck-mode -1))))

(provide 'gearup-utils)
;;; wra-yasnippet.el ends here
