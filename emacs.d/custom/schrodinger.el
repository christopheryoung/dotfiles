
(setq ffip-project-root "~/code/schrodinger_src")

(setenv "PYTHONPATH" "/Users/young/.virtualenvs/sch/bin/python")
(setq python-shell-interpreter "/Users/young/.virtualenvs/sch/bin/python")

;; (defun set-exec-path-from-shell-PATH ()
;;   (let ((path-from-shell (replace-regexp-in-string
;;                           "[ \t\n]*$"
;;                           ""
;;                           (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))

;; (setq virtualenv-root "/scr/young/virtualenv/bin")
;;(virtualenv-workon "~/.virtualenvs/sch")

(setq python-check-command "/Users/young/.virtualenvs/sch/bin/pyflakes")
(add-to-list 'exec-path "~/.virtualenvs/sch/bin")
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(defun work-entry ()
  (interactive)
  (insert (make-string 79 ?*))
  (insert "\n")
  (insert (format-time-string "%Y-%m-%d %H:%M:%S"))
  (insert "\n\n"))

(defun next-work-entry ()
  (interactive)
  (end-of-line)
  (search-forward (make-string 79 ?*))
  (beginning-of-line))

(defun previous-work-entry ()
  (interactive)
  (beginning-of-line)
  (search-backward (make-string 79 ?*))
  (beginning-of-line))

(add-hook
 'text-mode-hook
 '(lambda ()
    (local-set-key (kbd "C-c C-n") 'next-work-entry)
    (local-set-key (kbd "C-c C-i") 'work-entry)
    (local-set-key (kbd "C-c C-p") 'previous-work-entry)))

(provide 'schrodinger)
