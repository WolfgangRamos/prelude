;;; wra-cdlatex.el --- My cdlatex Configuration

;;; Commentary

;;; Code
(prelude-require-package 'auctex) ;; cdlatex requires auctex
(prelude-require-package 'cdlatex)

;; add environments
(setq cdlatex-env-alist
	  '(("cases" "\\begin{cases}\n? & \\\\\n &\n\\end{cases}" nil)))

(provide 'wra-cdlatex)
;;; wra-cdlatex.el ends here
