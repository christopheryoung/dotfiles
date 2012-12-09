
;; Make sure I have paredit everywhere, including the repl
;; Merci: http://lispservice.posterous.com/paredit-in-the-slime-repl
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)
(mapc (lambda (mode)
        (let ((hook (intern (concat (symbol-name mode)
                                    "-mode-hook"))))
          (add-hook hook (lambda () (paredit-mode +1)))))
      '(emacs-lisp lisp inferior-lisp slime slime-repl))

(provide 'custom-init-paredit)
