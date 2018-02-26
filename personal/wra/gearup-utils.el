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

(defun gearup-recenter-top-bottom (&optional arg)
  "Cycle scroll position: center -> top -> bottom.

With single prefix `C-u', scroll window to make line top of
window. With double prefix `C-u C-u', scroll window to make line
bottom of window."
  (interactive "p")
  (cond
   ((= arg 1) (recenter-top-bottom))
   ((= arg 4) (recenter-top-bottom 0))
   ((= arg 16) (recenter-top-bottom (window-height)))))

(global-set-key (kbd "C-l") 'gearup-recenter-top-bottom)
(push "Hit <C-l> to cycle scroll positions: center -> top -> bottom." prelude-tips)
(push "Hit <C-u C-l> to scroll line to top." prelude-tips)
(push "Hit <C-u C-u C-l> to scroll line to bottom.." prelude-tips)

(defun gearup-disable-whitespace-mode ()
  "Disable whitespace-mode."
  (whitespace-mode -1))

;; gearup sizing menu
(global-set-key (kbd "C-c s")
                (defhydra hydra-sizing (:foreign-keys nil)
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

(global-set-key (kbd "C-x r I") 'string-insert-rectangle)
(push "Hit <C-x r I> to insert string rectangle." prelude-tips)

(defmacro define-togglefun (function-name doc-string test on-action off-action msg-format-string)
  "Define interactive function to perform a toggle operation based on TEST.

TEST must be an (unquoted) expression. If TEST evaluates to non-nil OFF-ACTION is evaluated. Otherwise ON-ACTION. DOC-STRING is the doc-string of the generated function. MSG-FORMAT-STRING is a format string used to generate a message in the minibuffer. MSG-FORMAT-STRING can contain one %s placeholder. This placeholder will be filled with the string 'enabled' or 'disabled'.

If the generated function is called with one prefix arg (ie. C-u), ON-ACTION is evaluated no matter what TEST returns"
  (list 'defun function-name (list 'arg)
        doc-string
        (list 'interactive "p")
        (list 'if (list 'or (list '= 'arg 4) (list 'not test))
              (list 'progn
                    on-action
                    (list 'message msg-format-string "enabled"))
              (list 'progn
                    off-action
                    (list 'message msg-format-string "disabled")))))


(defun gearup-buffer-file-has-bom ()
  "Detect if current buffers file has a BOM"
  (interactive)
  (if (not buffer-file-name)
      (message "Buffer is not visiting a file.")
    (if (gearup--file-has-bom buffer-file-name)
        (message "File has a BOM.")
      (message "File has no BOM."))))

(defun gearup--file-has-bom (filepath)
  "Return t if FILE has utf-8 encoding with BOM.

If the utf-8 char U+FEFF appears as first char of a file the file
has BOM. This char corresponds to the bit sequence 0xEF 0xBB
0xBF."
  (with-temp-buffer
    (insert-file-contents-literally filepath nil 0 3)
    (let ((bom (decode-coding-string (buffer-substring-no-properties 1 4) 'utf-8)))
      (when (string= bom (string ?\uFEFF))
        t))))

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
;;; gearup-utils.el ends here
