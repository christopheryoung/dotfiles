;;; custom-init-python.el --- Python setup  -*- lexical-binding: t -*-

;; Tree-sitter gives better fontification and indentation than the
;; regexp-based python-mode.  The grammar has to be compiled once, with
;; M-x treesit-install-language-grammar; until then Emacs falls back to
;; the old mode on its own.
(add-to-list 'treesit-language-source-alist
	     '(python "https://github.com/tree-sitter/tree-sitter-python"))

(when (treesit-ready-p 'python 'quiet)
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode)))

;; Language server.  ruff is fast and already installed via Brewfile; it
;; provides diagnostics, formatting and the autofix code actions.  It does
;; not do type checking or cross-file navigation -- installing pyright and
;; putting it ahead of ruff here would add those.
(with-eval-after-load 'eglot
  (when (executable-find "ruff")
    (add-to-list 'eglot-server-programs
		 '((python-mode python-ts-mode) . ("ruff" "server")))))

(dolist (hook '(python-mode-hook python-ts-mode-hook))
  (add-hook hook #'eglot-ensure))

(defun custom-python-format-buffer ()
  "Format the current buffer with ruff, via eglot."
  (interactive)
  (when (and (bound-and-true-p eglot--managed-mode)
	     (eglot-server-capable :documentFormattingProvider))
    (eglot-format-buffer)))

(defun custom-find-python-func ()
  "Search the current project for the definition of the symbol at point.
`xref-find-definitions' is better when the language server can answer;
this is the fallback that also finds classes."
  (interactive)
  (let ((symbol (thing-at-point 'symbol t)))
    (if symbol
	(consult-ripgrep (project-root (project-current t))
			 (format "^\\s*(def|class)\\s+%s\\b"
				 (regexp-quote symbol)))
      (message "No symbol at point"))))

(defun custom-python-mode-setup ()
  "Personal Python editing setup."
  (local-set-key (kbd "C-o") 'custom-avy-jump)
  (local-set-key (kbd "M-i") 'consult-line)
  (local-set-key (kbd "C-c C-f") 'custom-find-python-func)
  (add-hook 'before-save-hook 'whitespace-cleanup nil t)
  (add-hook 'before-save-hook 'custom-python-format-buffer nil t))

(dolist (hook '(python-mode-hook python-ts-mode-hook))
  (add-hook hook #'custom-python-mode-setup))

(setq python-fill-docstring-style 'django)

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "C-c C-d") 'custom-find-python-func))

(provide 'custom-init-python)
;;; custom-init-python.el ends here
