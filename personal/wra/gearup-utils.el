;;; gearup-utils.el --- Gearup utility functions

;;; Commentary:

;;; Code:

;; copy buffer file name (full path) to kill ring and clipboard
(defun gearup-buffer-file-name-to-clipboard ()
  (interactive)
  (kill-new (buffer-file-name)))

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
