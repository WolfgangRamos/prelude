;;; gearup-iedit.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'iedit)
(require 'iedit)
(global-unset-key (kbd "C-M-;"))
(global-set-key (kbd "M-.") 'iedit-mode)

(with-eval-after-load 'elisp-slime-nav
  (define-key elisp-slime-nav-mode-map (kbd "M-.") nil))


; By default iedit uses the default highlighting color which is also used to highlight the current line. Therefore we change idedit's highlighting color the have a visual difference for occurances in the current line.
(set-face-attribute 'iedit-occurrence nil :background "deep sky blue")

(setq prelude-tips (append prelude-tips
              '("Hit <M-;> to call iedit on symbol, url or tag at point. Hit <M-;> again to quit."
                "Hit <M-H> in iedit mode to restrict selections to current function."
                "Hit <M-}> in iedit mode to widen selection one line up."
                "Hit <M-{> in iedit mode to widen selection one line down."
                "Hit <M-L> in iedit mode to downcase all occurrences."
                "Hit <M-M> in iedit mode to switch to multiple cursors."
                "Hit <M-U> in iedit mode to upcase occurrences.")))

(provide 'gearup-iedit)
;;; gearup-iedit.el ends here
