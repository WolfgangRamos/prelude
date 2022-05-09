;;; gearup-dired.el --- Dired configuration

;;; Commentary:

;;; Code:

(prelude-require-packages '(ace-window wdired find-dired))
(require 'ace-window)

(defun gearup-dired-copy-path-as-kill (arg)
  "Copy the absolute or project root relative path of file at point to the kill ring.

If called with a prefix arg C-u, use the file path relative to
the project root (e.g. the root directory of the git repository)."
  (interactive "p")
  (let ((full-path (dired-copy-filename-as-kill 0)))
    (if (<= arg 1)
        full-path
      (let* ((project-root (projectile-project-root))
             (relative-path (substring full-path (length project-root) nil)))
        (kill-new relative-path)
        (message relative-path)
        relative-path))))

(defun gearup-find-file-ace-window ()
  "Select a window to open a file using ace window."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (if (> (length (aw-window-list)) 1)
        (aw-select "" (lambda (window)
                        (aw-switch-to-window window)
                        (find-file file)))
      (find-file-other-window file))))

(defun gearup--dired-initially-hide-details ()
  "Initially hide details in dired buffers."
  (add-hook 'dired-mode-hook 'dired-hide-details-mode))

(defun gearup-dired-find-file-maybe-reuse-buffer ()
  "Find files while reusing dired buffer for directories."
  (interactive)
  (if (file-directory-p (dired-filename-at-point))
      (let ((original-buffer (current-buffer)))
        (dired-find-file)
        (kill-buffer original-buffer))
    (dired-find-file)))

(defun gearup-dired-up-directory-reuse-buffer (&optional other-window)
  "Find parent directory reusing buffer."
  (interactive "P")
  (let* ((original-buffer (current-buffer)))
    (dired-up-directory other-window)
    (unless (eq original-buffer (current-buffer))
      (kill-buffer original-buffer))))

(custom-set-variables '(wdired-allow-to-change-permissions t) ;; make file permisions editable in wdired mode
                      '(delete-by-moving-to-trash t) ;; make deletion in dired move files to system trash
                      '(dired-dwim-target 'dired-dwim-target-recent) ;; prefere most recent viewed buffer as dired target
                      '(find-ls-option (quote ("-print0 | xargs -0 ls -ld" . "-ld"))) ;; by default Emacs will pass -exec to find and that makes it very slow. It is better to collate the matches and then use xargs to run the command. See URL `https://www.masteringemacs.org/article/working-multiple-files-dired'.
                      '(dired-guess-shell-alist-user '(("\.mp3$" "vlc.exe --one-instance --playlist-enqueue")
                                                       ("\.pdf$" "\"C:/Program Files (x86)/Foxit Software/Foxit Reader/FoxitReader.exe\"")
                                                       ("\.exe$" "start \"\"")
                                                       ("\.\(png\|jpg\)" "mspaint")
                                                       ("\.sln$" "\"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\Common7\\IDE\\devenv.exe\"")))
                      )

;; fix find on windows
(when (equal system-type 'windows-nt)
  (setq find-program "c:\\msys64\\usr\\bin\\find.exe")
  (setq find-ls-option '("-ls" . "-dilsb")))

;; Dired provides no function to do isearch on filenames in backward direction.
;; Therefore I define it myself
(defun gearup-dired-isearch-filenames-reverse ()
  "Search for a string using Isearch only in file names in the Dired buffer."
  (interactive)
  (setq-local dired-isearch-filenames t)
  (isearch-backward nil t))


(with-eval-after-load 'dired
  (load "dired-x")
  (add-hook 'dired-mode-hook 'dired-hide-details-mode) ;; initially hide details (e.g. file permissions) in dired buffers
  (define-key dired-mode-map (kbd "RET") 'gearup-dired-find-file-maybe-reuse-buffer)
  (define-key dired-mode-map (kbd "e") 'gearup-dired-find-file-maybe-reuse-buffer)
  (define-key dired-mode-map (kbd "f") 'gearup-dired-find-file-maybe-reuse-buffer)
  (define-key dired-mode-map (kbd "^") 'gearup-dired-up-directory-reuse-buffer)
  (define-key dired-mode-map (kbd "o") 'gearup-find-file-ace-window)
  (define-key dired-mode-map (kbd "C-s") 'dired-isearch-filenames)
  (define-key dired-mode-map (kbd "C-r") 'gearup-dired-isearch-filenames-reverse)
  (define-key dired-mode-map (kbd "W") 'gearup-dired-copy-path-as-kill)
  (define-key dired-mode-map (kbd "M-n") 'dired-next-marked-file)
  (define-key dired-mode-map (kbd "M-p") 'dired-prev-marked-file))

(provide 'gearup-dired)
;;; gearup-dired.el ends here
