;; Generic Python

(add-hook 'python-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "C-o") 'ace-jump-mode)
	     (local-set-key (kbd "M-i") 'helm-swoop)
	     (local-set-key (kbd "C-c M-i") 'helm-multi-swoop)
	     (local-set-key (kbd "C-c C-f") 'custom-find-python-func)
	     (setq python-fill-docstring-style 'django)
	     (add-hook 'before-save-hook 'whitespace-cleanup)
	     ))

(setq python-fill-docstring-style 'django)

(use-package company-jedi
  :ensure t
  :config
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'my/python-mode-hook))

(defun custom-find-python-func ()
  "Finds the Python function definitions in the project"
  (interactive)
  (elpy-rgrep-symbol (concat "def " (thing-at-point 'symbol))))

;; Elpy

(eval-after-load "elpy" '(define-key elpy-mode-map (kbd "C-c C-d") 'custom-find-python-func))
(eval-after-load "python" '(define-key python-mode-map (kbd "C-c C-d") 'custom-find-python-func))

(defvar jedi-config:vcs-root-sentinel ".git")

(provide 'custom-init-python)
