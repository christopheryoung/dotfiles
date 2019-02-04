
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

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq *on-a-mac* nil)
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
(require 'ace-jump-mode)
(require 'custom-ido-mode-init)
(require 'custom-init-paredit)
(require 'custom-yasnippet-init)
(require 'custom-projectile)
(require 'diminish)
(require 'discover)
(global-discover-mode 1)
(require 'expand-region)

(require 'flyspell)
(global-git-gutter-mode +1)
(require 'highlight-beyond-fill-column)
(require 'ido-vertical-mode)
(ido-vertical-mode 1)
;; todo: move this stuff and the appearance stuff into custom-ido-vertical
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(setq ido-vertical-define-keys 'C-n-C-p-up-and-down)
(require 'inline-string-rectangle)
(require 'jump-char)

(setq auto-mode-alist (cons '("\\.pro$" . makefile-mode) auto-mode-alist))
(require 'maxframe)
(require 'multiple-cursors)
(require 'rainbow-delimiters)
(require 'smartscan)
(require 'tail)
(turn-on-typing-speed)
(require 'undo-tree)
(require 'wrap-region)

;; major modes, not programming languages
(require 'dired-details)
(require 'custom-dired-init)
(require 'custom-grep-init)
(eval-after-load 'org '(require 'custom-org-mode-init))
(require 'custom-multi-term-init)
(require 'custom-text-mode-init)
(require 'custom-init-erc)
(require 'magit)
(require 'smex)
(require 'uniquify)
(require 'visible-mark)

;; major modes, programming languages, etc.
;; (require 'custom-init-elisp)
;; (require 'custom-init-any-lisp)
(require 'custom-markdown-mode)
(eval-after-load 'clojure-mode '(require 'custom-init-clojure))
(eval-after-load 'haskell-mode '(require 'custom-init-haskell))
;;(eval-after-load 'js2-mode '(require 'custom-init-js2))
(require 'custom-latex)
(eval-after-load 'python-mode '(require 'custom-init-python))
(eval-after-load 'scheme-mode (require 'custom-init-scheme))
(eval-after-load 'web-mode '(require 'custom-init-web-mode))
(eval-after-load 'c-mode '(require 'custom-init-cpp))

;; Customizations
(require 'custom-appearance)
(require 'custom-basic-behaviour)
(require 'custom-global-keybindings)

;; Hook function
(defun clang-format-before-save ()
  "Add this to .emacs to clang-format on save
 (add-hook 'before-save-hook 'clang-format-before-save)."

  (interactive)
  (when (eq major-mode 'c++-mode) (clang-format-buffer)))

;; Install hook to use clang-format on save
(add-hook 'before-save-hook 'clang-format-before-save)

;; At work
(require 'schrodinger nil 'noerror)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:lighter "")
 '(package-selected-packages
   (quote
    (wrap-region wgrep undo-tree smex s repository-root rainbow-delimiters python-pylint python-pep8 pymacs pylint projectile paredit multiple-cursors multi-term midje-mode maxframe markdown-mode mark-multiple magit loop leuven-theme latex-extra jump-char json-mode ipython intero igrep iedit idle-highlight-mode hydra ht helm-gtags grizzl git-timemachine git-messenger git-gutter ggtags find-file-in-repository fill-column-indicator expand-region exec-path-from-shell erlang elpy ebib discover dired-details diminish csv-mode cquery clang-format auto-complete ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
