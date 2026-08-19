;;; custom-grep-init.el --- grep tweaks  -*- lexical-binding: t -*-

;; note: C-c C-p to make grep buffer writable, C-c C-e to apply changes to buffers
(require 'wgrep)

(with-eval-after-load 'grep
  ;; Don't recurse into some directories
  (dolist (dir '("libs" "node_modules" "vendor" "_site" "_cache"
		 ".venv" "__pycache__" ".mypy_cache" ".ruff_cache"))
    (add-to-list 'grep-find-ignored-directories dir))
  (add-to-list 'grep-find-ignored-files "*.pyc"))

(provide 'custom-grep-init)
;;; custom-grep-init.el ends here
