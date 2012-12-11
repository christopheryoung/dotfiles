
(require 'python-mode)
(setq py-shell-name "ipython")
(require 'ac-python)

(add-hook 'python-mode-hook
          (progn
            (local-set-key (kbd "C-o") 'ace-jump-mode)))

(provide 'custom-init-python)

