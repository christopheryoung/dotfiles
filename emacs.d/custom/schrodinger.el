
(setq ffip-project-root "/scr/young/schrodinger_src")
(setq virtualenv-default-directory "/scr/young")

(setenv "PYTHONPATH" "/scr/young/virtualenv/bin/python")
(setq python-shell-interpreter "/scr/young/virtualenv/bin/python")

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;; (setq virtualenv-root "/scr/young/virtualenv/bin")
;; (virtualenv-workon "/scr/young/virtualenv")

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
