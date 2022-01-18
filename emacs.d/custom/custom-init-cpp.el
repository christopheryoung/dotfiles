(setq schrodinger-clang-format "/software/lib/Darwin-x86_64/llvm+clang-3.7.1/bin/clang-format")
(setq clang-format-executable schrodinger-clang-format)
(setq-default c-basic-offset 4)

(defun check-clang-format-exists ()
  (interactive)
    (if (not (file-exists-p schrodinger-clang-format))
	(message "Update your clang-format!")))

(defun clang-format-before-save ()
  (interactive)
  (when (eq major-mode 'c++-mode) (clang-format-buffer)))

(add-hook 'c++-mode-hook
	  '(lambda ()
	     (add-hook 'clang-format-buffer nil 'make-it-local)
	     (add-hook 'before-save-hook 'clang-format-before-save)))

(setq lsp-clients-clangd-executable "/usr/local/opt/llvm/bin/clangd")
(setq cquery-executable "/usr/local/bin/cquery")
(require 'cquery)


;; (require 'lsp-ui)
;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)

(provide 'custom-init-cpp)
