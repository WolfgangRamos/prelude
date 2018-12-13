(require 's)

(setq fls-localizer-db-username nil
      fls-localizer-db-password nil)

(defun fls--localizer-db-lookup-logical-key (key)
  "Lookup KEY in localizer DB."
  (let ((process (fls--create-localizer-sql-process nil))
        translation)
    (with-temp-buffer
      (set-process-buffer process (current-buffer))
      (process-send-string process (fls--create-localizer-logical-key-query key))
      (setq translation (fls--parse-translation-from-sql-process-output key process))
      (fls--finish-localizer-sql-process process))
    (message translation)))
    
(defun fls--create-localizer-sql-process (buf)
  "Create new sql process outputting to buffer BUF.
  
Returns the process object."
  (let ((program "sqlplus")
        (single-logon "-LOGON")
        (markup "-MARKUP HTML ON")
        (connection (fls--create-localizer-db-connection-string)))
    (start-process "FLS-Localizer-Lookup" buf command single-logon markup connection)))
    
(defun fls--create-localizer-db-connection-string ()
  "Return connection string for localizer DB."
  (let ((username (fls--get-or-read-localizer-db-username))
        (password (fls--get-or-read-localizer-db-password)))
     (concat "" username "" password "")))

(defun fls--get-or-read-localizer-db-username ()
  "Return localizer DB username.
  
Tries to read username from cache. If cache is empty read it from mini buffer."
  (or fls--localizer-db-username
      (setq fls-localizer-db-username (read-string "Username: "))))

(defun fls--get-or-read-localizer-db-password ()
  "Return localizer DB password.
  
Tries to read password from cache. If cache is empty read it from mini buffer."
  (or fls--localizer-db-password
      (setq fls--localizer-db-password (read-password "Password: ")))

(defun fls--create-localizer-logical-key-query key ()
  "Create query string to lookup logical key."
  (concat "SELECT ..."))
  
(defun fls--parse-translation-from-sql-process-output (key process)  
  "Parse translation of key from PROCESS output buffer."
  (with-current-buffer (process-buffer process)
    (goto-char (point-min))
    (if (re-search-forward "<td>\\([^<]*\\)</td>" nil t)
        (match-string 1)
      (concat "KEY \"" key "\" NOT FOUND."))
  
(defun fls--finish-localizer-sql-process (process)
  "Finish sql porcess."
  (process-send-string "EXIT"))

(defun fls-projecttool-create-project-title (customer-id cr-id cr-title)
  "Create a title for a project tool project according to
developer manual guidelines."
  (interactive "sCustomer Abbreviation: \nsCR 5 digit ID: \nsCR title abbreviated:")
  (let ((title (concat (s-trim customer-id) (s-trim cr-id) " " (s-trim cr-title))))    
    (with-temp-buffer
      (insert title)
      (clipboard-kill-ring-save (point-min) (point-max)))
    (message "\"%s\" has been copied to the clipboard. Remember to link CRM issue to project tool project." title)))

(provide 'gearup-fls)
