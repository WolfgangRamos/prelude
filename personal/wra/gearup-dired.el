;;; gearup-dired.el --- Dired configuration

;;; Commentary:

;;; Code:

(prelude-require-packages '(ace-window wdired find-dired))

(setq dired-guess-shell-alist-user '(("\.mp3$" "vlc.exe --one-instance --playlist-enqueue")))

(defun gearup--allow-edit-file-permissions ()
  "Make file permisions editable in wdired mode."
  (custom-set-variables '(wdired-allow-to-change-permissions t)))

(defun gearup--use-system-trash ()
  "Make deletion in dired move files to system trash."
  (custom-set-variables '(delete-by-moving-to-trash t)))
  
(defun gearup--use-other-dired-buffer-as-default-target-directory ()
  "Make copy, move commands use other dired buffer as target (if there is one)."
  (custom-set-variables '(dired-dwim-target t)))
  
(defun gearup-find-dired--speedup-formatting ()
  "By default Emacs will pass -exec to find and that makes it very slow. It is better to collate the matches and then use xargs to run the command. See URL `https://www.masteringemacs.org/article/working-multiple-files-dired'."
  (custom-set-variables '(find-ls-option (quote ("-print0 | xargs -0 ls -ld" . "-ld")))))

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

(defun gearup-dired--bind-buffer-reusing-visiting-commands ()
  "Bind directory visiting commands that reuse the current buffer."
  (define-key dired-mode-map (kbd "RET") 'gearup-dired-find-file-maybe-reuse-buffer)
  (define-key dired-mode-map (kbd "e") 'gearup-dired-find-file-maybe-reuse-buffer)
  (define-key dired-mode-map (kbd "f") 'gearup-dired-find-file-maybe-reuse-buffer)
  (define-key dired-mode-map (kbd "^") 'gearup-dired-up-directory-reuse-buffer))

(with-eval-after-load 'dired
  (load "dired-x")
  (gearup--use-system-trash)
  (gearup--use-other-dired-buffer-as-default-target-directory)
  (gearup-dired--bind-buffer-reusing-visiting-commands)
  (gearup--dired-initially-hide-details)
  (define-key dired-mode-map "o" 'gearup-find-file-ace-window))

(with-eval-after-load 'wdired 
  (gearup--allow-edit-file-permissions))

(with-eval-after-load 'find-dired
  (gearup-find-dired--speedup-formatting))

(provide 'gearup-dired)
;;; gearup-dired.el ends here
