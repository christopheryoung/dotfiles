
(setq inhibit-startup-message t
      initial-scratch-message nil
      visible-bell t)

(menu-bar-mode t)

;; Quieter modeline
(mapc 'diminish '(wrap-region-mode
                  yas-minor-mode
                  undo-tree-mode))

;; Let's see column numbers.
(column-number-mode t)

;; Show more info in taskbar/icon than just "Emacs"
(setq frame-title-format '(buffer-file-name "%f" ("%b")))

;; Fonts are automatically highlighted.  For more information
;; type M-x describe-mode font-lock-mode
(global-font-lock-mode t)
(set-face-bold-p 'font-lock-keyword-face t)
(set-face-italic-p 'font-lock-comment-face t)

;; font size . . .
(set-face-attribute 'default t :family "Inconsolata" :height 160 :weight 'normal)

;; Line numbers! Always!
(global-linum-mode 1)
(line-number-mode t)

;; highlight and colourize balanced parens always
(show-paren-mode 1)
(global-rainbow-delimiters-mode)
(setq show-paren-style 'expression)

;; and the symbol at point, elsewhere in the buffer
(idle-highlight-mode t)

;; Let's see when we go out of bounds
(setq-default fill-column 79)
(require 'highlight-beyond-fill-column)

;; Ensures that same-name buffers have longer, sensible names.
(setq uniquify-buffer-name-style 'forward)

;; Mac Appearance Stuff

(if *on-a-mac*
    (set-face-font 'default "Monaco-18")
  (set-frame-font "Monospace-10"))

;; Let me *see* the marks
(require 'visible-mark)
(visible-mark-mode 1)


(provide 'custom-appearance)

