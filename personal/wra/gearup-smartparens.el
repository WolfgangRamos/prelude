;;; gearup-smartparens.el --- Prelude mode configuration

;;; Commentary:

;;; Code:

(defun gearup--turn-off-smartparens-mode-in-large-buffers ()
  "Disable smartparens-mode in large buffers.

Smartparens-mode freezes emacs when enabled in large files."
  (when (> (buffer-size) 80000)
    (turn-off-show-smartparens-mode)))

(with-eval-after-load 'smartparens
  (add-hook 'change-major-mode-after-body-hook
            'gearup--turn-off-smartparens-mode-in-large-buffers))

(provide 'gearup-smartparens)
;;; gearup-smartparens.el ends here
