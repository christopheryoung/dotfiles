
(setq inhibit-startup-message t)
(menu-bar-mode t)

;; No need to see instructions in the scratch buffer
(setq initial-scratch-message nil)

;; Let's see column numbers.
(column-number-mode t)

;; Visual bell instead of annoying beep
(setq visible-bell t)

;; Show more info in taskbar/icon than just "Emacs"
(setq frame-title-format '(buffer-file-name "%f" ("%b")))

(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; Fonts are automatically highlighted.  For more information
;; type M-x describe-mode font-lock-mode
(global-font-lock-mode t)
(set-face-bold-p 'font-lock-keyword-face t)
(set-face-italic-p 'font-lock-comment-face t)

;; font size . . .
(set-face-attribute 'default t :family "Inconsolata" :height 160 :weight 'normal)

;; Line numbers! Always!
(require 'linum)
(global-linum-mode 1)
(line-number-mode t)

;; highlight and colourize balanced parens always
(show-paren-mode 1)
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)
(setq show-paren-style 'expression)

;; Let's see when we go out of bounds
(setq-default fill-column 79)
(require 'highlight-beyond-fill-column)

;; Ensures that same-name buffers have longer, sensible names.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Mac Appearance Stuff

(if *on-a-mac*
    (set-face-font 'default "Monaco-18")
  (set-frame-font "Monospace-10"))


(provide 'custom-appearance)

