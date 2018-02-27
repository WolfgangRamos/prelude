(call-process "global" nil t nil "-p")

(defun gearup-ggtags-debug-ggtags-project-root ()
  "this is the value ggtags-project-root is set to."
  (interactive)
  (or (ignore-errors
        (file-name-as-directory
         (concat (file-remote-p default-directory)
                 ;; Resolves symbolic links
                 (ggtags-process-string "global" "-pr"))))
      ;; 'global -pr' resolves symlinks before checking the
      ;; GTAGS file which could cause issues such as
      ;; https://github.com/leoliu/ggtags/issues/22, so
      ;; let's help it out.
      ;;
      ;; Note: `locate-dominating-file' doesn't accept
      ;; function for NAME before 24.3.
      (let ((dir (locate-dominating-file default-directory "GTAGS")))
        ;; `file-truename' may strip the trailing '/' on
        ;; remote hosts, see http://debbugs.gnu.org/16851
        (and dir (file-regular-p (expand-file-name "GTAGS" dir))
             (file-name-as-directory (file-truename dir))))))

(setq default-directory "/c/Users/wra/prj/EmacsKeys/")
