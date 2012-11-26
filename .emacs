
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
                              ac-nrepl
                              ace-jump-mode
                              auto-complete
                              clojure-mode
                              command-frequency
                              csv-mode
                              dired-single
                              expand-region
                              find-file-in-project
                              go-mode
                              iedit
                              igrep
                              javadoc-help
                              js2-mode
                              haskell-mode
                              ispell
                              magit
                              markdown-mode
                              maxframe
                              midje-mode
                              multi-term
                              nrepl
                              paredit
                              protobuf-mode
                              python-mode
                              pyregexp
                              quack
                              rainbow-delimiters
                              smex
                              slime-js
                              starter-kit
                              starter-kit-bindings
                              starter-kit-js
                              starter-kit-lisp
                              undo-tree
                              windmove
                              wrap-region
                              yasnippet
                              zencoding-mode
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

;; Just pretend I hit key command for save-some-buffers everytime I
;; accidentially hit key command for save-buffer
(global-set-key (kbd "C-x C-s") 'save-some-buffers)

;; Reload buffers when they have changed on disk, unless they have their own
;; local modifications
(global-auto-revert-mode t)

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

;; clean up whitespace on save

(add-hook 'before-save-hook
          (lambda () (whitespace-cleanup)))


;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 100)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; Make it easy to get to my worklog
(defun open-worklog ()
  (interactive)
  (find-file "~/Dropbox/cy/notes/worklog.txt"))

;; Some more useful commands

(defun worklog-date-stamp ()
  (interactive)
  (insert (format-time-string "%m/%d/%Y ")))

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

;; Sane scrolling
(global-set-key (kbd "C-.") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "C-,")   (lambda () (interactive) (scroll-down 1)))

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

;; And make it easy to wrap a region with parens, etc.
(require 'wrap-region)
(wrap-region-mode t)

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

;; Browse in new tabs instead of the current one
;; Does not seem to work with chrome
(setq browse-url-new-window-flag t)


;; OTHER MODES AND TOOLS

;; indent entire buffer
(defun indent-buffer ()
    "Indent the buffer"
    (interactive)
    (save-excursion
        (delete-trailing-whitespace)
        (indent-region (point-min) (point-max) nil)
        (untabify (point-min) (point-max))))

;; yasnippet
(require 'yasnippet)
(setq yas/trigger-key "<C-tab>")
(setq yas/prompt-functions '(yas/ido-prompt
                             yas/completing-prompt))
(yas-load-directory "~/.emacs.d/snippets")
(yas-global-mode 1)

;; igrep

(global-set-key (kbd "C-c C-g") 'igrep-find)
(setq igrep-find-use-xargs nil) ;; os x's default xargs doesn't accept the -e option


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

;; PROGRAMMING LANGUAGES, ETC.

;; GENERAL

;; eldoc, how did I ever live without you?
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

;;auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; GENERALLY LISPY STUFF

;; Make sure I have paredit everywhere, including the repl
;; Merci: http://lispservice.posterous.com/paredit-in-the-slime-repl
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)
(mapc (lambda (mode)
        (let ((hook (intern (concat (symbol-name mode)
                                    "-mode-hook"))))
          (add-hook hook (lambda () (paredit-mode +1)))))
      '(emacs-lisp lisp inferior-lisp slime slime-repl))

(defun eval-and-replace ()
  "Replace the preceding sexp with its value.
https://github.com/magnars/.emacs.d/blob/master/defuns/lisp-defuns.el"
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

;; And now nrepl stuff

(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'clojure-nrepl-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

;; CLOJURE


(add-hook 'clojure-mode-hook
          (lambda ()
            (require 'midje-mode)
            (require 'clojure-jump-to-file)
            (imenu-add-menubar-index)
            (local-set-key (kbd "C-c C-j") 'nrepl-jack-in)
            (local-set-key (kbd "C-c C-,") 'midje-check-fact)
            (local-set-key (kbd "C-z") 'nrepl-eval-expression-at-point)))

;; Macs are odd; had to do this to get clojure-jack-in working
(if *on-a-mac*
    (setenv "PATH" (concat "~/bin:" (getenv "PATH"))))

(setenv "PATH" (shell-command-to-string "echo $PATH"))

;; Functions that make it even easier to interact with clojure in emacs.

(defun symbol-at-point-to-string ()
  (interactive)
  (let* ((bounds (bounds-of-thing-at-point 'symbol))
        (start (car bounds))
        (end (cdr bounds)))
    (buffer-substring-no-properties start end)))

(defun get-symbols-in-buffer ()
  (interactive)
  (let ((symbols '()))
    (save-excursion
      (goto-char (point-min))
      (while (forward-symbol 1)
        (setq symbols (cons (symbol-at-point-to-string) symbols))))
    symbols))

(defun clojure-interns (string)
  (let ((namespace-lookup (format "(map str (keys (ns-interns '%s)))" string)))
    (nrepl-interactive-eval namespace-lookup)))

(defun inspect-clojure-namespace (string)
  (interactive (list (read-from-minibuffer "Namespace: ")))
  (clojure-interns string))

(defun inspect-clojure-namespace-at-point ()
  (interactive)
  (listp (clojure-interns (nrepl-symbol-at-point))))

(defun clj-use ()
  "This doesn't work yet"
  (interactive)
  (mapconcat 'identity (intersection (get-symbols-in-buffer) (inspect-clojure-namespace-at-point) :test 'string=) ""))

;; ELISP
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode t)

;; GO

(require 'go-mode-load)

;; HASKELL

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(require 'auto-complete-haskell)

;; JAVA

(global-set-key (kbd "C-h C-j") 'javadoc-lookup)

;; JAVASCRIPT

(add-hook 'js2-mode-hook
          (lambda ()
            (imenu-add-menubar-index)))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; PROTOBUF

(require 'protobuf-mode)

;; PYTHON

(require 'python-mode)
(setq py-shell-name "ipython")
(require 'ac-python)

;; SCHEME

(setq scheme-program-name
      "/Applications/mit-scheme.app/Contents/Resources/mit-scheme")
(require 'xscheme)

;; WEB-MODE

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
