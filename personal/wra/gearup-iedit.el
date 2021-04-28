;;; gearup-iedit.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'iedit)
(require 'iedit)
(setq prelude-tips (append prelude-tips
              '("Hit <C-;> to call iedit on symbol, url or tag at point. Hit <C-;> again to quit."
                "Hit <M-H> in iedit mode to restrict selections to current function."
                "Hit <M-}> in iedit mode to widen selection one line up."
                "Hit <M-{> in iedit mode to widen selection one line down."
                "Hit <M-L> in iedit mode to downcase all occurrences."
                "Hit <M-M> in iedit mode to switch to multiple cursors."
                "Hit <M-U> in iedit mode to upcase occurrences.")))

(provide 'gearup-iedit)
;;; gearup-iedit.el ends here
