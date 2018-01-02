;; set directory local variables
;;(dir-locals-set-class-variables 'fls-entity-description '((nxml-mode . ((nxml-section-element-name-regex . "Entity\\|Property") (nxml-heading-element-name-regexp . "")))))

;;(dir-locals-set-directory-class "z:/entities/" 'fls-entity-description)

;; add git svn fucntionality to magit
(add-hook 'magit-mode-hook 'magit-svn-mode)

;; functions to jump to xml tags
(defun gearup-get-xml-node-position (tag &optional attributes start)
  "Find xml node by TAG name and ATTRIBUTES.
TAG is the name of the xml tag, ATTRIBUTES is an alist of
attribute names and values. E.g \"((\"name\" \"a-name\"))\"."
  (let (attr hit candidate)
    (save-excursion
      (if (integerp start)
          (if (and (>= start (point-min)) (<= start (point-max)))
              (goto-char start)
            (error "%d is not a valid position in buffer %s" start (buffer-name (current-buffer))))
        (goto-char (point-min)))
      (if attributes
          (while (and (not hit) (setq candidate (re-search-forward (concat "<" tag " \\([^>]*\\)>") nil t)))
            (setq attr (gearup-parse-xml-attributes (match-string-no-properties 1)))
            (when (gearup-generic-list-subset-p attributes attr 'car-safe 'string-lessp 'string-equal)
              (setq hit candidate)))
        (setq hit (re-search-forward (concat "<" tag " ?\?>") nil t))))
    (if hit
        hit
      (if attributes
          (error "Could not find tag <%s> with attributes %s" tag
                 (mapconcat (lambda (e) (format "%s=%s" (car-safe e) (car-safe (cdr-safe e)))) attributes " "))
        (error "Could not tag <%s>" tag)))))

;; TODO move to utils
(defun gearup-alist-get (key alist)
  "Get KEY from ALIST using `equal'."
  (car-safe (cdr-safe (assoc key alist))))

(defun gearup-parse-xml-attributes (str)
  "Parse xml attributes from string STR.
STR must be the pure attributes string of an xml element. I.e. it
must not include tags!

Returns an alist of attribute-value-pairs where attibute is used as key."
  (if (not (stringp str))
      (error "STR was not a string")
    (let ((start 0) match1 match2 result)
      (while (string-match "\\([^=]+\\)=[[:space:]]*\"\\([^\"]*\\)\"" str start)
        (setq match1 (match-string-no-properties 1 str) match2 (match-string-no-properties 2 str) start (match-end 0))
        (push (list (string-trim match1) match2) result))
      result)))

(ert-deftest gearup-parse-xml-attributes-test ()
  "Test xml attribute string parsing."
  (should (equal (gearup-parse-xml-attributes "Name=\"Service\"") '(("Name" "Service"))))
  (should (equal (gearup-parse-xml-attributes "UsedbyName=\"Layout\"  UsedbyName = \"Service\"	UsedByType=\"Form\" Attr=\"\"")
                 '(("Attr" "") ("UsedByType" "Form") ("UsedbyName" "Service") ("UsedbyName" "Layout")))))

(defun gearup-generic-list-subset-p (subset set extract lessp equalp)
  "Test if a list structure SUBSET is a subset of a list structure SET.
EXTRACT is called on each element of SUBSET and SET to generate
the objects used for comparison. LESSP and EQUALP are functions
used to compare two extracted objects. Each is called with two
objects. LESSP should return non-nil, if the first object is less
than the second. EQUALP schould return non-nil if the first
object is equal to the second.

Returns t if all elements of SUBSET are also elements of SET."
  (let* ((subset-copy (copy-tree subset))
         (set-copy (copy-tree set))
         (subset-sorted (sort subset-copy (lambda (x y)
                                            (funcall lessp (funcall extract x) (funcall extract y)))))
         (set-sorted (sort set-copy (lambda (x y)
                                      (funcall lessp (funcall extract x) (funcall extract y)))))
         (subset-car (car-safe subset-sorted))
         (subset-rest (cdr-safe subset-sorted))
         (set-car (car-safe set-sorted))
         (set-rest (cdr-safe set-sorted))
         (continue t))
    (while (and continue subset-car set-car)
      (cond
       ((funcall lessp (funcall extract set-car) (funcall extract subset-car))
        (setq set-car (car-safe set-rest) set-rest (cdr-safe set-rest)))
       ((funcall equalp (funcall extract set-car) (funcall extract subset-car))
        (setq subset-car (car-safe subset-rest)
              subset-rest (cdr-safe subset-rest)
              set-car (car-safe set-rest)
              set-rest (cdr-safe set-rest)))
       (t
        (setq continue nil))))
    (if (and subset-car continue)
        nil
      t)))

(ert-deftest gearup-generic-list-subset-p-test ()
  "Test `gearup-generic-list-subset-p' with different list structures."
  (should (gearup-generic-list-subset-p nil nil 'identity '< '=))
  (should-not (gearup-generic-list-subset-p '(1) nil 'identity '< '=))
  (should (gearup-generic-list-subset-p nil '(t) 'identity '< '=))
  (should (gearup-generic-list-subset-p '(2 1) '(4 5 1 2) 'identity '< '=))
  (should (gearup-generic-list-subset-p '("foo" "bar") '("foobar" "bar" "foo") 'identity 'string-lessp 'string-equal))
  (should (gearup-generic-list-subset-p
           '(("UsedbyType" "Form") ("UsedbyName" "Service"))
           '(("UsedbyType" "Form") ("Name" "Layout") ("UsedbyName" "Service"))
           'car-safe
           'string-lessp 'string-equal)))


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

;; (defun fls-jump-to-xml-node (name attributes incremental)
;;   "Jump to."
;;   (interactive (list name attributes prefix-arg))
;;   (let ((start )))
;;   (gearup-find-xml-node ))

(defun fls-goto-entity-node (prefix)
  "Jump to entity node.
User is queried for an entity name. The name is searched case-insensitive."
  (interactive "p")
  (gearup-query-find-xml-node "Entity" (list (list "Name" (read-string "Entity-name: "))) (> prefix 0))))

(defun gearup-generic-find-xml-node (tag attributes  &optional forward)
  "Jump to TAG with ATTRIBUTES.
If FORWARD is ntn-nil start search from current point position. If CASE is not-nil match attribute values case-sensitive."
  (interactive
   (let ((start (if (> current-prefix-arg 0)
                    (point)
                  (point-min)))
         (tag (read-string "Tag name: "))
         attributes current-attr current-value)
     (while (> (length (setq current-attr (read-string "Attribute name: "))) 0)
       (setq current-value (read-string "Attribute value: "))
       (push (list current-attr current-name) attributes))
     (list tag attributes forward)))
  (gearup-get-xml-node-position tag attributes start))

(defun fls-client-xml-layout-path (&optional usenames)
  "Return plist of xml nodes enclosing point.
  If usenames is not nil use names extracted from name attributes instead of tag names (where possible)."
  (interactive)
  nil)
