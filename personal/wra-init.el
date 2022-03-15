 ;;; wra-init.el --- My Prelude User Init File

;;; Commentary:

;; THIS FILE IS ONLY USED TO REQUIRE OTHER PACKAGES.
;; DO NOT PUT CODE IN HERE.

;;; Code:
(load-file (expand-file-name "wra/gearup-set-load-path.el" prelude-personal-dir)) ;; load this first
(menu-bar-mode t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
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

(require 'yarn)

(prelude-require-package 'dotnet)
;;; wra-init.el ends here
