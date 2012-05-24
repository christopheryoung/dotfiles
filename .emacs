
;; My .emacs. Lots of goodies, mostly scavaged from elsewhere. Requires Emacs
;; 24 at the moment.

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

;; PRELIMINARIES

(if (string-match "apple-darwin" system-configuration)
    (setq *on-a-mac* t))

;; cl, to make life a little easier

(require 'cl)

;; PACKAGE, for managing packages in elpa and marmalade, etc.

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

 (package-initialize)

(defvar my-package-packages '(
                              ac-slime
                              ace-jump-mode
                              auto-complete
                              clojure-mode
                              command-frequency
                              csv-mode
                              dired-single
                              expand-region
                              find-file-in-project
                              go-mode
                              javadoc-help
                              haskell-mode
                              ispell
                              magit
                              markdown-mode
                              maxframe
                              midje-mode
                              multi-term
                              paredit
                              protobuf-mode
                              python-mode
                              pyregexp
                              quack
                              rainbow-delimiters
                              smex
                              starter-kit
                              starter-kit-bindings
                              starter-kit-js
                              starter-kit-lisp
                              undo-tree
                              windmove
                              )
  "A list of packages to ensure are installed at launch.")

(setq my-packages-refreshed nil)

(dolist (p my-package-packages)
  (when (not (package-installed-p p))
    (when (not my-packages-refreshed)
      (package-refresh-contents)
      (setq my-packages-refreshed t)) ;; expensive, so let's just do
    ;; it once
    (package-install p)))

;; A place to put any packages not on elpa or marmalade
(add-to-list 'load-path "~/.emacs.d/vendor/")

;; EXTRA LOADPATHS
;; Set by my install script
(if (file-exists-p "~/.emacs.d/extra-loadpaths.el")
    (load "~/.emacs.d/extra-loadpaths.el"))

;; APPEARANCE

;; Maxmize emacs

(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; Show more info in taskbar/icon than just "Emacs"
(setq frame-title-format '(buffer-file-name "%f" ("%b")))

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

;; No need to see instructions in the scratch buffer
(setq initial-scratch-message nil)

;; Let's see column numbers.
(column-number-mode t)

;; Show trailing whitespace
(setq-default show-trailing-whitespace t)

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

;; Don't make backup files or auto-save.
(setq make-backup-files nil)
(setq auto-save-default nil)

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
(recentf-mode 1)
(setq recentf-max-menu-items 100)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

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

;; Safe deletes
(setq delete-by-moving-to-trash t)


;; MOVING AND SEARCHING AND MANIPULATING THE REGION

;; The following section is a good idea until I've broken some bad habits.
;; The following courtesy of: http://danamlund.dk/emacs/no-easy-keys.html
(defvar no-easy-keys-minor-mode-map (make-keymap)
  "no-easy-keys-minor-mode keymap.")
(let ((f (lambda (m)
           `(lambda () (interactive)
              (message (concat "No! use " ,m " instead."))))))
  (dolist (l '(("<left>" . "C-b") ("<right>" . "C-f") ("<up>" . "C-p")
               ("<down>" . "C-n")
               ("<C-left>" . "M-b") ("<C-right>" . "M-f") ("<C-up>" . "M-{")
               ("<C-down>" . "M-}")
               ("<M-left>" . "M-b") ("<M-right>" . "M-f") ("<M-up>" . "M-{")
               ("<M-down>" . "M-}")
               ("<delete>" . "C-d") ("<C-delete>" . "M-d")
               ("<M-delete>" . "M-d") ("<next>" . "C-v") ("<C-next>" . "M-x <")
               ("<prior>" . "M-v") ("<C-prior>" . "M-x >")
               ("<home>" . "C-a") ("<C-home>" . "M->")
               ("<C-home>" . "M-<") ("<end>" . "C-e") ("<C-end>" . "M->")))
    (define-key no-easy-keys-minor-mode-map
      (read-kbd-macro (car l)) (funcall f (cdr l)))))

(define-minor-mode no-easy-keys-minor-mode
  "A minor mode that disables the arrow-keys, pg-up/down, delete
  and backspace."  t " no-easy-keys"
  'no-easy-keys-minor-mode-map)

(no-easy-keys-minor-mode t)

(add-hook 'minibuffer-setup-hook
          (lambda ()
            (no-easy-keys-minor-mode 0)))

;; jump to matching paren
;; Thanks to https://github.com/avar/dotemacs/blob/master/.emacs
(defun match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t (self-insert-command (or arg 1)))))

(global-set-key (kbd "C-]") 'match-paren)

;; Browse the kill ring easily
(global-set-key "\C-cy" '(lambda ()
    (interactive) (popup-menu 'yank-menu)))

;; And the mark ring

;; Let me *see* the marks
(require 'visible-mark)
(visible-mark-mode 1)

;; Allow for mark ring traversal without popping them off the stack.
(setq set-mark-command-repeat-pop t)

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
(setq scroll-margin 2)

(require 'ace-jump-mode)
(setq ace-jump-mode-case-sensitive-search nil)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(key-chord-define-global "jj" 'ace-jump-mode)
(define-key global-map (kbd "C-o") 'ace-jump-mode) ;; was bound to <insertline>

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

;; ONLINE SEARCH AND HELP

(setq cheatsheets '(("Clojure" "http://jafingerhut.github.com/cheatsheet-clj-1.3/cheatsheet-tiptip-cdocs-summary.html")
                    ("ClojureDocs" "http://clojuredocs.org/")
                    ("Elisp Cookbook" "http://www.emacswiki.org/emacs/ElispCookbook")
                    ("HTML5" "http://www.nihilogic.dk/labs/canvas_sheet/HTML5_Canvas_Cheat_Sheet.pdf")
                    ("Magit" "http://cheat.errtheblog.com/s/magit/")
                    ("Paredit" "http://www.emacswiki.org/emacs/PareditCheatsheet")
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

;; Browse in new tabs instead of the current one
;; Does not seem to work with chrome
(setq browse-url-new-window-flag t)


;; OTHER MODES AND TOOLS

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
;; Not necessary if used with emacs starter kit
(require 'ido)
(ido-mode t)

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

;; LANGUAGES

;; GENERALLY LISPY STUFF

;; Make sure I have paredit everywhere, including the repl
;; Merci: http://lispservice.posterous.com/paredit-in-the-slime-repl
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)
;(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(mapc (lambda (mode)
        (let ((hook (intern (concat (symbol-name mode)
                                    "-mode-hook"))))
          (add-hook hook (lambda () (paredit-mode +1)))))
      '(emacs-lisp lisp inferior-lisp slime slime-repl))

;; And now slime stuff

(key-chord-define-global "qq" 'slime-eval-defun)

(add-hook 'slime-repl-mode-hook
          (lambda ()
            (defun clojure-mode-slime-font-lock ()
              (let (font-lock-mode)
                (clojure-mode-font-lock-setup)))
            (local-set-key [(up)] 'slime-repl-backward-input)
            (local-set-key [(down)] 'slime-repl-forward-input)))

;; ac-slime (autocomplete)
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)

;; eldoc, how did I ever live without you?
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

;;auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; ELISP
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode t)

;;; SCHEME

(setq scheme-program-name
      "/Applications/mit-scheme.app/Contents/Resources/mit-scheme")
(require 'xscheme)

;; JAVA

(global-set-key (kbd "C-h C-j") 'javadoc-lookup)

;; CLOJURE

(add-hook 'clojure-mode-hook
          (lambda ()
            (require 'midje-mode)
            (require 'clojure-jump-to-file)
            (local-set-key (kbd "C-c C-j") 'clojure-jack-in)
            (local-set-key (kbd "C-c C-,") 'midje-check-fact)
            ))

;; Macs are odd; had to do this to get clojure-jack-in working
(if *on-a-mac*
    (setenv "PATH" (concat "~/bin:" (getenv "PATH"))))

(setenv "PATH" (shell-command-to-string "echo $PATH"))

;; HASKELL

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(require 'auto-complete-haskell)

;; PROTOBUF

(require 'protobuf-mode)

;; PYTHON

(require 'python-mode)
(setq py-shell-name "ipython")

;; GO

(require 'go-mode-load)
