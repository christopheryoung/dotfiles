(require 'helm)
(require 'helm-swoop)


(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(setq helm-swoop-split-direction 'split-window-vertically)

(provide 'custom-helm-swoop)
