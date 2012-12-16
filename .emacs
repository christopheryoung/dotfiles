
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


;; setup info
(if (string-match "apple-darwin" system-configuration)
    (setq *on-a-mac* t))

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Thanks to Justine: https://github.com/jart/justinemacs/blob/master/lob-defuns.el
(defun reload-dotemacs ()
  "Save the .emacs buffer if needed, then reload .emacs."
  (interactive)
  (let ((dot-emacs (concat dotfiles-dir "/.emacs")))
    (and (get-file-buffer dot-emacs)
         (save-buffer (get-file-buffer dot-emacs)))
    (load-file dot-emacs))
  (message "Re-initialized!"))

;; directory for most customizations
(add-to-list 'load-path "~/.emacs.d/custom/")

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
(require 'expand-region)
(require 'flyspell)
(flyspell-prog-mode) ;; Checks spelling in comments and doc strings
(setq-default ispell-program-name "/usr/local/bin/aspell")
(require 'perspective)
(persp-mode t)
(require 'smartscan)
(require 'tail)
(require 'undo-tree)
(global-undo-tree-mode)
(require 'wrap-region)
(wrap-region-mode t)

;; major modes, not programming languages
(require 'custom-dired-init)
(require 'custom-grep-init)
(require 'custom-multi-term-init)
(require 'custom-text-mode-init)
(require 'magit)
(setq magit-status-buffer-switch-function 'switch-to-buffer)
(require 'smex)
(smex-initialize)
(setq tramp-default-method "ssh")

;; major modes, programming languages
(require 'custom-init-elisp)
(require 'custom-init-any-lisp)
(require 'custom-init-clojure)
(require 'custom-init-haskell)
(require 'custom-init-js2)
(require 'custom-init-python)
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
