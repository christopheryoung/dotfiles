;; Generic Python

(add-hook 'python-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "C-o") 'ace-jump-mode)
	     (local-set-key (kbd "M-i") 'helm-swoop)
	     (local-set-key (kbd "C-c M-i") 'helm-multi-swoop)
	     (local-set-key (kbd "C-c C-f") 'custom-find-python-func)
	     (eldoc-mode)
	     (add-hook 'before-save-hook 'whitespace-cleanup)
	     ))

(setq python-fill-docstring-style 'django)

(defun custom-find-python-func ()
  "Finds the Python function definitions in the project"
  (interactive)
  (elpy-rgrep-symbol (concat "def " (thing-at-point 'symbol))))

;; Elpy

(eval-after-load "elpy" '(define-key elpy-mode-map (kbd "C-c C-d") 'custom-find-python-func))
(eval-after-load "python" '(define-key python-mode-map (kbd "C-c C-d") 'custom-find-python-func))

(add-hook 'elpy-mode-hook '(lambda ()
			     (eldoc-mode)
			     ;;(flycheck-mode)
			     (setq python-fill-docstring-style 'django)
			     ;;(add-hook 'before-save-hook 'whitespace-cleanup)
			     ))

(setq python-yapf-path "/scr/young/builds/2021-4/build/buildvenv/*/bin/yapf")
;; (elpy-enable)

(setq flycheck-python-flake8-executable "/scr/young/builds/2021-4/build/buildvenv/*/bin/flake8")
;;(flycheck-select-checker 'python-flake8)
(flycheck-mode t)

(add-hook 'before-save-hook 'whitespace-cleanup)

;; Jedi
(add-hook 'python-mode-hook 'jedi:setup)

(defvar jedi-config:vcs-root-sentinel ".git")

;; getting errors unless I add this hook; eldoc is still on even with this
;; hook, which is good, since it then works, but also puzzling (perhaps with
;; this hook I'm disabling a different or improperly configured version of
;; el-doc that interferes with the one that elpy sets up for me?).


(provide 'custom-init-python)
