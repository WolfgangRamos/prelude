(setq user-mail-address "wolfgang.ramos@fastleansmart.onmicrosoft.com"
      user-full-name "Wolfgang Ramos")

(setq gnus-select-method
      '(nnimap "office365"
               (nnimap-address "outlook.office365.com")
               (nnimap-server-port 993)
               (nnimap-stream ssl)))

(setq smtpmail-smtp-server "smtp.office365.com"
      smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
