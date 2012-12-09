
;; My .emacs. Lots of goodies, mostly scavaged from elsewhere. Requires Emacs
;; 24 at the moment.

;; Commands I still haven't committed to muscle memory
;; C-t = Transpose two letters
;; C-u <n> <command> = repeat the command n times
;; C-u M-! = inserts results of a shell command directly into the buffer
;; C-w = kill region (but in isearch will insert word after point into
;;the search)
;; C-x d = Change directory
;; C-x z = Redo last change
;; C-x C-t = Transpose two lines
;; C-x ( = Start macro definition
;; C-x ) = End macro definition
;; C-x RET = shell
;; C-x C-SPC = pop-global-mark
;; C-x F1 = Show every command starting with C-x
;; C-<SPC> C-<SPC> - Push the mark onto the mark ring *without*
;; setting it
;; C-M-b = backward over balanced expression
;; C-M-f = forward over balanced expression
;; C-M-s = regular expression search forward
;; C-M-v = scroll other window
;; M-c = Capitalize word
;; M-h = Highlight paragraph
;; M-k = Kill sentence
;; M-m = Jump to first non-whitespace character in line
;; M-t = Transpose two words
;; M-u = Uppercase word
;; M-x ispell-buffer = turns on spell checking for whole buffer
;; M-x ispell-region = spell-checks highlighted region
;; M-z = Zap to char
;; M-. = edit definition (jumps to definition when supported in mode)
;; M-$ = spell-check word
;; apropos-documentation -- search doc strings of functions and
;;                           variables
;; apropos -- searches all function and variables
;;
;; . . . Dired . . .
;;
;; M-x tumme = Create thumbnails of a directory
;;
;; . . . In Org mode . . .
;;
;; C-c C-n = Move to next heading.
;; C-c C-p = move to previous heading.
;; C-c C-f = Move to next heading same level.
;; C-c C-b = Move to previous heading same level.
;; C-c C-u = Move backward to higher level heading.

;; . . . When using nRepl/Clojure
;; C-c C-l = load current buffer and force required namespaces to
;; reload
;; C-c I = Inspect a value
;; C-c M-p = Switch repl namespace to match current buffer (make sure
;; to C-c C-l the buffer first)
;; C-c C-w c = List all callers of a function
;; C-c C-d C-d = show documentation in other buffer
;; C-M-x = compile whole top level form under point
;; C-c C-, = run all tests in buffer (clojure-test-mode)
;; C-c k = clear failing test overlays (clojure-test-mode)
;; C-c s = show reason for test failure (clojure-test-mode, my binding)
;; M-. = jump to definition
;;
;; . . . In Magit
;; In magit-status:
;;   b - branch menu
;;   f f - fetch
;;   P - push
;; When operating on hunks:
;;   k - revert this hunk
;;   n - next hunk
;;   p - previous hunk
;;   s - stage the hunk
;;   u - unstage the hunk
;;
;; Other very helpful commands, not yet bound
;; highlight-changes-mode
;; indent-buffer
;; sort-lines
;; re-builder (for building regular expressions)

;; PRELIMINARIES

(require 'cl)

(if (string-match "apple-darwin" system-configuration)
    (setq *on-a-mac* t))

;; directory for most customizations
(add-to-list 'load-path "~/.emacs.d/custom/")

(require 'custom-packages)
(require 'custom-appearance)
(require 'custom-basic-behaviour)
(require 'custom-defuns)

(require 'custom-dired-init)


(global-set-key [f2] 'comment-region)
(global-set-key [(shift f2)] 'universal-argument) ;uncomment is Shift-F2 F2
(global-set-key [f9] 'split-window-horizontally)
(global-set-key [f10] 'split-window-vertically)
(global-set-key [f11] 'other-window)

(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)
(setq multi-term-program "/bin/bash")
(global-set-key [f5] 'multi-term)

;;TODO: Find binding for this.
;;(global-set-key "\M-z" 'remove-line-breaks)

(setq auto-mode-alist (cons '("README" . text-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.txt$" . text-mode) auto-mode-alist))

;; MOVING AND SEARCHING AND MANIPULATING THE REGION

;; Sane scrolling
(global-set-key (kbd "C-.") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "C-,")   (lambda () (interactive) (scroll-down 1)))

;; And make it easy to wrap a region with parens, etc.
(require 'wrap-region)
(wrap-region-mode t)

(global-set-key (kbd "C-]") 'match-paren)

;; Browse the kill ring easily
(global-set-key "\C-cy" '(lambda ()
                           (interactive) (popup-menu 'yank-menu)))

;; breadcrumbs for nameless bookmarks
(require 'breadcrumb)
(global-set-key (kbd "M-`") 'bc-set) ;;
(global-set-key (kbd "C-M-<up>") 'bc-previous) ;; jump to previous
(global-set-key (kbd "C-M-<down>") 'bc-next) ;;jump to next
;; bc-list to see menu list
;; bc-clear to clear breadcrumbs

;; smartscan
(require 'smartscan)
(global-set-key (kbd "<up>") 'smart-symbol-go-backward)
(global-set-key (kbd "<down>") 'smart-symbol-go-forward)

;; Make it easy to switch buffers
(global-set-key (kbd "<right>") 'next-buffer)
(global-set-key (kbd "<left>") 'previous-buffer)

;; and kill them, cause I do that all day long
(global-set-key [(control return)] 'ido-kill-buffer)

;; and close other windows . . .
;; willing to part with C-j (new line and indent)
(global-set-key (kbd "C-j") 'delete-other-windows)

(require 'ace-jump-mode)
(setq ace-jump-mode-case-sensitive-search nil)
(define-key global-map (kbd "C-o") 'ace-jump-mode) ;; was bound to <insertline>

;; goto
(global-set-key (kbd "M-g") 'goto-line)

;; grep
(require 'custom-grep-init)
(global-set-key (kbd "C-c C-g") 'rgrep)

;; easy searching across project
(global-set-key (kbd "C-x f") 'find-file-in-project)

;; occur

(global-set-key (kbd "C-c o") 'occur)

;; Expand Region

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; imenu

(global-set-key (kbd "M-i") 'imenu)

;; iedit
(global-set-key (kbd "C-c i") 'iedit-mode)

;; undo tree

(require 'undo-tree)
(global-undo-tree-mode)
;; C-x C-u originally: uppercase region
(global-set-key (kbd "C-x C-u") 'undo-tree-visualize)

;; ONLINE SEARCH AND HELP

(setq cheatsheets '(("Clojure" "http://jafingerhut.github.com/cheatsheet-clj-1.3/cheatsheet-tiptip-cdocs-summary.html")
                    ("ClojureDocs" "http://clojuredocs.org/")
                    ("Elisp Cookbook" "http://www.emacswiki.org/emacs/ElispCookbook")
                    ("HTML5" "http://www.nihilogic.dk/labs/canvas_sheet/HTML5_Canvas_Cheat_Sheet.pdf")
                    ("Magit" "http://cheat.errtheblog.com/s/magit/")
                    ("Paredit" "http://www.emacswiki.org/emacs/PareditCheatsheet")
                    ("ZenCoding" "https://github.com/rooney/zencoding")
                    ))

(defun search-interwebs(query)
  (interactive "sSearch for: ")
  (browse-url (concat "https://duckduckgo.com/?q=" query)))

(defun get-cheatsheet ()
  (interactive)
  (setq choice (ido-completing-read "Cheatsheet: " (maplist 'caar cheatsheets)))
  (when choice
    (let ((cheatsheet-url (car (cdr (assoc choice cheatsheets))))) ;; Seriously? Gotta learn elisp!
      (browse-url cheatsheet-url))))

(global-set-key (kbd "C-h C-b") 'browse-url)
(global-set-key (kbd "C-h C-s") 'search-interwebs)
(global-set-key (kbd "C-h C-c") 'get-cheatsheet)


;; yasnippet
(require 'yasnippet)
(setq yas/trigger-key "<C-tab>")
(global-set-key (kbd "C-<tab>") 'yas-expand)
(setq yas/prompt-functions '(yas/ido-prompt
                             yas/completing-prompt))
(yas-load-directory "~/.emacs.d/snippets")
(yas-global-mode 1)

;; zencoding-mode
(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-hook 'sgml-mode-hook ( lambda ()
                            (local-set-key (kbd "C-c C-j") 'zencoding-expand-line)))

;; Statistical omphaloskepsis
(require 'command-frequency)
(command-frequency-table-load)
(command-frequency-mode 1)
(command-frequency-autosave-mode 1)

;; Tail
(require 'tail)

;; FLYSPELL

;; Checks spelling in comments and doc strings
(flyspell-prog-mode)

;; ASPELL

(setq-default ispell-program-name "/usr/local/bin/aspell")

;; IDO
;; Override a few settings in emacs starter kit
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-use-virtual-buffers t)

;; TRAMP

(setq tramp-default-method "ssh")

;; MAGIT

(require 'magit)
(global-set-key (kbd "C-x m") 'magit-status)

;; SMEX (better M-x)
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; PROGRAMMING LANGUAGES, ETC.

(require 'auto-complete-config)
(ac-config-default)
(require 'custom-init-paredit)

(require 'custom-init-elisp)
(require 'custom-init-any-lisp)
(require 'custom-init-clojure)
(require 'custom-init-haskell)
(require 'custom-init-js2)
(require 'custom-init-python)
(require 'custom-init-scheme)
(require 'custom-init-web-mode)

;; Keybindings
(require 'custom-global-keybindings)
