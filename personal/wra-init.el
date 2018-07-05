;;; wra-init.el --- My Prelude User Init File

;;; Commentary:

;; THIS FILE IS ONLY USED TO REQUIRE OTHER PACKAGES.
;; DO NOT PUT CODE IN HERE.

;;; Code:
(load-file (expand-file-name "wra/gearup-set-load-path.el" prelude-personal-dir)) ;; load this first
(require 'gearup-utils) ;; load this second
(require 'gearup-base)  ;; load this third
(require 'gearup-hl-tags-mode)
(require 'gearup-prelude)
(require 'gearup-expand-region)
(require 'gearup-easy-kill)
(require 'gearup-hippie-expand)
(require 'gearup-ace-window)
(require 'gearup-avy)
(require 'wra-helm)
(require 'wra-image)
;;(require 'wra-ispell)
(require 'wra-essh)
(require 'wra-ess)
(require 'wra-dired)
(require 'wra-org)
(require 'wra-yasnippet) ;; must  be loaded before auto complete?
(require 'wra-auctex)
(require 'wra-cdlatex)
(require 'wra-shell)
(require 'wra-company)
(require 'x-dict)
(require 'restclient)
;; (require 'wra-restclient)
(require 'gearup-flycheck)
(require 'gearup-smartparens)
(require 'gearup-ms-windows)
;; (require 'wra-nameses)
;;(require 'wra-sunrise-commander)
(require 'gearup-re-builder)
(require 'wra-savehist)
(require 'wra-isearch)
;;(require 'gearup-web-mode)
(require 'gearup-lisp)
;;(require 'gearup-rebox2)
(require 'gearup-nxml-mode)
(require 'gearup-smart-mode-line)
(require 'gearup-misc-prelude-tips)
(require 'gearup-csharp-mode)
(require 'gearup-omnisharp)
(require 'gearup-undo-tree)
(require 'gearup-projectile)
(require 'gearup-multiple-cursors)
;;(require 'gearup-psvn) ;; switched to git svn via magit
(require 'gearup-magit)
(require 'gearup-iedit)
(require 'gearup-gnus)
(require 'gearup-bookmarkp)
(require 'gearup-org-attach-screenshot)
(require 'gearup-host-config) ;; load this last

;;; wra-init.el ends here
