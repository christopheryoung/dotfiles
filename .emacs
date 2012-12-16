
;; My .emacs. Lots of goodies, mostly scavaged from elsewhere. Requires Emacs
;; 24 at the moment.

;; Commands I still haven't committed to muscle memory
;; C-u <n> <command> = repeat the command n times
;; C-u M-! = inserts results of a shell command directly into the buffer
;; C-w = kill region (but in isearch will insert word after point into
;;the search)
;; C-x F1 = Show every command starting with C-x
;; C-<SPC> C-<SPC> - Push the mark onto the mark ring *without*
;; setting it
;; C-M-b = backward over balanced expression
;; C-M-f = forward over balanced expression
;; C-M-s = regular expression search forward
;; C-M-v = scroll other window
;; M-c = Capitalize word
;; M-m = Jump to first non-whitespace character in line
;; M-z = Zap to char
;; M-$ = spell-check word
;; apropos-documentation -- search doc strings of functions and
;;                           variables
;; apropos -- searches all function and variables
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

;; setup info
(if (string-match "apple-darwin" system-configuration)
    (setq *on-a-mac* t))

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; directory for most customizations
(add-to-list 'load-path "~/.emacs.d/custom/")

;; custom loads
(load "~/.emacs.d/vendor/typing-speed.el")

;; install required packages
(require 'custom-packages)

;; useful elisp
(require 'custom-defuns)

;; minor modes
(require 'auto-complete-config)
(ac-config-default)
(require 'ace-jump-mode)
(setq ace-jump-mode-case-sensitive-search nil)
(require 'breadcrumb)
(require 'custom-command-frequency-init) ;; Statistical omphaloskepsis
(require 'custom-ido-mode-init)
(require 'custom-init-paredit)
(require 'custom-yasnippet-init)
(require 'custom-zencoding-mode-init)
(require 'diminish)
(require 'expand-region)
(require 'flyspell)
(flyspell-prog-mode) ;; Checks spelling in comments and doc strings
(setq-default ispell-program-name "/usr/local/bin/aspell")
(require 'highlight-beyond-fill-column)
(require 'inline-string-rectangle) ;; requires mark-multiple
(require 'jump-char)
(require 'linum)
(require 'multiple-cursors)
(require 'rainbow-delimiters)
(require 'perspective)
(persp-mode t)
(require 'smart-forward)
(require 'smartscan)
(require 'tail)
(turn-on-typing-speed)
(require 'undo-tree)
(global-undo-tree-mode)
(require 'wrap-region)
(wrap-region-global-mode t)
(add-to-list 'wrap-region-except-modes 'magit-status-mode)

;; major modes, not programming languages
(require 'custom-dired-init)
(require 'custom-grep-init)
(eval-after-load 'org '(require 'custom-org-mode-init))
(require 'custom-multi-term-init)
(require 'custom-text-mode-init)
(require 'magit)
(setq magit-status-buffer-switch-function 'switch-to-buffer)
(require 'smex)
(smex-initialize)
(setq tramp-default-method "ssh")
(require 'uniquify)
(require 'visible-mark)

;; major modes, programming languages
(require 'custom-init-elisp)
(require 'custom-init-any-lisp)
(eval-after-load 'clojure-mode '(require 'custom-init-clojure))
(eval-after-load 'haskell-mode '(require 'custom-init-haskell))
(eval-after-load 'js2-mode '(require 'custom-init-js2))
(eval-after-load 'python-mode '(require 'custom-init-python))
(require 'custom-init-scheme)
(eval-after-load 'web-mode '(require 'custom-init-web-mode))

;; customize appearance
(require 'custom-appearance)
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; customize basic behaviour
(require 'custom-basic-behaviour)

;; Keybindings
(require 'custom-global-keybindings)


