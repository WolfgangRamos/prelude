;;; gearup-gnus.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
;;(require 'gnus)

(defun gearup-gnus--set-gnus-init-file (file-name &optional base-dir)
  "Set gnus init file to FILE-NAME.

BASE-DIR defaults to ~/.emacs.d/personal/gnus/"
  (setq gnus-init-file
        (expand-file-name file-name
                          (expand-file-name "gnus"
                                            prelude-personal-dir))))

(defun gearup-gnus--disable-forward-point-on-summary-exit ()
  "Disable forwarding point to next group when a summary buffer is closed."
  (setq gnus-summary-next-group-on-exit nil))

(defun gearup-gnus-show-all-subscribed-groups ()
  "List all subscribed groups with or without un-read messages"
  (interactive)
  (gnus-group-list-all-groups 5))

(defun gearup-gnus--keybind-show-all-subscribed-groups-command ()
  "Bind `gearup-gnus-show-all-subscribed-groups to \"o\" in `gnus-group-mode-map'."
  (define-key gnus-group-mode-map
  ;; list all the subscribed groups even when they contain zero un-read messages
  (kbd "o") 'gearup-gnus-show-all-subscribed-groups))

(defun gearup-gnus--sort-threads-newest-first ()
  "Make messages sort newest first"
  (setq gnus-thread-sort-functions
      'gnus-thread-sort-by-most-recent-number))

(defun gearup-gnus--setup-group-mode-hydra ()
  "Create hydra for gnus group mode and bind it to \"y\"."
  (defhydra gearup-gnus--group-mode-hydra (:color blue :body-pre gearup-hydra--before-enter-hydra-state :post gearup-hydra--before-exit-hydra-state)
    "Do?"
    ("a" gnus-group-list-active "REMOTE groups A A")
    ("l" gnus-group-list-all-groups "LOCAL groups L")
    ("c" gnus-topic-catchup-articles "Read all c")
    ("G" gnus-group-make-nnir-group "Search server G G")
    ("g" gnus-group-get-new-news "Refresh g")
    ("s" gnus-group-enter-server-mode "Servers")
    ("m" gnus-group-new-mail "C-x m")
    ("#" gnus-topic-mark-topic "mark #")
    ("q" nil "cancel"))
  ;; y is not used by default
  (define-key gnus-group-mode-map "y" 'gearup-gnus--group-mode-hydra/body))


(defun gearup-gnus--setup-summary-mode-hydra ()
  "Create hydra for gnus summary mode and bind it to \"y\""
  (defhydra gearup-gnus--summary-mode-hydra (:color blue :body-pre gearup-hydra--before-enter-hydra-state :post gearup-hydra--before-exit-hydra-state)
    "Do?"
    ("s" gnus-summary-show-thread "Show thread")
    ("h" gnus-summary-hide-thread "Hide thread")
    ("n" gnus-summary-insert-new-articles "Refresh / N")
    ("f" gnus-summary-mail-forward "Forward C-c C-f")
    ("!" gnus-summary-tick-article-forward "Mail -> disk !")
    ("p" gnus-summary-put-mark-as-read "Mail <- disk")
    ("c" gnus-summary-catchup-and-exit "Read all c")
    ("e" gnus-summary-resend-message-edit "Resend S D e")
    ("R" gnus-summary-reply-with-original "Reply with original R")
    ("r" gnus-summary-reply "Reply r")
    ("W" gnus-summary-wide-reply-with-original "Reply all with original S W")
    ("w" gnus-summary-wide-reply "Reply all S w")
    ("#" gnus-topic-mark-topic "mark #")
    ("q" nil "cancel"))
  ;; y is not used by default
  (define-key gnus-summary-mode-map "y" 'gearup-gnus--summary-mode-hydra/body))

(defun gearup-gnus--setup-article-mode-hydra ()
  "Create hydra for gnus article mode and bind it to \"y\"."
  (defhydra gearup-gnus--article-mode-hydra (:color blue :body-pre gearup-hydra--before-enter-hydra-state :post gearup-hydra--before-exit-hydra-state)
    "Do?"
    ("f" gnus-summary-mail-forward "Forward")
    ("R" gnus-article-reply-with-original "Reply with original R")
    ("r" gnus-article-reply "Reply r")
    ("W" gnus-article-wide-reply-with-original "Reply all with original S W")
    ("o" gnus-mime-save-part "Save attachment at point o")
    ("w" gnus-article-wide-reply "Reply all S w")
    ("q" nil "cancel"))
  ;; y is not used by default
  (define-key gnus-article-mode-map "y" 'gearup-gnus--article-mode-hydra/body))

(defun gearup-gnus--setup-message-mode-hydra ()
  "Create hydra for gnus message mode and bind it to \"C-c C-y\""
  (defhydra gearup-gnus--message-hydra (:color blue :body-pre gearup-hydra--before-enter-hydra-state :post gearup-hydra--before-exit-hydra-state)
    "Do?"
    ("ca" mml-attach-file "Attach C-c C-a")
    ("cc" message-send-and-exit "Send C-c C-c")
    ("q" nil "cancel"))
  (global-set-key (kbd "C-c C-y") 'gearup-gnus--message-hydra/body))

(defun gearup-gnus--set-key-bindings ()
  "Setup keybindings for gnus."
  (global-set-key (kbd "C-x m") 'compose-mail))

(with-eval-after-load 'gnus-group
  (gearup-gnus--setup-group-mode-hydra)
  (gearup-gnus--keybind-show-all-subscribed-groups-command)
  (gearup-gnus--sort-threads-newest-first)
  (gearup-gnus--disable-forward-point-on-summary-exit))

(with-eval-after-load 'gnus-sum
  (gearup-gnus--setup-summary-mode-hydra))

(with-eval-after-load 'gnus-art
  (gearup-gnus--setup-article-mode-hydra))

(with-eval-after-load 'message
  (gearup-gnus--setup-message-mode-hydra))

(gearup-gnus--set-key-bindings)

(setq prelude-tips
  (append prelude-tips
    '("Hit <n>/<p> in gnus group buffer to move to next/previous group with unread messages."
    "Hit <N>/<P> in gnus group buffer to move to next/previous group."
    "Hit <j> in gnus group buffer to jump to a group."
    "Hit <RET> to enter a group; with prefix <C-u> also show unread."
    "Hit <M-g> in gnus group summary to fetch new messages; with prefix <C-u> also fetch unread."
    "Hit <S l> in gnus group buffer to set the level of the group under point."
    "Hit <u>/<U> in gnus group buffer to subscribe a group."
    "Hit <C-k> in gnus group buffer to kill group under point."
    "Hit <M m>/<M u> in gnus group buffer to mark/unmark group under point.")))
    
(provide 'gearup-gnus)
;;; gearup-gnus.el ends here
