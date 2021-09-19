;; Thanks: http://emacsredux.com/blog/2013/07/24/highlight-comment-annotations/
(defun font-lock-comment-annotations ()
;;  "Highlight a bunch of well known comment annotations.
;;This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\|NOTE\\):"
	  1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'font-lock-comment-annotations)

(setq inhibit-startup-message t
      initial-scratch-message nil
      visible-bell t
      uniquify-buffer-name-style 'forward)

(menu-bar-mode t)
(tool-bar-mode -1)

;; Quieter modeline
(mapc 'diminish '(wrap-region-mode
		  yas-minor-mode
		  projectile-mode
		  auto-complete
		  abbrev-mode
		  auto-revert-mode
		  undo-tree-mode))
(eval-after-load 'elisp-slime-nav '(diminish 'elisp-slime-nav-mode))
(eval-after-load 'auto-complete '(diminish 'auto-complete))
(custom-set-variables '(git-gutter:lighter ""))

;; Let's see column numbers.
(column-number-mode t)

;; and when we've gone too far
(require 'fill-column-indicator)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;; Show more info in taskbar/icon than just "Emacs"
(setq frame-title-format
      '((:eval (if (buffer-file-name)
		   (abbreviate-file-name (buffer-file-name))
		 "%b"))))

;; Fonts are automatically highlighted.  For more information
;; type M-x describe-mode font-lock-mode
(global-font-lock-mode t)
(set-face-bold-p 'font-lock-keyword-face t)
(set-face-italic-p 'font-lock-comment-face t)

;; Line numbers!

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))


;; highlight and colourize balanced parens
;; rainbow-delimiters-mode is turned on on a per-major-mode basis
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; and the symbol at point, elsewhere in the buffer
(idle-highlight-mode t)

;; Let's see when we go out of bounds
(setq-default fill-column 79)

;; Mac Appearance Stuff
(if *on-a-mac*
    (set-face-font 'default "Monaco-19")
  (set-face-attribute 'default nil :height 220))


;; Let me *see* the marks
(visible-mark-mode 1)

;; For ido-vertical-mode
(setq ido-use-faces t)
(set-face-attribute 'ido-vertical-first-match-face nil
		    :background "#e5b7c0")
(set-face-attribute 'ido-vertical-only-match-face nil
		    :background "#e52b50"
		    :foreground "white")
(set-face-attribute 'ido-vertical-match-face nil
		    :foreground "#b00000")

(provide 'custom-appearance)
