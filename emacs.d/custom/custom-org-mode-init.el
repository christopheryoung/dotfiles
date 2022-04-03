;; Just a stub at the moment

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)

(setq org-goto-interface 'outline-path-completion)
(setq org-outline-path-complete-in-steps nil)
(setq org-goto-max-level 1)

(provide 'custom-org-mode-init)
