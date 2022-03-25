;;; wra-company.el --- My Company Configuration

;;; Commentary

;;; Code
(prelude-require-packages '(company))
(prelude-require-package 'helm-company)
(require 'company)
(prelude-require-package 'helm-company)

(custom-set-variables '(company-idle-delay nil)
                      '(company-dabbrev-downcase t)
                      '(company-dabbrev-minimum-length 1)
                      '(company-tooltip-limit 6)
                      '(company-quick-access-modifier 'control)
                      '(company-quick-access-keys '("a" "d" "f" "j" "k" "l")))

(setq ispell-complete-word-dict (expand-file-name "assets/aspell_wordlist_export_en.txt" prelude-personal-dir))
(setq ispell-look-p t) ;; look doesn't seem to work on windows

(defvar-local gearup-company--space-was-inserted nil)

(defun gearup-company--insert-space-if-needed ()
  (when (and (not company-candidates-length) (looking-at-p "[[:graph:]]"))
    (save-excursion (insert ?\ ))
    (setq-local gearup-company--space-was-inserted t)))

(defun gearup-company-complete-maybe-insert-space ()
  "Allow starting completion in the middle of words by insert a
space if needed."
  (interactive)
  (gearup-company--insert-space-if-needed)
  (call-interactively 'company-complete))

(defun gearup-company--cleanup-inserted-space (&optional manually)
  (when gearup-company--space-was-inserted
    (setq-local gearup-company--space-was-inserted nil)
    (delete-char 1)))

(defun gearup-company-begin-backend-maybe-insert-space ()
  "Allow starting completion in the middle of words by insert a
space if needed."
  (interactive)
  (gearup-company--insert-space-if-needed)
  (let ((inhibit-quit t))
    (unless
        (with-local-quit
          (call-interactively 'company-begin-backend)
          t)
      (gearup-company--cleanup-inserted-space))))

(add-hook 'company-after-completion-hook #'gearup-company--cleanup-inserted-space)

(global-set-key (kbd "C-;") 'set-mark-command)
(global-set-key (kbd "C-ö") 'set-mark-command)

(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-SPC") 'company-complete-selection)
(define-key company-active-map (kbd "C-M-s") nil)
(define-key company-active-map (kbd "C-S") 'company-filter-candidates)

(define-key company-mode-map (kbd "C-SPC") 'gearup-company-complete-maybe-insert-space)
(define-key company-mode-map (kbd "C-S-SPC") 'gearup-company-begin-backend-maybe-insert-space)

(define-key company-mode-map (kbd "C-M-;") 'helm-company)

(defvar gearup-company--after-completion-finished-map (make-sparse-keymap)
  "Transient keymap used to undo last `company-mode' completion.")

(define-key gearup-company--after-completion-finished-map (kbd "C-SPC") 'undo)

(defun gearup-company--activate-after-completion-map (selection)
  (set-transient-map gearup-company--after-completion-finished-map))

(add-hook 'company-after-completion-hook #'gearup-company--activate-after-completion-map)

(push 'text-mode company-dabbrev-code-modes) ;; dabbrev-code is better for completing case-sensitive text even is text-mode derived modes

(defun gearup-company--configure-text-mode-completion ()
  (setq-local company-backends
              '((company-dabbrev-code :with company-ispell))
              company-transformers '(company-sort-by-occurrence company-sort-by-backend-importance)))

(add-hook 'text-mode-hook #'gearup-company--configure-text-mode-completion)

(provide 'wra-company)
;;; wra-company.el ends here
