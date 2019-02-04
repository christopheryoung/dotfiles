(add-hook 'python-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "C-o") 'ace-jump-mode)
	     (rainbows-delimiters-mode)))

(add-hook 'python-mode-hook 'jedi:setup)

;; look at C-h v : jedi:server-args
(defvar jedi-config:vcs-root-sentinel ".git")

;; getting errors unless I add this hook; eldoc is still on even with this
;; hook, which is good, since it then works, but also puzzling (perhaps with
;; this hook I'm disabling a different or improperly configured version of
;; el-doc that interferes with the one that elpy sets up for me?).
(add-hook 'python-mode-hook '(lambda () (eldoc-mode)))
(add-hook 'elpy-mode-hook '(lambda ()
			     (eldoc-mode)
			     (whitespace-mode t)
			     (rainbows-delimiters-mode)
			     (flycheck-mode)
			     (local-set-key (kbd "C-h C-j") 'elpy-show-defun)))

(setq python-fill-docstring-style 'django)

(setq python-yapf-path "/Users/young/code/schrodinger/buildvenv/*/bin/yapf")

(let ((workon-home (expand-file-name "~/.virtualenvs")))
  (setenv "WORKON_HOME" workon-home)
  (setenv "VIRTUALENVWRAPPER_HOOK_DIR" workon-home))

;; why do I need to do this again? elpy-enable doesn't
;; seem to cooperate unless I do
(elpy-enable)
(setq elpy-rpc-backend "rope")

(elpy-use-ipython)

;;----------
;; Keybinding to add breakpoint:

(add-hook 'python-mode-hook
	  (function (lambda ()
		    (add-hook 'before-save-hook 'whitespace-cleanup))))

(elpy-enable)

(provide 'custom-init-python)
