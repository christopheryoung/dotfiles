
(require 'python-mode)

(setq py-shell-name "ipython")

(require 'ac-python)

(add-hook 'python-mode-hook
          (progn
            (local-set-key (kbd "C-o") 'ace-jump-mode)))

;; EIN

(require 'ein)
(require 'ein-ac)
(setq ein:use-auto-complete t)
(setq ein:use-smartrep t)

(require 'pydoc-info)

(provide 'custom-init-python)

