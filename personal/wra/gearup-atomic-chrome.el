;;; gearup-atomic-chrome.el --- Atomic chrome configuration

;;; Commentary:

;;; Code:
(prelude-require-packages '(atomic-chrome jira-markup-mode))
(require 'atomic-chrome)
(require 'jira-markup-mode)
(setq atomic-chrome-url-major-mode-alist
      '(("jira-prod.vt-fls.com" . jira-markup-mode)))
(atomic-chrome-start-server)

(provide 'gearup-atomic-chrome)
;;; gearup-atomic-chrome.el ends here
