
;; Pretty basic .emacs which I use with emacs starter kit.  Requires
;; Emacs 24 at the moment.

;; DEFAULT COMMANDS THAT I'VE FOUND ESPECIALLY USEFUL
;;
;; . . . General . . .
;;
;; C-a = Move to the beginning of the line
;; C-e = Move to the end of the line
;; C-l = Center buffer around point
;; C-l C-l = put point at top of buffer
;; C-l C-l C-l = put point at buttom of buffer
;; C-t = Transpose two letters
;; C-u <n> <command> = repeat the command n times
;; C-u C-SPC = Cycle through positions in the mark ring
;; C-x z = Redo last change
;; C-x RET = shell
;; C-x C-t = Transpose two lines
;; C-x C-x = swap point and mark
;; C-x C-SPC = pop-global-mark
;; C-x F1 = Show every command starting with C-x
;; C-<SPC> C-<SPC> - Set the mark, pushing it onto the mark ring
;; C-/ = Undo
;; C-= = Expand Region
;; C-M-f = forward over balanced expression
;; C-M-b = backward over balanced expression
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
;; M-$ = spell-check word
;; M-% = Query/replace (space accepts change; n goes on to next)
;; M-} = Move forward one paragraph.
;; M-{ = Move backward one paragraph.

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
                     ac-slime)
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

;; And then byte compile it all

(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

;; APPEARANCE

;; Theme

(load-theme 'manoj-dark)

;; Maxmize emacs

(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; Show more info in taskbar/icon than just "Emacs"

(setq-default frame-title-format (list "%f"))
(setq-default icon-title-format (list "%b"))

;; Get rid of the startup message
(setq inhibit-startup-message t)

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

;; SavePlace- this puts the cursor in the last place you edited
;; a particular file. This is very useful for large files.
(require 'saveplace)
(setq-default save-place t)

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

;; Hippie Expand
;; Willing to part with C-j (new line and indent)
(global-set-key (kbd "C-j") 'hippie-expand)

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


;; Nice to be able to edit .emacs quickly.

(defun open-dot-emacs ()
  "opening-dot-emacs"
  (interactive)                ; this makes the function a command too
  (find-file "/home/chris/.emacs"))

(global-set-key [(shift f1)] 'open-dot-emacs)

;; This is how emacs tells the file type by the file suffix.
(setq auto-mode-alist (cons '("README" . text-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.txt$" . text-mode) auto-mode-alist))

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
(global-set-key [(control return)] 'ido-switch-buffer) 

;; Better scrolling
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; Bookmarks
;; I'm willing to part with C-b and C-p for these
(global-set-key "\C-b" 'bookmark-set)
(global-set-key "\C-p" 'bookmark-bmenu-list)

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

;; ASPELL

(setq-default ispell-program-name "/usr/local/bin/aspell")

;; MAGIT

(autoload 'magit-status "magit" nil t)
(global-set-key (kbd "C-x m") 'magit-status)

;; DIRED-SINGLE

;; Better navigation in dired. Stop the proliferation of unnecessary
;; directories! Stop it now!
;;(require 'dired-single)

;;and then . . . 

(defun my-dired-init ()
  "Bunch of stuff to run for dired, either immediately or when
it's loaded."
  ;; <add other stuff here>
  (define-key dired-mode-map [return] 'joc-dired-single-buffer)
  (define-key dired-mode-map [mouse-1] 'joc-dired-single-buffer-mouse)
  (define-key dired-mode-map "^"
    (function
     (lambda nil (interactive) (joc-dired-single-buffer "..")))))

     ;; if dired's already loaded, then the keymap will be bound
    (if (boundp 'dired-mode-map)
    	;; we're good to go; just add our bindings
    	(my-dired-init)
      ;; it's not loaded yet, so add our bindings to the load-hook
      (add-hook 'dired-load-hook 'my-dired-init))

;; IDO
;; Not necessary if used with emacs starter kit
(require 'ido)
(ido-mode t)

;; TRAMP

(setq tramp-default-method "ssh")

;; MAGIT

(require 'magit)

;; VIPER
;; Don't laugh. This emacs may be a better editor, but modal editing
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

;;auto-complete

(require 'auto-complete-config)
(ac-config-default)

;;; SCHEME

(setq scheme-program-name
      "/Applications/mit-scheme.app/Contents/Resources/mit-scheme")
(require 'xscheme)

;; CLOJURE

(add-hook 'slime-repl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))

;; Mac's are odd; had to do this to get clojure-jack-in working
(if (eq system-type 'darwin)
    (setenv "PATH" (concat "~/bin:" (getenv "PATH"))))

(setenv "PATH" (shell-command-to-string "echo $PATH"))

;; ac-slime (autocomplete)
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
    
