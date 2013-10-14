
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
          '(lambda ()
             (local-set-key (kbd "C-o") 'ace-jump-mode)
             (elpy-mode)))

(setq elpy-rpc-backend "jedi")
(package-initialize)
;; why do I need to do this again? elpy-enable doesn't
;; seem to cooperate unless I do
(elpy-enable)
(elpy-use-ipython)
(require 'pydoc-info)

;; getting errors unless I add this hook; eldoc is still on even with this
;; hook, which is good, since it then works, but also puzzling (perhaps with
;; this hook I'm disabling a different or improperly configured version of
;; el-doc that interferes with the one that elpy sets up for me?).
(add-hook 'elpy-mode-hook '(lambda () (eldoc-mode nil))) 

(provide 'custom-init-python)
