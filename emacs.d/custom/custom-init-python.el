;; Generic Python

;; (use-package python-mode
;;   :ensure t
;;   :hook (python-mode . lsp-deferred)
;;   :custom
;;   ;; NOTE: Set these if Python 3 is called "python3" on your system!
;;   ;; (python-shell-interpreter "python3")
;;   ;; (dap-python-executable "python3")
;;   (dap-python-debugger 'debugpy)
;;   :config
;;   (require 'dap-python))

;; (defun efs/lsp-mode-setup ()
;;   (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
;;   (lsp-headerline-breadcrumb-mode))

;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :hook (lsp-mode . efs/lsp-mode-setup)
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
;;   :config
;;   ;(lsp-enable-which-key-integration t)  ; todo: why did I have to comment this out?
;;   )


;; (use-package lsp-ui
;;   :hook (lsp-mode . lsp-ui-mode)
;;   :custom
;;   (lsp-ui-doc-position 'bottom))

;; (use-package lsp-treemacs
;;   :after lsp)

;; (use-package lsp-ivy)

;; (use-package dap-mode
;;   ;; Uncomment the config below if you want all UI panes to be hidden by default!
;;   ;; :custom
;;   ;; (lsp-enable-dap-auto-configure nil)
;;   ;; :config
;;   ;; (dap-ui-mode 1)

;;   :config
;;   ;; Set up Node debugging
;;   (require 'dap-node)
;;   (dap-node-setup) ;; Automatically installs Node debug adapter if needed

;;   ;; Bind `C-c l d` to `dap-hydra` for easy access
;;   (general-define-key
;;     :keymaps 'lsp-mode-map
;;     :prefix lsp-keymap-prefix
;;     "d" '(dap-hydra t :wk "debugger")))


;; (use-package pyvenv
;;   :config
;;   (pyvenv-mode 1))

;;;;;;;

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

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
