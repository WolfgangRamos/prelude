(provide 'wra-ispell)

(defun my-toggle-dictionary ()
  "Toggle Dictionaries"
  (interactive)
  (if (boundp 'ispell-current-dictionary)
      (cond
       ((string= "de" ispell-current-dictionary)
	(ispell-change-dictionary "en")
	(message "changed ispell dictionary to: English"))
       ((string= "en" ispell-current-dictionary)
	(ispell-change-dictionary "de")
	(message "changed ispell dictionary to: German")))
    (progn
      (setq ispell-current-dictionary "de")
      (message "set ispell dictionary to: German"))))

(global-set-key (kbd "C-ä") 'my-toggle-dictionary)
