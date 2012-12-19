
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode t)

(autoload 'elisp-slime-nav-mode "elisp-slime-nav")
(add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode t)))

(provide 'custom-init-elisp)
