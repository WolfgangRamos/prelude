 ;;; wra-init.el --- My Prelude User Init File

;;; Commentary:

;; THIS FILE IS ONLY USED TO REQUIRE OTHER PACKAGES.
;; DO NOT PUT CODE IN HERE.

;;; Code:
(load-file (expand-file-name "wra/gearup-set-load-path.el" prelude-personal-dir)) ;; load this first
(menu-bar-mode t)
(require 'gearup-ms-windows)
(require 'gearup-utils) ;; load this second
(require 'gearup-base)  ;; load this third
;(require 'gearup-hl-tags-mode)
(require 'gearup-prelude)
;(require 'gearup-zop-to-char)
(require 'gearup-expand-region)
;(require 'gearup-easy-kill)
(require 'gearup-hippie-expand)
(require 'gearup-ace-window)
(require 'gearup-avy)
;(require 'gearup-sql)
(require 'wra-helm)
;(require 'wra-image)
;;;(require 'wra-ispell)
;(require 'wra-essh)
;(require 'wra-ess)
(require 'gearup-dired)
(require 'wra-org)
(require 'wra-yasnippet) ;; must be loaded before auto complete?
;(require 'wra-auctex)
;(require 'wra-cdlatex)
;(require 'wra-shell)
(require 'wra-company)
;(require 'x-dict)
(require 'restclient)
;; (require 'wra-restclient)
;(require 'gearup-flycheck)
;(require 'gearup-smartparens)
;;(require 'wra-sunrise-commander)
;(require 'gearup-re-builder)
;(require 'wra-savehist)
(require 'wra-isearch)
;;(require 'gearup-web-mode)
;(require 'gearup-lisp)
;;(require 'gearup-rebox2)
(require 'gearup-nxml-mode)
;(require 'gearup-smart-mode-line)
;(require 'gearup-misc-prelude-tips)
(require 'gearup-csharp-mode)
(require 'gearup-undo-tree)
(require 'gearup-projectile)
(require 'gearup-multiple-cursors)
(require 'gearup-magit)
(add-to-list 'forge-alist '("gitlab.serverfls.com" "gitlab.serverfls.com/api/v4" "gitlab.serverfls.com" forge-gitlab-repository))
(require 'gearup-iedit)
(require 'gearup-atomic-chrome)
(prelude-require-package 'tiny)
;(require 'gearup-gnus)
;(require 'gearup-org-attach-screenshot)
;(require 'gearup-cc-mode)
(require 'gearup-docker)
(require 'gearup-host-config) ;; load this last


(defun gearup-powershell-new ()
  (interactive)
  (let* ((powerhell-buffer-count (length (seq-filter (lambda (buf) (string-prefix-p "*PowerShell-" (buffer-name buf)))
                                                     (buffer-list))))
         (name (concat "*PowerShell-" (number-to-string powerhell-buffer-count) "*")))
    (powershell name)))

(defun mingw64-shell ()
  "Run cygwin bash in shell mode."
  (interactive)
  (let ((explicit-shell-file-name "C:\\msys64\\usr\\bin\\bash.exe")
        (explicit-bash.exe-args '("--login" "-i")))
    (shell "*bash*")))

;; tying out flyspell (might be useful for commit message buffers as it provides immediate feedback)
;(define-key flyspell-mode-map (kbd "C-.") nil)
;(global-unset-key (kbd "C-M-."))
;(define-key flyspell-mode-map (kbd "C-M-.") 'flyspell-auto-correct-word)
;(define-key flyspell-mode-map (kbd "C-,") nil) ;; was flyspell-next-error
;(define-key flyspell-mode-map (kbd "C-;") nil)


;; trying out spellchecking with flycheck and languagetool
(prelude-require-package 'flycheck-languagetool)
(require 'flycheck-languagetool)
(setq flycheck-languagetool-server-jar (expand-file-name "assets/language_tool/languagetool-server.jar" prelude-personal-dir))

(flycheck-add-mode 'languagetool 'gfm-mode) ;; associate languagetool with gfm mode

(defun gearup-flycheck-enable-checker (checker)
  (when (not (member checker flycheck-checkers))
    (setq-local flycheck-checkers (append `(,checker) flycheck-checkers))))

(defun gearup-flycheck-disable-checker (checker)
  (when (member checker flycheck-checkers)
    (setq-local flycheck-checkers (remove `(,checker) flycheck-checkers))))

(defun gearup-flycheck-enable-languagetool ()
  (gearup-flycheck-enable-checker 'langueagetool))

(defun gearup-flycheck-disable-languagetool ()
  (gearup-flycheck-disable-checker 'langueagetool))

(add-hook 'org-mode-hook 'gearup-flycheck-enable-languagetool)
(add-hook 'org-mode-hook 'flycheck-languagetool-setup)
(add-hook 'markdown-mode-hook 'gearup-flycheck-enable-languagetool)
(add-hook 'markdown-mode-hook 'flycheck-languagetool-setup)

(global-set-key (kbd "C-M-.") 'ispell-word)
(define-key flyspell-mode-map (kbd "C-,") nil) ;; was flyspell-next-error
(global-set-key (kbd "C-M-,") 'flycheck-previous-error)
(global-set-key (kbd "C-M--") 'flycheck-next-error)
(global-set-key (kbd "C-M-/") 'flycheck-next-error)


;; trying out a dictionary package
(prelude-require-package 'define-word)
(global-set-key (kbd "C-c ? ?") 'define-word-at-point)
(define-key org-mode-map (kbd "C-c ?") nil)


;; trying out a web search package
(prelude-require-package 'search-web)
(require 'search-web)
(setq search-web-in-emacs-browser 'eww-browse-url)
(custom-set-variables '(search-web-engines
                        (quote (("duck" "https://duckduckgo.com/lite/?q=%s" In-Emacs)
                                ("duck external" "https://duckduckgo.com/?q=%s" External)
                                ("google" "http://www.google.com/search?q=%s" In-Emacs)
                                ("google external" "http://www.google.com/search?q=%s" External)
                                ("youtube" "http://www.youtube.com/results?search_type=&search_query=%s&aq=f" External)
                                ("wiki" "http://www.wikipedia.org/search-redirect.php?search=%s&language=en" In-Emacs)
                                ("wiktionary (en)" "http://en.wiktionary.org/wiki/%s" In-Emacs)
                                ("wiktionary (de)" "http://de.wiktionary.org/wiki/%s" In-Emacs)))))
(global-set-key (kbd "C-c ? w") 'search-web-dwim)
(global-set-key (kbd "C-c ? W") 'search-web)

;; yarn
(require 'yarn)

;; other
(prelude-require-package 'dotnet)
(prelude-require-package 'gitlab-pipeline)
(global-set-key (kbd "C-S-<left>") 'winner-undo)
(global-set-key (kbd "C-S-<right>") 'winner-redo)

;; env-file mode
(prelude-require-package 'dotenv-mode)

(setq sql-ms-program "/opt/mssql-tools/bin/sqlcmd")

;; To allow entering keys for gpg en-/decryption in emacs
;; add these lines to ~/.gnupg/gpg-agent.conf:
;;
;; allow-emacs-pinentry
;; allow-loopback-pinentry
(setq epa-pinentry-mode 'loopback)
(prelude-require-package 'pinentry)
(pinentry-start)

(setq ag-group-matches nil) ;; print file name for each match

(prelude-require-package 'hcl-mode)

(prelude-require-package 'graphviz-dot-mode)
(setq graphviz-dot-preview-extension "svg")

;; Oauth2 token via Emacs
(prelude-require-package 'oauth2)
(defun gearup-wsl-browse-url-handler (url &rest args)
  "Work around reserved character issue of WSL default browser cmd.exe /c start."
  (call-process "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" nil 0 nil "start" (concat "\"" url "\"")))

(setq browse-url-handlers '(("https://.+/realms/.+/protocol/openid-connect/auth.*" . gearup-wsl-browse-url-handler)))

(defvar gearup-keycloak-hostname-history nil
  "History of Keycloak URLs.")

(defvar gearup-keycloak-realm-history nil
  "History of Keycloak Realms.")

(defvar gearup-keycloak-client-id-history nil
  "History of Keycloak Client IDs.")

(defvar gearup-keycloak-client-secrets-history nil
  "History of Keycloak Client Secrets.")

(defvar gearup-keycloak-scope-history nil
  "History of Keycloak Scopes.")

(defvar gearup-keycloak-realms-relative-path-history nil
  "History of Keycloak HTTP relative paths to realms.
See https://www.keycloak.org/server/all-config#category-http")

(defun gearup-keycloak-get-token (protocol-and-hostname realms-relative-path realm client-id client-secret scope)
  "Get a token from a keycloak instance."
  (interactive
   (let ((protocol-and-hostname (read-string "Keycloak protocol and hostname (default is \"https://idp.fls-dev.cloud\"): " nil 'gearup-keycloak-hostname-history "https://idp.fls-dev.cloud"))
         (realms-relative-path (read-string "HTTP relative path to realms (default is \"\", sometime \"/auth\" is needed): " nil ''gearup-keycloak-realms-relative-path-history ""))
         (realm (read-string "Realm (default is \"development\"): " nil 'gearup-keycloak-realm-history "development"))
         (client-id (read-string "Client-ID (default is \"visitour-api\"): " nil 'gearup-keycloak-client-id-history "visitour-api"))
         (client-secret (read-string "Client secret (default is \"714c4e31-074d-4aef-925e-bd43efe50a2c\"): " nil 'gearup-keycloak-client-secrets-history "714c4e31-074d-4aef-925e-bd43efe50a2c"))
         (scope (read-string "Scope (default is \"openid): " nil 'gearup-keycloak-scope-history "openid")))
     (list protocol-and-hostname realms-relative-path realm client-id client-secret scope)))
  (let* ((base-url (concat protocol-and-hostname realms-relative-path "/realms/" realm "/protocol/openid-connect"))
         (auth-url (concat base-url "/auth"))
         (token-url (concat base-url "/token"))
         (token-object (oauth2-auth auth-url token-url client-id client-secret scope nil "http://oauth.pstmn.io/v1/callback"))
         (token (oauth2-token-access-token token-object)))
    (kill-new token)
    (message (concat "Copied to clipboard token \"" (substring token 0 9) "..." (substring token -10) "\""))))

;; (setq token
;;       (let ((auth-url "https://localhost:8443/auth/realms/Zinier/protocol/openid-connect/auth")
;;             (token-url "https://localhost:8443/auth/realms/Zinier/protocol/openid-connect/token")
;;             (client-id "scheduling-api")
;;             (client-secret "Y71TVTkjCWpXhEpe9GmuWsu3Awl3IYE2")
;;             (scope "openid"))
;;         (oauth2-auth-and-store auth-url token-url scope client-id client-secret "http://localhost:8888/foo")))
;; (oauth2-token-access-token token)

;; discover Keycloak endpoints at:
;; https://idp.fls-dev.cloud/auth/realms/development/.well-known/openid-configuration

(prelude-require-package 'adoc-mode)

;; Disable whitespace mode
(remove-hook 'yaml-mode-hook 'whitespace-mode)

;; Prevent Emacs to go responseless when accidentially pressing C-z
(global-unset-key (kbd "C-z"))
;;; wra-init.el ends here
