;;; custom-basic-behaviour.el --- General editor behaviour  -*- lexical-binding: t -*-

;; set coding system: Note that doing this explicitly fixes an obscure magit bug
(prefer-coding-system 'utf-8)

(setq ring-bell-function 'ignore)

;; Cause the region to be highlighted and prevent region-based
;; commands from running when the mark isn't active.
(delete-selection-mode 1)

;; Don't, for the love of Pete, make me type out "Yes" whenever I want
;; to quit emacs.  "y" and "n" will do.
(setq kill-emacs-query-functions
      (list (lambda ()
	      (ding)
	      (y-or-n-p "Really quit? "))))

;; Answer y or n instead of yes or no at minibuffer prompts.
(setq use-short-answers t)

;; And let me just hit return for "yes" when I'm feeling really lazy.
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)

;; No need to see byte compile warnings
(setq byte-compile-warnings nil)

;; Sentences don't need a double space to end
(setq-default sentence-end-double-space nil)

;; New buffers start in Text mode, not Fundamental
(setq-default major-mode 'text-mode)

;; When we save a buffer to a file, if the path contains dirs that
;; don't exist yet, just create them for me
(add-hook 'before-save-hook
	  (lambda ()
	    (when buffer-file-name
	      (let ((dir (file-name-directory buffer-file-name)))
		(unless (file-exists-p dir)
		  (make-directory dir t))))))

;; Strip trailing whitespace on save, except where it is meaningful
(add-hook 'before-save-hook
	  (lambda ()
	    (unless (derived-mode-p 'fundamental-mode 'markdown-mode)
	      (whitespace-cleanup))))

;; Just pretend I hit key command for save-some-buffers everytime I
;; accidentially hit key command for save-buffer
(global-set-key (kbd "C-x C-s") 'save-some-buffers)

;; Reload buffers when they have changed on disk, unless they have their own
;; local modifications
(global-auto-revert-mode 1)

;; Backups: keep them out of the working tree, but don't clutter with
;; auto-save files
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups" user-emacs-directory)))
      make-backup-files nil
      auto-save-default nil)

;; Undo.  vundo visualises Emacs' own undo history rather than keeping a
;; parallel tree of its own, so there are no history files to go stale --
;; which is what all the undo-tree noise at startup was about.  The
;; trade-off is that undo history is per-session.
;;
;; Keep a generous in-memory history, since that is now all there is.
(setq undo-limit (* 4 1024 1024)          ; 4MB, default 160KB
      undo-strong-limit (* 6 1024 1024)
      undo-outer-limit (* 48 1024 1024))

;; Save the desktop . . .
(setq desktop-load-locked-desktop t)
;; . . . but restore it lazily.  Several hundred buffers are visited on
;; every start; this reads the first few immediately and fills in the
;; rest while Emacs is idle, so the frame is usable straight away.
(setq desktop-restore-eager 15
      desktop-lazy-verbose nil
      desktop-lazy-idle-delay 3)
(desktop-save-mode 1)

;; . . . or at least, most of the desktop.  We don't need to load
;; everything up.
(setq desktop-buffers-not-to-save
      (concat "\\(" "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
	      "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
	      "\\)$"))
(dolist (mode '(dired-mode Info-mode info-lookup-mode fundamental-mode))
  (add-to-list 'desktop-modes-not-to-save mode))

;; https://github.com/magnars/.emacs.d/blob/master/sane-defaults.el
;; When popping the mark, continue popping until the cursor actually moves
;; Also, if the last command was a copy - skip past all the expand-region cruft.
(define-advice pop-to-mark-command (:around (original) ensure-new-position)
  (let ((p (point)))
    (when (eq last-command 'save-region-or-current-line)
      (funcall original)
      (funcall original)
      (funcall original))
    (dotimes (_ 10)
      (when (= p (point)) (funcall original)))))

;; Allow for mark ring traversal without popping them off the stack.
(setq set-mark-command-repeat-pop t)

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 100)

;; Completions
(dolist (ext '(".pyc" ".pyo"))
  (add-to-list 'completion-ignored-extensions ext))

;; Safe deletes
(setq delete-by-moving-to-trash t)

;; Better scrolling
(setq scroll-step 1
      scroll-conservatively 1
      scroll-margin 2)

;; flyspell start up
(setq flyspell-issue-welcome-flag nil)
(flyspell-prog-mode) ;; Checks spelling in comments and doc strings

;; Windmove helps you move between open buffers when the screen is split
(windmove-default-keybindings)

;; Make searches case insensitive
(setq case-fold-search t)

;; Browse in new tabs instead of the current one
(setq browse-url-new-window-flag t)

;; dumb jump
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;; electric-pair-mode is built in and replaces wrap-region, which was
;; last touched in 2014 and was the final package pulling in the
;; deprecated cl library.
(electric-pair-mode 1)

;; Version control gutter.  diff-hl replaces git-gutter and knows how to
;; refresh itself after magit operations.
(require 'diff-hl)
(global-diff-hl-mode 1)
(diff-hl-margin-mode 1)          ; works in the terminal too
(with-eval-after-load 'magit
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(setq magit-status-buffer-switch-function 'switch-to-buffer)

(setq tramp-default-method "ssh")

(require 'openwith)
(setq openwith-associations
      '(("\\.pdf\\'" "open" ("-a" "Preview" file))))
(openwith-mode 1)

(provide 'custom-basic-behaviour)
;;; custom-basic-behaviour.el ends here
