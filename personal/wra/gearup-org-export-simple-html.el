(org-export-define-derived-backend 'simple-html 'html
  :menu-entry
  '(?f "Export to simple html" ;; FIXME verify f is not taken
       ((?F "As simple html buffer"
	    (lambda (a s v b) (org-rss-export-as-simple-html a s v)))
	(?f "As simple html file" (lambda (a s v b) (org-rss-export-to-simple-html a s v)))
	(?o "As simple html file and open"
	    (lambda (a s v b)
	      (if a (org-rss-export-to-simple-html t s v)
		(org-open-file (org-rss-export-to-simple-html nil s v)))))))
  :options-alist
  '((:description "DESCRIPTION" nil nil newline)
    (:keywords "KEYWORDS" nil nil space)
    (:with-toc nil nil nil) ;; Never include HTML's toc
    (:rss-extension "RSS_EXTENSION" nil org-rss-extension)
    (:rss-image-url "RSS_IMAGE_URL" nil org-rss-image-url)
    (:rss-categories nil nil org-rss-categories))
  :filters-alist '((:filter-final-output . org-rss-final-function))
  :translate-alist '((headline . org-rss-headline)
		     (comment . (lambda (&rest args) ""))
		     (comment-block . (lambda (&rest args) ""))
		     (timestamp . (lambda (&rest args) ""))
		     (plain-text . org-rss-plain-text)
		     (section . org-rss-section)
		     (template . org-rss-template)))
