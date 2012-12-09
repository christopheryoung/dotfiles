
;; M-q is very handy for formatting text, but sometimes you want to remove the
;; formatting . . .
(defun remove-line-breaks ()
  "Remove line endings in a paragraph."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;; Make it easy to get to my worklog
(defun open-worklog ()
  (interactive)
  (find-file "~/Dropbox/cy/notes/worklog.txt"))

(defun worklog-date-stamp ()
  (interactive)
  (insert (format-time-string "%m/%d/%Y ")))




(provide 'custom-defuns)
