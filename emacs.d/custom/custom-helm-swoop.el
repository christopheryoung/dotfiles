(require 'helm-swoop)

(use-package helm
  :init
  (helm-mode 1)

  :config
  ;; Core Helm keybindings
  (global-set-key (kbd "M-x")     'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x b")   'helm-mini)
  (global-set-key (kbd "C-x C-r") 'helm-recentf)
  (global-set-key (kbd "C-c i")   'helm-imenu)
  (global-set-key (kbd "M-y")     'helm-show-kill-ring)

  ;; Fix scrolling in Helm with C-n and C-p
  (define-key helm-map (kbd "C-n") 'helm-next-line)
  (define-key helm-map (kbd "C-p") 'helm-previous-line)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action))

;; Helm Swoop keybindings
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)

;; Customize Helm Swoop
(setq helm-swoop-split-direction 'split-window-vertically)
(setq helm-buffer-max-length 50)

(provide 'custom-helm-swoop)
