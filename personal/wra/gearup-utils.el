;;; gearup-utils.el --- Gearup utility functions

;;; Commentary:

;;; Code:

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

(provide 'gearup-utils)
;;; wra-yasnippet.el ends here
