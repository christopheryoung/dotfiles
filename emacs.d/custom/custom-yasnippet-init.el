;;; custom-yasnippet-init.el --- Snippets  -*- lexical-binding: t -*-

(require 'yasnippet)
(setq yas-prompt-functions '(yas-completing-prompt))
(yas-load-directory "~/.emacs.d/snippets")
(yas-global-mode 1)

(provide 'custom-yasnippet-init)
;;; custom-yasnippet-init.el ends here
