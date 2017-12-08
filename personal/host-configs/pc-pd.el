;; set directory local variables
;;(dir-locals-set-class-variables 'fls-entity-description '((nxml-mode . ((nxml-section-element-name-regex . "Entity\\|Property") (nxml-heading-element-name-regexp . "")))))

;;(dir-locals-set-directory-class "z:/entities/" 'fls-entity-description)

(defun fls-current-form-name ()
  "Return name of the form point is cerrently in.
Signal an error if point is not inside a form tag."
  (interactive)
  (if (and
       (save-excursion
        (move-beginning-of-line nil)
        (re-search-forward "</Form>" nil t))
       (save-excursion
         (move-end-of-line nil)
         (re-search-backward "<Form[[:space:]]+Name=\"\\([^\"]+\\)\"" nil t)))
      (match-string-no-properties 1)
    ;; else
    (error "Could not find enclosing <Form> tag")))

(defun fls-find-layout-node (&optional form)
  "Move point to layout node of FORM."
  (let ((layout-position)
        (found nil))
    (while (and
            (not found)
            (setq layout-position (re-search-forward (concat "<Layout[^>]*UsedbyType=\"Form\"[^>]*") nil t)))
      (when (string-match (concat "UsedbyName=\"" form "\"") (match-string-no-properties 0))
        (setq found t)))
    (if layout-position
        (progn
          (goto-char layout-position)
          (move-beginning-of-line nil))
      (error "Could not find layout node for form %s" form))))

(defun fls-goto-layout-node (prefix)
  "Move point to form's layout tag.
  FORM is the name of the form. If called with a prefix argument read form name from mini buffer. Otherwise use the form point is in (if any)."
  (interactive "p")
  (fls-find-layout-node
    (or
     (and (> prefix 1) (read-string "Form name: "))
     (fls-current-form-name))))

(defun fls-client-xml-layout-path (&optional usenames)
  "Return plist of xml nodes enclosing point.
  If usenames is not nil use names extracted from name attributes instead of tag names (where possible)."
  (interactive)
  nil)
