
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)

(add-hook 'clojure-mode-hook
          (lambda ()
            (require 'midje-mode)
            (require 'clojure-jump-to-file)
            (imenu-add-menubar-index)
            (local-set-key (kbd "C-c C-j") 'nrepl-jack-in)
            (local-set-key (kbd "C-c C-,") 'midje-check-fact)
            (local-set-key (kbd "C-z") 'nrepl-eval-expression-at-point)))

;; Macs are odd; had to do this to get clojure-jack-in working
(if *on-a-mac*
    (setenv "PATH" (concat "~/bin:" (getenv "PATH"))))

(setenv "PATH" (shell-command-to-string "echo $PATH"))

(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'clojure-nrepl-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(global-set-key (kbd "C-h C-j") 'javadoc-lookup)

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
