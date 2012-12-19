
(global-set-key [f2] 'comment-region)
(global-set-key [(shift f2)] 'universal-argument) ;uncomment is Shift-F2 F2
(global-set-key [f9] 'split-window-horizontally)
(global-set-key [f10] 'split-window-vertically)
(global-set-key [f11] 'other-window)

;; breadcrumbs
(global-set-key (kbd "M-`") 'bc-set) ;;
(global-set-key (kbd "C-M-<up>") 'bc-previous) ;; jump to previous
(global-set-key (kbd "C-M-<down>") 'bc-next) ;;jump to next
;; bc-list to see menu list
;; bc-clear to clear breadcrumbs

;; custom defuns
(global-set-key (kbd "C-h C-b") 'browse-url)
(global-set-key (kbd "C-h C-s") 'search-interwebs)
(global-set-key (kbd "C-h C-c") 'get-cheatsheet)

(global-set-key (kbd "C-]") 'match-paren)

(global-set-key (kbd "C-.") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "C-,")   (lambda () (interactive) (scroll-down 1)))

;; browse the kill ring easily
(global-set-key "\C-cy" '(lambda () (interactive) (popup-menu 'yank-menu)))

;; Make it easy to switch buffers
(global-set-key (kbd "<right>") 'next-buffer)
(global-set-key (kbd "<left>") 'previous-buffer)

;; and kill them, cause I do that all day long
(global-set-key [(control return)] 'ido-kill-buffer)
;; and close other windows . . .
;; willing to part with C-j (new line and indent)

(global-set-key (kbd "C-j") 'delete-other-windows)

(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-x f") 'find-file-in-project)

;; ace-jump-mode
(define-key global-map (kbd "C-o") 'ace-jump-mode) ;; was bound to <insertline>
;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)
;; grep
(global-set-key (kbd "C-c C-g") 'rgrep)
;; iedit
(global-set-key (kbd "C-c i") 'iedit-mode)
;; imenu
(global-set-key (kbd "M-i") 'imenu)
;; isearch
;; Use regex searches by default. (Borrowed from emacs starter kit)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-M-%") 'query-replace)
;; inline-string-rectangle
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)
;; jump char
;; note: ";": jump-forward ",":" jump-backward
(global-set-key [(meta m)] 'jump-char-forward)
(global-set-key [(shift meta m)] 'jump-char-backward)
;; occur
(global-set-key (kbd "C-c o") 'occur)
;; magit
(global-set-key (kbd "C-x m") 'magit-status)
;; multi-term
(global-set-key [f5] 'multi-term)
;; multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; smartscan
(global-set-key (kbd "<up>") 'smart-symbol-go-backward)
(global-set-key (kbd "<down>") 'smart-symbol-go-forward)
;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; old m-x
;; undo-tree
;; C-x C-u originally: uppercase region
(global-set-key (kbd "C-x C-u") 'undo-tree-visualize)
;; yasnippet
(global-set-key (kbd "C-<tab>") 'yas-expand)

(provide 'custom-global-keybindings)
