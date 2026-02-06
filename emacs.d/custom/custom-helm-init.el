(require 'helm)
(require 'helm-config)

;; Enable helm-mode globally
(helm-mode 1)

;; Key bindings
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; Helm-specific settings
(setq helm-buffer-max-length 50)

(define-key helm-map (kbd "C-z") 'helm-select-action)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

(provide 'custom-helm-init)
