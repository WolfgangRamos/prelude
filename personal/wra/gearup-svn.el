;;; gearup-svn.el --- SVN configuration

;;; Commentary:

;;; Code:
(require 'vc-svn)
(require 'dsvn)
(require 'seq)

(defvar gearup-svn-stash-directory
  (let ((home-dir (if (eq system-type 'windows-nt)
                      (concat (getenv "HOMEDRIVE") (getenv "HOMEPATH"))
                    (getenv "HOME"))))
    (expand-file-name ".svn-stashes/" home-dir))
  "Directory to store stash directories in.")

(defvar gearup-svn-diff-function nil
  "Function to be called to perform diff.
The function is called with two files.")

(defun gearup-svn--branch-name ()
  "Get name of current branch."
  (with-current-buffer (svn-run-hidden 'info ())
    (let* ((case-fold-search nil)
           (info-output (buffer-string))
           (branch-name (or
                         (gearup-svn--try-get-feature-branch-name-from-svn-info-output info-output)
                         (gearup-svn--try-get-trunk-name-from-svn-info-output info-output))))
      (if branch-name
          branch-name
        (error "Couldn't find a branch name")))))

(defun gearup-svn--try-get-feature-branch-name-from-svn-info-output (output)
  "Get Feature branch name from svn info OUTPUT."
  (if (and
       (stringp output)
       (string-match "^URL: .+?/Features/\\(.+\\)$" output))
      (match-string 1 output)
    nil))

(defun gearup-svn--try-get-trunk-name-from-svn-info-output (output)
  "Get Feature branch name from svn info OUTPUT."
  (if (and
       (stringp output)
       (string-match "^URL: .+/trunk$" output))
      "trunk"
    nil))

(defun gearup-svn--working-copy-root-path ()
  "Get path of repo root."
  (with-current-buffer (svn-run-hidden 'info ())
    (let* ((case-fold-search nil)
           (info-output (buffer-string)))
      (if (and
           (stringp info-output)
           (string-match "^Working Copy Root Path: \\(.+\\)" info-output))
          (replace-regexp-in-string "\\\\" "/" (match-string 1 info-output))
        nil))))

(defun gearup-svn-stash-marked ()
  "Stash marked files."
  (interactive)
  (when (or (not (stringp gearup-svn-stash-directory)) (string-empty-p gearup-svn-stash-directory))
    (error "You must set `gearup-svn-stash-directory' before trying to stash files file."))
  (let* ((files (svn-action-files))
         (branch-name (gearup-svn--branch-name))
         (stash-dir (gearup-svn--create-stash-dir branch-name))
         (repo-root (gearup-svn--working-copy-root-path)))
    (gearup-svn--copy-files files repo-root stash-dir)
    (mapc (lambda (file) (svn-run 'revert (list file))) files)
    (message "Created stash %s" stash-dir)))

(defun gearup-svn-apply-stash ()
  "Apply stash."
  (interactive)
  (unless (functionp gearup-svn-diff-function)
    (error "You must set `gearup-svn-diff-function' before trying to stash hunks from a file."))
  (let* ((filename (gearup-svn--file-at-point (point)))
         (filename-local (file-name-nondirectory filename))
         (branch-name (gearup-svn--branch-name))
         (stash-dir (gearup-svn--create-stash-dir branch-name))
         (new-filename (expand-file-name filename-local stash-dir)))
    (copy-file filename new-filename)
    (svn-run 'revert filename (format "Reverting file %s" filename))
    (apply gearup-svn-diff-function filename new-filename)))

(defun gearup-svn--copy-files (files repo-root stash-dir)
  "Stash FILES.

FILES can be either a string specifying the relative path to a
single file or a list of relative path strings. Stashing is done
by copying FILES from REPO-ROOT to STASH-DIR and reverting them
in the svn working copy."
  (when (stringp files)
    (setq files (list files)))
  (unless (listp files)
    (error "Files must be a list."))
  (let* ((files-absolute (mapcar (lambda (file) (expand-file-name file repo-root)) files))
         (new-files-absolute (mapcar (lambda (file) (expand-file-name file stash-dir)) files)))
    (seq-mapn (lambda (source dest) (make-directory (file-name-directory dest) t) (copy-file source dest nil t)) files-absolute new-files-absolute)))

(defun gearup-svn--create-stash-dir (branch-name)
  "Create a stash dir name for branch BRANCH-NAME."
  (let* ((stash-dir-name (concat branch-name "_" (format-time-string "%Y-%m-%dT%H-%M-%S")))
         (stash-dir (expand-file-name (concat stash-dir-name "/") gearup-svn-stash-directory)))
    (if (or (not (stringp branch-name)) (string-empty-p branch-name)
            (not (stringp gearup-svn-stash-directory)) (string-empty-p gearup-svn-stash-directory))
        (error "Could not create a stash dir name")
      (make-directory stash-dir t)
      stash-dir)))

(defun gearup-svn--file-at-point (position)
  "Retun fully qualified path of file at POSITION."
  (let ((filename (svn-getprop position 'file)))
    (if filename
        (find-file filename)
      (error "No file on this line"))))

;;; keybindings

(defun gearup-svn--set-keybindings ()
  "Add keybindings to svn mode maps."
  (define-key svn-status-mode-map (kbd "z") 'gearup-svn-stash-marked))

(gearup-svn--set-keybindings)

(provide 'gearup-svn)
;;; gearup-svn.el ends here
