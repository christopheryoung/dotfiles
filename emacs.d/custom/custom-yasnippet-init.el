
(require 'yasnippet)
(setq yas/prompt-functions '(yas/ido-prompt
                             yas/completing-prompt))
(yas-load-directory "~/.emacs.d/snippets")
(yas-global-mode 1)


(provide 'custom-yasnippet-init)
