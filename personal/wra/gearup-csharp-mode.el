(prelude-require-package 'csharp-mode)
(prelude-require-package 'lsp-mode)
(require 'csharp-mode)

(add-hook 'csharp-mode-hook 'gearup-disable-whitespace-mode)
;; TODO re-register hook when yasnippet is loaded
;;(add-hook 'csharp-mode-hook 'yas-minor-mode-on)
(add-hook 'csharp-mode-hook #'lsp)

;; use this command in cmd
;; "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\devenv.exe" /Edit .\src\VisiTourDomain\Shared\Errors.cs /Command "Edit.GoTo <linenumber>"
(defun gearup-csharp-open-in-visual-studio ()
  (interactive)
  (let ((file-path (convert-standard-filename (buffer-file-name))))
    (message file-path)
    (call-process "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\Common7\\IDE\\devenv.exe" nil nil nil "/Edit" file-path)))
;;(define-key undo-tree-map (kbd "C-?") nil)

(provide 'gearup-csharp-mode)
