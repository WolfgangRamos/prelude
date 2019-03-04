;;; gearup-org-attach-screenshot.el --- org-attach-screenshot configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'org-attach-screenshot)
;;(require 'org-attach-screenshot)

(defun gearup-org--get-default-attachments-directory ()
  "Create default attachment directory for current org buffer."
  (let ((buffer-file-name (buffer-file-name))
        (org-capture-mode-active (local-variable-p 'org-capture-mode)))
    (cond
     (org-capture-mode-active (gearup-org--get-temporary-directory))
     (buffer-file-name (concat (file-name-sans-extension buffer-file-name) "-attachments")))))

(custom-set-variables
 '(org-attach-screenshot-dirfunction
   'gearup-org--get-default-attachments-directory)
 '(org-attach-screenshot-command-line (expand-file-name "GearupScreenshot.exe %f" gearup-tools-dir))
 '(org-attach-screenshot-relative-links t)
 '(org-attach-screenshot-auto-refresh 'never))

(defun gearup-org-insert-image-from-clipboard ()
  "Insert image from clipboard using `org-attach-screenshot' and GearupScreenshot.exe."
  (interactive)
  (let ((current-prefix-arg '(4))
        (indentation (make-string (current-indentation) ?\s))
        caption-start-position
        (filename "")
        (caption ""))
    (save-excursion
      (call-interactively 'org-attach-screenshot))
    (save-excursion
      (when (search-forward-regexp "\\[\\[file:\\([^\]]+\\)\\]\\]" nil t)
        (setq filename (file-name-base (match-string-no-properties 1)))
        (setq caption (mapconcat (lambda (s) (capitalize s)) (split-string filename "[_-]+") " "))))
    (insert "#+CAPTION: " caption)
    (setq caption-start-position (point))
    (insert "\n" indentation "#+ATTR_ORG: :width 400\n" indentation)
    (goto-char caption-start-position)))

(define-key org-mode-map (kbd "C-c b") 'gearup-org-insert-image-from-clipboard)

(push "Hit <C-c b> in org-mode to insert a screenshot from the clipboard." prelude-tips)

(defvar gearup-org--screenshots-in-org-capture-buffer nil
  "File names of image files inserted into org-caputre buffers.")

(defun gearup-org--get-temporary-directory ()
  "Get temp directory."
  (if (eq system-type 'windows-nt)
      (getenv "TEMP")
    ""))

(provide 'gearup-org-attach-screenshot)
;;; gearup-org-attach-screenshot.el ends here
