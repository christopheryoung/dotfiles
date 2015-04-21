
;; Functions that make it even easier to interact with clojure in emacs.

(defun symbol-at-point-to-string ()
  (interactive)
  (let* ((bounds (bounds-of-thing-at-point 'symbol))
         (start (car bounds))
         (end (cdr bounds)))
    (buffer-substring-no-properties start end)))

(defun get-symbols-in-buffer ()
  (interactive)
  (let ((symbols '()))
    (save-excursion
      (goto-char (point-min))
      (while (forward-symbol 1)
        (setq symbols (cons (symbol-at-point-to-string) symbols))))
    symbols))

(defun clojure-interns (string)
  (let ((namespace-lookup (format "(map str (keys (ns-interns '%s)))" string)))
    (nrepl-interactive-eval namespace-lookup)))

(defun inspect-clojure-namespace (string)
  (interactive (list (read-from-minibuffer "Namespace: ")))
  (clojure-interns string))

(defun inspect-clojure-namespace-at-point ()
  (interactive)
  (listp (clojure-interns (nrepl-symbol-at-point))))

(defun clj-use ()
  "This doesn't work yet"
  (interactive)
  (mapconcat 'identity (intersection (get-symbols-in-buffer) (inspect-clojure-namespace-at-point) :test 'string=) ""))

(provide 'custom-init-clojure)
