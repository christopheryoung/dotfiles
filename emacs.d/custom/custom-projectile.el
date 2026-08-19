;;; custom-projectile.el --- Project navigation  -*- lexical-binding: t -*-

(projectile-mode 1)

(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)
(setq projectile-sort-order 'recently-active)

(provide 'custom-projectile)
;;; custom-projectile.el ends here
