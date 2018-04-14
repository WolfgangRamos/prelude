;;; gearup-org-attach-screenshot.el --- org-attach-screenshot configuration

;;; Commentary:

;;; Code:
;;(prelude-require-package 'org-attach-screenshot)
(require 'org-attach-screenshot-loaddefs)
;;(require 'org-attach-screenshot)

(defun gearup-org--get-default-attachments-directory ()
  "Create default attachment directory for current org buffer."
  (assert (buffer-file-name))
  (concat (file-name-sans-extension (buffer-file-name))
          "-attachments"))

(custom-set-variables
 '(org-attach-screenshot-dirfunction
   'gearup-org--get-default-attachments-directory)
 '(org-attach-screenshot-command-line (expand-file-name "GearupScreenshot.exe %f" gearup-tools-dir))
 '(org-attach-screenshot-relative-links t)
 '(org-attach-screenshot-auto-refresh nil))

(defun gearup-org-insert-image-from-clipboard ()
  "Insert image from clipboard using `org-attach-screenshot' and GearupScreenshot.exe."
  (interactive)
  (let ((current-prefix-arg '(4)))
    (call-interactively 'org-attach-screenshot)))

(define-key org-mode-map (kbd "C-c b") 'gearup-org-insert-image-from-clipboard)

(provide 'gearup-org-attach-screenshot)
;;; gearup-org-attach-screenshot.el ends here
