;;; gearup-docker.el --- Prelude mode configuration

;;; Commentary:

;;; Code:
(prelude-require-package 'docker)
(require 'docker)

(add-to-list
 'docker-image-run-custom-args
 `("frontend/dispatch" ("-p 4500:80"
                        "-e GRPC_URI=http://localhost:83 -e SOAP_URI=http://localhost:5678 -e AUTH_ENDPOINT=https://example-keycloak.saas-dev-fls.com/auth -e AUTH_REALM=playground -e AUTH_CLIENT_ID=client7-dispatch"
                        "--name web" "--rm" "-i")))

(define-key shell-mode-map (kbd "C-c C-k") 'comint-kill-subjob)

(provide 'gearup-docker)
;;; gearup-iedit.el ends here
