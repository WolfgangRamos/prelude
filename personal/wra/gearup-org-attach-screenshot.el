;;; gearup-org-attach-screenshot.el --- org-attach-screenshot configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'org-attach-screenshot)

(setq org-attach-screenshot-dirfunction
      (lambda ()
        (progn (assert (buffer-file-name))
               (concat (file-name-sans-extension (buffer-file-name))
                       "-attachments"))))

(defun gearup-org-insert-image-from-clipboard ()
  "Insert image from clipboard.
Image Magick's \"convert\" command is used to insert an image
from the clipboard. A siple C# implementation of a
copy-image-from-clipboard-command can be found here URL
`https://stackoverflow.com/questions/17435995/paste-an-image-on-clipboard-to-emacs-org-mode-file-without-saving-it'."
  (interactive)
  (let ((org-attach-screenshot-command-line "convert clipboard: %f")
        (current-prefix-arg '(4)))
    (call-interactively 'org-attach-screenshot)))

(provide 'gearup-org-attach-screenshot)
;;; gearup-org-attach-screenshot.el ends here
