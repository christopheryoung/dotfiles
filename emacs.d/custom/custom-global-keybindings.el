;;; custom-global-keybindings.el --- Global key bindings  -*- lexical-binding: t -*-

(global-set-key [f2] 'comment-dwim)
(global-set-key [f4] 'worklog-date-stamp)
(global-set-key [f5] 'multi-term)
(global-set-key [f6] 'outline-hide-body)
(global-set-key [f7] 'outline-show-all)
(global-set-key [f9] 'split-window-horizontally)
(global-set-key [f10] 'split-window-vertically)
(global-set-key [f11] 'other-window)

;; custom defuns
(global-set-key (kbd "C-h C-b") 'browse-url)
(global-set-key (kbd "C-h C-s") 'search-interwebs)
(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)
(global-set-key (kbd "C-]") 'match-paren)

;; These are very nice bindings, though they don't work in a terminal
(global-set-key (kbd "C-.") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "C-,") (lambda () (interactive) (scroll-down 1)))
;; they need to be reset by some especially pushy modes
(with-eval-after-load 'flyspell
  (define-key flyspell-mode-map (kbd "C-.") nil)
  (define-key flyspell-mode-map (kbd "C-,") nil))

;; Make it easy to switch buffers
(global-set-key (kbd "<right>") 'next-buffer)
(global-set-key (kbd "<left>") 'previous-buffer)

;; and kill them, cause I do that all day long
(global-set-key [(control return)] 'kill-buffer)
;; and close other windows . . .
;; willing to part with C-j (new line and indent)
(global-set-key (kbd "C-j") 'delete-other-windows)

(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-x f") 'find-file-in-repository)

;; ace-jump-mode
(global-set-key (kbd "C-o") 'ace-jump-mode) ;; was bound to <insertline>
;; dired-jump
(global-set-key (kbd "C-x C-j") 'dired-jump)
;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)
;; grep
(global-set-key (kbd "C-c C-g") 'rgrep)
;; iedit
(global-set-key (kbd "C-c i") 'iedit-mode)
;; isearch
;; Use regex searches by default. (Borrowed from emacs starter kit)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-M-%") 'query-replace)
;; jump char
;; note: ";": jump-forward ",":" jump-backward
(global-set-key [(meta m)] 'jump-char-forward)
(global-set-key [(shift meta m)] 'jump-char-backward)
;; occur
(global-set-key (kbd "C-c o") 'occur)
;; magit
(global-set-key (kbd "C-x m") 'magit-status)
;; multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; smartscan
(global-set-key (kbd "<up>") 'smartscan-symbol-go-backward)
(global-set-key (kbd "<down>") 'smartscan-symbol-go-forward)
;; these bindings are fine for smartscan until you're at a repl
(add-hook 'comint-mode-hook
	  (lambda ()
	    (local-set-key (kbd "<up>") 'comint-previous-input)
	    (local-set-key (kbd "<down>") 'comint-next-input)))
;; undo-tree
;; C-x C-u originally: uppercase region
(global-set-key (kbd "C-x C-u") 'undo-tree-visualize)
;; webjump
(global-set-key (kbd "C-x g") 'webjump)
;; yasnippet
(global-set-key (kbd "C-<tab>") 'yas-expand)

(provide 'custom-global-keybindings)
;;; custom-global-keybindings.el ends here
