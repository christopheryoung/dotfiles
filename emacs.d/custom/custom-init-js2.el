
(defun insert-comma-at-the-end-of-the-previous-line ()
  (interactive)
  (save-excursion
    (previous-line)
    (move-end-of-line nil)
    (insert ",")))

(setq-default js2-global-externs '("module" "require" "jQuery" "$" "_" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
(setq-default js2-strict-inconsistent-return-warning nil)
(setq-default js2-auto-indent-p t)

(add-hook 'js2-mode-hook
          (lambda ()
            (imenu-add-menubar-index)
            (local-set-key (kbd "C-c ,") 'insert-comma-at-the-end-of-the-previous-line)
            (local-set-key (kbd "C-c C-n") 'js2-next-error)))


(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'js2-imenu-extras)
(js2-imenu-extras-setup)

(provide 'custom-init-js2)
