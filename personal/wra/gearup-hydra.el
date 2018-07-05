;;; gearup-hydra.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'hydra)

(defvar gearup-before-enter-hydra-state-hook nil
  "Hook run before entering hydra state.")

(defvar gearup-before-exit-hydra-state-hook nil
  "Hook run before exiting hydra state.")

(defun gearup-hydra--before-enter-hydra-state ()
  "Execute `gearup-before-enter-hydra-state-hook'."
  (run-hooks 'gearup-before-enter-hydra-state-hook))

(defun gearup-hydra--before-exit-hydra-state ()
  "Execute `gearup-before-exit-hydra-state-hook'."
  (run-hooks 'gearup-before-exit-hydra-state-hook))

(defun gearup--enable-key-chords ()
  "Enable key-chords."
  (key-chord-mode 1))

(defun gearup--disable-key-chords ()
  "Disable key-chords."
  (key-chord-mode 0))

(add-hook 'gearup-hydra--before-enter-hydra-state 'gearup--disable-key-chords)
(add-hook 'gearup-hydra--before-exit-hydra-state 'gearup--enable-key-chords)

(provide 'gearup-hydra)
;;; gearup-hydra.el ends here
