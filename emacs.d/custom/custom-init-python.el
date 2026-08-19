;;; custom-init-python.el --- Python setup  -*- lexical-binding: t -*-

(defun custom-find-python-func ()
  "Search the current project for the definition of the symbol at point."
  (interactive)
  (let ((symbol (thing-at-point 'symbol t)))
    (if symbol
	(consult-ripgrep (project-root (project-current t))
			 (format "^\\s*(def|class)\\s+%s\\b"
				 (regexp-quote symbol)))
      (message "No symbol at point"))))

(add-hook 'python-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-o") 'ace-jump-mode)
	    (local-set-key (kbd "M-i") 'consult-line)
	    (local-set-key (kbd "C-c C-f") 'custom-find-python-func)
	    (add-hook 'before-save-hook 'whitespace-cleanup nil t)))

(setq python-fill-docstring-style 'django)

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "C-c C-d") 'custom-find-python-func))

(provide 'custom-init-python)
;;; custom-init-python.el ends here
