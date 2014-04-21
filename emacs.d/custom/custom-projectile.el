
(projectile-global-mode)

(setq projectile-completion-system 'grizzl)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)

(provide 'custom-projectile)
