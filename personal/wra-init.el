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
;(require 'wra-yasnippet) ;; must be loaded before auto complete?
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
;(require 'gearup-host-config) ;; load this last


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
(setq flycheck-languagetool-server-jar (expand-file-name "assets/language_tool/languagetool-server.jar" prelude-personal-dir))
(add-hook 'org-mode-hook 'flycheck-languagetool-setup)

(defun gearup-flycheck-enable-checker (checker)
  (setq-local flycheck-checkers (append `(,checker) flycheck-checkers)))

(defun gearup-flycheck-enable-languagetool ()
  (gearup-flycheck-enable-checker 'langueagetool))

(add-hook 'org-mode-hook 'gearup-flycheck-enable-languagetool)

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

;;; wra-init.el ends here
