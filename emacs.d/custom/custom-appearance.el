
;; Thanks: http://emacsredux.com/blog/2013/07/24/highlight-comment-annotations/
(defun font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.
This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'font-lock-comment-annotations)

(setq inhibit-startup-message t
      initial-scratch-message nil
      visible-bell t
      line-number-mode t
      uniquify-buffer-name-style 'forward)

(menu-bar-mode t)

;; Quieter modeline
(mapc 'diminish '(wrap-region-mode
                  yas-minor-mode
                  undo-tree-mode))
(eval-after-load 'elisp-slime-nav '(diminish 'elisp-slime-nav-mode))

;; Let's see column numbers.
(column-number-mode t)

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

;; font size . . .
(set-face-attribute 'default t :family "Inconsolata" :height 160 :weight 'normal)

;; Line numbers! Always!
(global-linum-mode 1)

;; highlight and colourize balanced parens always
(show-paren-mode 1)
(global-rainbow-delimiters-mode)
(setq show-paren-style 'expression)

;; and the symbol at point, elsewhere in the buffer
(idle-highlight-mode t)

;; Let's see when we go out of bounds
(setq-default fill-column 79)

;; Mac Appearance Stuff

(if *on-a-mac*
    (set-face-font 'default "Monaco-18")
  (set-frame-font "Monospace-10"))

;; Let me *see* the marks
(visible-mark-mode 1)

;; Themes

;; (load-theme 'solarized-dark nil)

(provide 'custom-appearance)

