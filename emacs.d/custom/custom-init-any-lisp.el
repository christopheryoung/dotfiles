
(defun eval-and-replace ()
  "Replace the preceding sexp with its value.
https://github.com/magnars/.emacs.d/blob/master/defuns/lisp-defuns.el"
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(provide 'custom-init-any-lisp)
