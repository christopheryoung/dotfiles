;;; custom-init-paredit.el --- Paredit for Lisp editing  -*- lexical-binding: t -*-

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

(dolist (hook '(emacs-lisp-mode-hook
		lisp-interaction-mode-hook
		ielm-mode-hook))
  (add-hook hook (lambda () (paredit-mode +1))))

;; paredit hijacks my beloved C-j
(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "C-j") 'delete-other-windows))

(provide 'custom-init-paredit)
;;; custom-init-paredit.el ends here
