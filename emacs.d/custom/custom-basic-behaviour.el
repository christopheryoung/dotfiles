
;; Cause the region to be highlighted and prevent region-based
;; commands from running when the mark isn't active.
(pending-delete-mode t)
(setq transient-mark-mode t)

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

;; Sentences don't need a double space to end
(set-default 'sentence-end-double-space nil)

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

;; https://github.com/magnars/.emacs.d/blob/master/sane-defaults.el
;; When popping the mark, continue popping until the cursor actually moves
;; Also, if the last command was a copy - skip past all the expand-region cruft.
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (when (eq last-command 'save-region-or-current-line)
      ad-do-it
      ad-do-it
      ad-do-it)
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 100)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; Completions
(add-to-list 'completion-ignored-extensions ".hi")
(add-to-list 'completion-ignored-extensions ".pyc")

;; Safe deletes
(setq delete-by-moving-to-trash t)

;; Better scrolling
(setq scroll-step 1)
(setq scroll-conservatively 1)
(setq scroll-margin 2)


(provide 'custom-basic-behaviour)
