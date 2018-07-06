;;; gearup-org-attach-screenshot.el --- org-attach-screenshot configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'org-attach-screenshot)
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
 '(org-attach-screenshot-auto-refresh 'never))

(defun gearup-org-insert-image-from-clipboard ()
  "Insert image from clipboard using `org-attach-screenshot' and GearupScreenshot.exe."
  (interactive)
  (let ((current-prefix-arg '(4)))
    (save-excursion
      (call-interactively 'org-attach-screenshot))
    (insert "#+ATTR_ORG: :width 400\n")))

(define-key org-mode-map (kbd "C-c b") 'gearup-org-insert-image-from-clipboard)

(push "Hit <C-c b> in org-mode to insert a screenshot from the clipboard." prelude-tips)

(provide 'gearup-org-attach-screenshot)
;;; gearup-org-attach-screenshot.el ends here
