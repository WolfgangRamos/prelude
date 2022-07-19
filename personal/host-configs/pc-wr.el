;; make projectile-compile compile protofiles in server proto directory
(dir-locals-set-class-variables
 'server-protobuf-files
 '((protobuf-mode . ((projectile-project-compilation-dir . "communication-definitions")
                     (projectile-project-compilation-cmd . "PowerShell.exe -command \"./compile-protos.ps1\"")))))

(defun wra-test () (org-publish "valuable-test-presentation"))
(dir-locals-set-directory-class
 "c:/Users/Wolfgang.Ramos/dev/visitour/communication-definitions/proto/" 'server-protobuf-files)


;; make org-publish export html
(setq org-publish-project-alist
      (append '(("org-testing-presentation"
                 :base-directory "~/dev/valuable-tests-presentation/"
                 :base-extension "org"

                 :publishing-directory "~/dev/valuable-tests-presentation/public"
                 :recursive t
                 :publishing-function org-html-publish-to-html
                 :headline-levels 4
                 :html-extension "html"
                 :body-only t
                 )

                ("org-static-testing-presentation"
                 :base-directory "~/dev/valuable-tests-presentation/"
                 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php\\|java\\|hs\\|erl"
                 :publishing-directory "~/dev/valuable-tests-presentation/public"
                 :recursive t
                 :publishing-function org-publish-attachment)

                ("valuable-test-presentation" :components ("org-testing-presentation" "org-static-testing-presentation")))
              org-publish-project-alist))

(gearup-org--set-capture-fallback-file "C:/Users/Wolfgang.Ramos/visitour/found_bugs/found-bugs.org")

(setq org-capture-templates
      '(("c" "Client" entry (file+headline "~/visitour/found_bugs/found-bugs.org" "Client")
         "** INCOMPLETE %?\n   :LOGBOOK:\n   - State \"INCOMPLETE\"       from              %U\n   :END:" :prepend t :empty-lines 1)
        ("s" "Server" entry (file+headline "~/visitour/found_bugs/found-bugs.org" "Server")
         "** INCOMPLETE %?\n   :LOGBOOK:\n   - State \"INCOMPLETE\"       from              %U\n   :END:" :prepend t :empty-lines 1)
        ("m" "Mattorunden-Frage" entry (file+headline "~/visitour/mattorunde/questions.org" "Aktuell") "** TODO %?\n   :LOGBOOK:\n   - State \"TODO\"       from              %U\n   :END:" :prepend t :empty-lines 1)))

(message "Loaded host config for PC-PD.")
