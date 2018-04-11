;;; gearup-flycheck.el --- Prelude mode configuration

;;; Commentary:

;;; Code:

(defun gearup--turn-off-flycheck-mode-in-large-buffers ()
  "Disable flychecking large buffers."
  (when (> (buffer-size) 80000)
    (flycheck-mode -1)))

(with-eval-after-load 'flycheck
  (add-hook 'change-major-mode-after-body-hook
            'gearup--turn-off-flycheck-mode-in-large-buffers))

(provide 'gearup-flycheck)
;;; gearup-flycheck.el ends here
