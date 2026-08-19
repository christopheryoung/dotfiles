;;; custom-appearance.el --- Look and feel  -*- lexical-binding: t -*-

;; Thanks: http://emacsredux.com/blog/2013/07/24/highlight-comment-annotations/
(defun font-lock-comment-annotations ()
  "Highlight well known comment annotations in the current buffer."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\|NOTE\\):"
	  1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'font-lock-comment-annotations)

(setq inhibit-startup-message t
      initial-scratch-message nil
      uniquify-buffer-name-style 'forward)

(menu-bar-mode 1)
(tool-bar-mode -1)

;; Quieter modeline
(mapc 'diminish '(yas-minor-mode
		  projectile-mode
		  abbrev-mode
		  auto-revert-mode
		  undo-tree-mode))

;; Let's see column numbers.
(column-number-mode t)

;; and when we've gone too far
(setq-default fill-column 79)
(global-display-fill-column-indicator-mode 1)

;; Show more info in taskbar/icon than just "Emacs"
(setq frame-title-format
      '((:eval (if (buffer-file-name)
		   (abbreviate-file-name (buffer-file-name))
		 "%b"))))

;; Fonts are automatically highlighted.  For more information
;; type M-x describe-mode font-lock-mode
(global-font-lock-mode t)
(set-face-bold 'font-lock-keyword-face t)
(set-face-italic 'font-lock-comment-face t)

;; Line numbers!
(global-display-line-numbers-mode)

;; highlight and colourize balanced parens
(show-paren-mode 1)
(setq show-paren-style 'expression)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; and the symbol at point, elsewhere in the buffer
(add-hook 'prog-mode-hook 'idle-highlight-mode)

;; Mac Appearance Stuff
(if *on-a-mac*
    (set-face-font 'default "Monaco-19")
  (set-face-attribute 'default nil :height 220))

;; Let me *see* the marks
(visible-mark-mode 1)

(provide 'custom-appearance)
;;; custom-appearance.el ends here
