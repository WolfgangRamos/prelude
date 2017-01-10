;;; wra-ess.el --- Configuration for ESSH

;;; Commentary:

;;; Code
(prelude-require-package 'ess)

(eval-after-load "ess"
  '(progn
     (define-key ess-mode-map (kbd "C-c .") nil)
     (define-key ess-mode-map (kbd "C-;") 'comment-line)
     )
  )

(add-hook 'inferior-ess-mode-hook
          '(lambda ()
            (define-key inferior-ess-mode-map (kbd "C-c .") nil)
            )
  )


(provide 'wra-ess)
;;; wra-ess.el ends here
