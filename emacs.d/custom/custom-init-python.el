
(require 'python-mode)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . elpy-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(require 'ipython)

(require 'python-pylint)
(autoload 'pylint "pylint")
(add-hook 'python-mode-hook 'pylint-add-menu-items)
(add-hook 'python-mode-hook 'pylint-add-key-bindings)

(setq py-shell-name "ipython")

(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
 "from IPython.core.completerlib import module_completion")

(setq py-python-command-args '("--colors=linux"))

(setq python-shell-completion-string-code
      "';'.join(__IP.complete('''%s'''))\n"
      python-shell-completion-module-string-code "")

(add-hook 'python-mode-hook
          (progn
            (local-set-key (kbd "C-o") 'ace-jump-mode)

            (elpy-mode 1)
            (elpy-use-ipython)))

(elpy-enable)
(elpy-use-ipython)
(require 'pydoc-info)

(provide 'custom-init-python)
