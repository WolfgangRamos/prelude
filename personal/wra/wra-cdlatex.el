;;; wra-cdlatex.el --- My cdlatex Configuration

;;; Commentary

;;; Code

;; add environments
(setq cdlatex-env-alist
	  '(("cases" "\\begin{cases}\n? & \\\\\n &\n\\end{cases}" nil)))

(provide 'wra-cdlatex)
;;; wra-cdlatex.el ends here
