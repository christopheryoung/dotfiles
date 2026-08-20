;;; check-config.el --- Smoke test for this Emacs configuration  -*- lexical-binding: t -*-

;; Run after changing the configuration or updating packages:
;;
;;     emacs --batch -l ~/.emacs.d/check-config.el
;;
;; Exits non-zero if anything fails, so it can gate an update.
;;
;; The checks are the things that have actually broken here, not a
;; general test suite: packages moving to Emacs 31 idioms, bindings
;; pointing at commands that were renamed or removed, and configuration
;; variables that quietly stopped being read.
;;
;; Note what batch mode cannot see. Anything needing a window, a command
;; loop, or an idle timer is out of reach -- eglot-ensure only connects
;; once the command loop runs, and jinx's timer never fires. Those are
;; checked here one layer down, at the function that the timer or hook
;; would have called.

(require 'cl-lib)

(defvar check--failures 0)

(defmacro check (label form &optional detail)
  "Report LABEL as passing when FORM is non-nil.  DETAIL is shown either way.
An error raised by FORM counts as a failure rather than stopping the
run, so one broken check still leaves the rest of the report readable."
  `(condition-case err
       (if ,form
	   (message "  ok    %-38s %s" ,label (or ,detail ""))
	 (setq check--failures (1+ check--failures))
	 (message "  FAIL  %-38s %s" ,label (or ,detail "")))
     (error
      (setq check--failures (1+ check--failures))
      (message "  FAIL  %-38s %S" ,label err))))

(message "Emacs %s" emacs-version)

;;;; Packages that have required Emacs 31 in the past

(message "\nEmacs 31 idioms in installed packages")
(let ((offenders
       (cl-loop for dir in (ignore-errors
			     (directory-files
			      (expand-file-name "straight/repos" user-emacs-directory)
			      t "\\`[^.]"))
		for name = (file-name-nondirectory dir)
		;; cl aliases incf/decf, so requiring it makes them safe
		when (and (file-directory-p dir)
			  (zerop (call-process
				  "sh" nil nil nil "-c"
				  (format "grep -rlE '\\((incf|decf) ' %s --include='*.el' | head -1 | grep -q ."
					  (shell-quote-argument dir))))
			  (not (zerop (call-process
				       "sh" nil nil nil "-c"
				       (format "grep -rl \"(require 'cl)\" %s --include='*.el' | head -1 | grep -q ."
					       (shell-quote-argument dir))))))
		collect name)))
  (check "no bare incf/decf outside cl users"
	 (null offenders)
	 (if offenders (mapconcat #'identity offenders ", ") "")))

;;;; Bindings, including ones that broke when a package was renamed

(message "\nKey bindings")
(dolist (spec '(("C-o"     custom-avy-jump)
		("C-x b"   consult-buffer)
		("C-x C-u" vundo)
		("M-_"     undo-redo)
		("M-$"     custom-spellcheck-correct)
		("<f5>"    custom-terminal)
		("C-="     er/expand-region)
		("C-x m"   magit-status)
		("<up>"    smartscan-symbol-go-backward)))
  (let ((actual (key-binding (kbd (car spec)))))
    (check (format "%-9s -> %s" (car spec) (cadr spec))
	   (eq actual (cadr spec))
	   (unless (eq actual (cadr spec)) (format "got %s" actual)))))

;;;; Modes that should be on, and ones that should not

(message "\nModes")
(dolist (m '(vertico-mode marginalia-mode global-corfu-mode which-key-mode
	     global-diff-hl-mode projectile-mode savehist-mode recentf-mode
	     electric-pair-mode desktop-save-mode org-roam-db-autosync-mode))
  (check (symbol-name m) (and (boundp m) (symbol-value m))))
(check "corfu-auto off by default" (null corfu-auto))
(check "jinx off in a new buffer"
       (with-temp-buffer (text-mode) (not (bound-and-true-p jinx-mode))))

;;;; Things that silently stopped working before

(message "\nBehaviour")

;; eglot is autoloaded, and the configuration adds its Python entry
;; inside with-eval-after-load, so it has to be loaded before asking.
(require 'eglot nil t)
(check "magit loads" (fboundp 'magit-status) (ignore-errors (magit-version)))
(let ((keys (with-temp-buffer (org-mode) (ignore-errors (org-ref-valid-keys)))))
  (check "org-ref resolves bibliography" (> (length keys) 0)
	 (format "%d keys" (length keys))))
(check "python language server configured"
       (assoc '(python-mode python-ts-mode) eglot-server-programs)
       (format "%s" (cdr (assoc '(python-mode python-ts-mode) eglot-server-programs))))
(check "python tree-sitter grammar" (treesit-ready-p 'python 'quiet))
;; jinx loads its dictionaries when the mode turns on, so ask inside a
;; buffer where it is enabled rather than at top level.
(check "jinx spell check"
       (with-temp-buffer
	 (text-mode)
	 (jinx-mode 1)
	 (and (jinx--word-valid-p "sentence")
	      (not (jinx--word-valid-p "sentance"))))
       "sentence valid, sentance not")
(check "avy jump submodes"
       (= 3 (length (cl-remove-if-not #'fboundp custom-avy-submode-list))))

;;;; Result

(message "\n%s"
	 (if (zerop check--failures)
	     "All checks passed."
	   (format "%d check(s) FAILED." check--failures)))
(kill-emacs (if (zerop check--failures) 0 1))

;;; check-config.el ends here
