;;; wra-isearch.el --- Configuration for ESSH

;;; Commentary:

;;; Code
(require 'thingatpt)

(defun my-isearch-yank-word-or-char-from-beginning ()
  "Move to beginning of word before yanking word in isearch-mode."
  (interactive)
  ;; Making this work after a search string is entered by user
  ;; is too hard to do, so work only when search string is empty.
  (if (= 0 (length isearch-string))
      (beginning-of-thing 'word))
  (call-interactively 'isearch-yank-word-or-char)
  ;; Revert to 'isearch-yank-word-or-char for subsequent calls
  (substitute-key-definition 'my-isearch-yank-word-or-char-from-beginning
			     'isearch-yank-word-or-char
			     isearch-mode-map))

(add-hook 'isearch-mode-hook
 (lambda ()
   "Activate my customized Isearch word yank command."
   (substitute-key-definition 'isearch-yank-word-or-char
			      'my-isearch-yank-word-or-char-from-beginning
			      isearch-mode-map)))

(with-eval-after-load 'hs
  (setq hs-isearch-open t)              ; "Automatically unfold blocks as necessary during isearch."
  )

(provide 'wra-isearch)
;;; wra-isearch.el ends here
