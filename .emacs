
;; Pretty basic .emacs which I use with emacs starter kit.  Requires
;; Emacs 24 at the moment.

;; DEFAULT COMMANDS THAT I'VE FOUND ESPECIALLY USEFUL
;;
;; . . . General . . .
;;
;; C-a = Move to the beginning of the line
;; C-b = Move back one character
;; C-e = Move to the end of the line
;; C-h c = Command bound to key combination
;; C-h f = Describe function
;; C-h k = Describe key combination
;; C-l = Center buffer around point
;; C-l C-l = put point at top of buffer
;; C-l C-l C-l = put point at buttom of buffer
;; C-p = Move back a line
;; C-s = interactive search
;; C-s C-s = interactive search using the previous search
;; C-s C-w = search the string under the point
;; C-t = Transpose two letters
;; C-u <n> <command> = repeat the command n times
;; C-u C-SPC = Cycle through positions in the mark ring
;; C-u M-! = inserts results of a shell command directly into the buffer
;; C-w = kill region (but in isearch will insert word after point into
;;the search)
;; C-x d = Change directory
;; C-x z = Redo last change
;; C-x C-b = Show buffer list
;; C-x C-t = Transpose two lines
;; C-x ^ = Enlarge the window
;; C-x ( = Start macro definition
;; C-x ) = End macro definition
;; C-x C-x = swap point and mark
;; C-x RET = shell
;; C-x C-SPC = pop-global-mark
;; C-x F1 = Show every command starting with C-x
;; C-<SPC> C-<SPC> - Push the mark onto the mark ring *without*
;; setting it
;; C-/ = Undo
;; C-= = Expand Region
;; C-M-b = backward over balanced expression
;; C-M-f = forward over balanced expression
;; C-M-s = regular expression search forward
;; C-M-v = scroll other window
;; M-^ = Attach this line to previous
;; M-a = Move backwards one sentence
;; M-c = Capitalize word
;; M-e = Move forwards one sentence
;; M-h = Highlight paragraph
;; M-k = Kill sentence
;; M-m = Jump to first non-whitespace character in line
;; M-t = Transpose two words
;; M-u = Uppercase word
;; M-x ispell-buffer = turns on spell checking for whole buffer
;; M-x ispell-region = spell-checks highlighted region
;; M-y = Yank pop (if you don't know how to use this, you must learn
;; immediately)
;; M-z = Zap to char
;; M-. = edit definition (jumps to definition when supported in mode)
;; M-$ = spell-check word
;; M-% = Query/replace (space accepts change; n goes on to next)
;; M-} = Move forward one paragraph.
;; M-{ = Move backward one paragraph.
;; apropos-documentation -- search doc strings of functions and
;;                           variables
;; apropos -- searches all function and variables

;; . . . Dired . . .
;;
;; M-x tumme = Create thumbnails of a directory
;;
;; . . . In the Auctex and RefTeX modes . . .
;;
;; C-c = Run LaTeX
;; C-c = = RefTeX table of contents
;; C-c ( = Insert RefTeX label
;; C-c [ = Insert RefTeX citation
;; C-c C-e = LaTeX-envirnment
;; C-c C-j = LaTeX-insert-item
;; C-c C-s = LaTeX section
;; C-c C-t C-p = Toggle pdf/dvi mode
;; C-c C-t C-s = Turn on source specials mode, so enable jumping straight to point in dvi viewer
;; C-c C-v = TeX-view
;; C-c C-p C-d = Preview
;; C-c C-p C-c C-d = Remove preview
;; C-v = invoke viewer
;; C-[backspace] = backward-kill-word
;; C-[down] = forward-paragraph
;; C-[up] = backward-paragraph
;;
;; . . . In HTML mode . . .
;;
;; C-c C-c h = inserts a link
;; C-c C-c i = html-image

;; . . . In Org mode . . .

;; C-c C-n = Move to next heading.
;; C-c C-p = move to previous heading.
;; C-c C-f = Move to next heading same level.
;; C-c C-b = Move to previous heading same level.
;; C-c C-u = Move backward to higher level heading.

;; . . . When using Slime/Swank/Clojure
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

;; EXTRA LOADPATHS
;; Set by my install script
(if (file-exists-p "~/.emacs.d/extra-loadpaths.el")
    (load "~/.emacs.d/extra-loadpaths.el"))

;; CHECK FOR PACKAGES

(require 'package)
 (add-to-list 'package-archives
              '("marmalade" . "http://marmalade-repo.org/packages/") t)
 (package-initialize)

(defvar my-packages '(starter-kit
                     starter-kit-lisp
                     starter-kit-bindings
                     erlang
                     ispell
                     haskell-mode
                     clojure-mode
                     clojure-test-mode
                     paredit
                     smex
                     find-file-in-project
                     magit
                     rainbow-delimiters
                     maxframe
                     dired-single
                     windmove
                     ace-jump-mode
                     expand-region
                     multi-term
                     undo-tree
                     auto-complete
                     ac-slime
                     midje-mode)
 "A list of packages to ensure are installed at launch.")

(setq my-packages-refreshed nil)

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (when (not my-packages-refreshed)
      (package-refresh-contents)
      (setq my-packages-refreshed t)) ;; expensive, so let's just do
    ;; it once
    (package-install p)))

;; A place to put any packages not on elpa or marmalade
(add-to-list 'load-path "~/.emacs.d/vendor/")

;; APPEARANCE

;; Maxmize emacs

(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; Show more info in taskbar/icon than just "Emacs"

(setq frame-title-format
  '("" invocation-name ": "(:eval (if (buffer-file-name)
                (abbreviate-file-name (buffer-file-name))
                  "%b"))))

;; Get rid of the startup message
(setq inhibit-startup-message t)

;; Show the menu bar
(menu-bar-mode t)

;; Cause the region to be highlighted and prevent region-based
;; commands from running when the mark isn't active.
(pending-delete-mode t)
(setq transient-mark-mode t)

;; Visual bell instead of annoying beep
(setq visible-bell t)

;; the messages buffer is not necessary, until it is.
(setq message-log-max nil)
(kill-buffer "*Messages*")

;; Let's see column numbers.
(column-number-mode t)

;; Show trailing whitespace
(setq show-trailing-whitespace t)

;; Fonts are automatically highlighted.  For more information
;; type M-x describe-mode font-lock-mode
(global-font-lock-mode t)
(set-face-bold-p 'font-lock-keyword-face t)
(set-face-italic-p 'font-lock-comment-face t)

;; font size . . .
(set-face-attribute 'default t :height 160)
;(set-face-attribute 'default nil :height 180)

;; Line numbers! Always!
(require 'linum)
(global-linum-mode 1)
(line-number-mode t)

;; highlight and colourize balanced parens always
(show-paren-mode 1)
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;; Ensures that same-name buffers have longer, sensible names.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Mac Appearance Stuff

(if (string-match "apple-darwin" system-configuration)
    (set-face-font 'default "Monaco-18")
  (set-frame-font "Monospace-10"))

;; BASIC BEHAVIOUR

;; Don't, for the love of Pete, make me type out "Yes" whenever I want
;; to quit emacs.  "y" and "n" will do.
(setq kill-emacs-query-functions
  (list (function (lambda ()
                    (ding)
                    (y-or-n-p "Really quit? ")))))

;; Answer y or n instead of yes or no at minibar prompts.
(defalias 'yes-or-no-p 'y-or-n-p)

;; And let me just hit return for "yes" when I'm feeling really lazy.
(define-key query-replace-map [return] 'act)

;; No need to see byte compile warnings
(setq byte-compile-warnings nil)

;; SavePlace- this puts the cursor in the last place you edited
;; a particular file. This is very useful for large files.
(require 'saveplace)
(setq-default save-place t)

;; When we save a buffer to a file, if the path contains dirs that
;; don't exist yet, just create them for me
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))

;; Changes default mode to Text (instead of Fundamental)
(setq default-major-mode 'text-mode)

;; Don't make backup files.
(setq make-backup-files nil)

;; Save the desktop
(setq desktop-load-locked-desktop t)
(desktop-save-mode 1)

;; . . . or at least, most of the desktop.  We don't need to load
;; everything up.

(setq desktop-buffers-not-to-save
      (concat "\\(" "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
              "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
              "\\)$"))
   (add-to-list 'desktop-modes-not-to-save 'dired-mode)
   (add-to-list 'desktop-modes-not-to-save 'Info-mode)
   (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
   (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)

;; Recent files
;; Commented out for now, but would be great to find a default for this.
;;(global-set-key "\C-r" 'recentf-open-files)

;; Some more useful commands

(global-set-key [f2] 'comment-region)
(global-set-key [(shift f2)] 'universal-argument) ;uncomment is Shift-F2 F2
(global-set-key [f9] 'split-window-horizontally)
(global-set-key [f10] 'split-window-vertically)
(global-set-key [f11] 'other-window)

(require 'key-chord)
(key-chord-mode 1)

;; Now let's make it easy to get to a shell . . .

(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)
(setq multi-term-program "/bin/bash")
(global-set-key [f5] 'multi-term)

;; M-q is very handy for formatting text, but sometimes you want to remove the formatting . . .
(defun remove-line-breaks ()
  "Remove line endings in a paragraph."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;;TODO: Find binding for this.
;;(global-set-key "\M-z" 'remove-line-breaks)

;; This is how emacs tells the file type by the file suffix.
(setq auto-mode-alist (cons '("README" . text-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.txt$" . text-mode) auto-mode-alist))

;; Completions
(add-to-list 'completion-ignored-extensions ".hi")
(add-to-list 'completion-ignored-extensions ".pyc")

;; MOVING AND SEARCHING AND MANIPULATING THE REGION

;; Browse the kill ring easily
(global-set-key "\C-cy" '(lambda ()
    (interactive) (popup-menu 'yank-menu)))

;; Windmove helps you move between open buffers when the screen is
;; split

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Make it easy to switch buffers
(global-set-key [(control tab)] 'next-buffer)
(global-set-key [(control shift tab)] 'previous-buffer)
(global-set-key (kbd "C-.") 'ido-switch-buffer)

;; and kill them, cause I do that all day long
(global-set-key [(control return)] 'ido-kill-buffer)

;; and close other windows . . .
;; willing to part with C-j (new line and indent)
(global-set-key (kbd "C-j") 'delete-other-windows)
;; And make it work in paredit mode
(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "C-j") 'delete-other-windows)))

;; Better scrolling
(setq scroll-step 1)
(setq scroll-conservatively 1)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(key-chord-define-global "jj" 'ace-jump-mode)

;; goto
(global-set-key (kbd "M-g") 'goto-line)

;; Make searches case insensitive
(setq case-fold-search t)

;; easy searching across project
(global-set-key (kbd "C-x f") 'find-file-in-project)

;; occur

(global-set-key (kbd "C-c o") 'occur)

;; Expand Region

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; imenu

(global-set-key (kbd "M-i") 'imenu)

;; undo tree

(require 'undo-tree)
(global-undo-tree-mode)
;; C-x C-u originally: uppercase region
(global-set-key (kbd "C-x C-u") 'undo-tree-visualize)

;; OTHER MODES, ETC.
'
;; Tomatinho, a productivity tool
(require 'tomatinho)
(global-set-key (kbd "<f6>") 'tomatinho)

;; FLYSPELL

;; Checks spelling in comments and doc strings
(flyspell-prog-mode)

;; ASPELL

(setq-default ispell-program-name "/usr/local/bin/aspell")

;; MAGIT

(autoload 'magit-status "magit" nil t)
(global-set-key (kbd "C-x m") 'magit-status)

;; IDO
;; Not necessary if used with emacs starter kit
(require 'ido)
(ido-mode t)

;; TRAMP

(setq tramp-default-method "ssh")

;; MAGIT

(require 'magit)

;; VIPER
;; Don't laugh. Emacs may be a better editor, but modal editing
;; is superior editing.

;;(setq viper-mode t)
;;(require 'viper)

;; SMEX
;; (better m-x)

(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; LANGUAGES

;; generic

(key-chord-define-global "qq" 'slime-eval-defun)

;;auto-complete

(require 'auto-complete-config)
(ac-config-default)

;;; SCHEME

(setq scheme-program-name
      "/Applications/mit-scheme.app/Contents/Resources/mit-scheme")
(require 'xscheme)

;; CLOJURE

(add-hook 'clojure-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-j") 'clojure-jack-in)
            ))

(add-hook 'clojure-mode-hook 'midje-mode)

(add-hook 'slime-repl-mode-hook
          (lambda ()
            (defun clojure-mode-slime-font-lock ()
              (let (font-lock-mode)
                (clojure-mode-font-lock-setup)))
            (local-set-key [(up)] 'slime-repl-backward-input)
            (local-set-key [(down)] 'slime-repl-forward-input)))

;; Mac's are odd; had to do this to get clojure-jack-in working
(if (eq system-type 'darwin)
    (setenv "PATH" (concat "~/bin:" (getenv "PATH"))))

(setenv "PATH" (shell-command-to-string "echo $PATH"))

;; ac-slime (autocomplete)
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)

;; HASKELL

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(require 'auto-complete-haskell)
