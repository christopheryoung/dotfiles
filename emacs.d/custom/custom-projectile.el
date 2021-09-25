(projectile-global-mode)

(setq projectile-completion-system 'flx-ido)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)
(setq projectile-sort-order 'recently-active)

(provide 'custom-projectile)
