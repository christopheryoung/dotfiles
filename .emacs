;;; .emacs --- Christopher Young's Emacs configuration  -*- lexical-binding: t -*-

;; Commands I still haven't committed to muscle memory
;; C-u <n> <command> = repeat the command n times
;; C-u M-! = inserts results of a shell command directly into the buffer
;; C-w = kill region (but in isearch will insert word after point into
;;       the search)
;; C-x F1 = Show every command starting with C-x
;; C-<SPC> C-<SPC> = Push the mark onto the mark ring *without* setting it
;; C-M-b = backward over balanced expression
;; C-M-f = forward over balanced expression
;; C-M-s = regular expression search forward
;; C-M-v = scroll other window
;; M-c = Capitalize word
;; M-m = Jump to first non-whitespace character in line
;; M-z = Zap to char
;; M-$ = spell-check word
;; apropos-documentation -- search doc strings of functions and variables
;; apropos -- searches all functions and variables
;;
;; . . . In Org mode . . .
;;
;; C-c C-n = Move to next heading.
;; C-c C-p = Move to previous heading.
;; C-c C-f = Move to next heading same level.
;; C-c C-b = Move to previous heading same level.
;; C-c C-u = Move backward to higher level heading.

;; straight.el bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
			 user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(package-initialize)

(defvar *on-a-mac* (and (string-match "apple-darwin" system-configuration) t)
  "Non-nil when running on macOS.")

(defvar dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name))
  "The directory this init file lives in.")

;; directory for most customizations
(add-to-list 'load-path "~/.emacs.d/custom/")

;; install required packages
(require 'custom-packages)

;; useful elisp
(require 'custom-defuns)

;; minor modes
(require 'ace-jump-mode)
(require 'custom-completion-init)
(require 'custom-init-paredit)
(require 'custom-yasnippet-init)
(require 'custom-projectile)
(require 'diminish)
(require 'expand-region)
(require 'flyspell)
(global-git-gutter-mode +1)
(require 'jump-char)
(require 'multiple-cursors)
(require 'rainbow-delimiters)
(require 'smartscan)
(require 'undo-tree)
(require 'wrap-region)

;; major modes, not programming languages
(require 'custom-dired-init)
(require 'custom-grep-init)
(require 'custom-multi-term-init)
(require 'custom-text-mode-init)
(require 'magit)
(require 'uniquify)
(require 'visible-mark)

;; org mode
(eval-after-load 'org '(require 'custom-org-mode-init))
(setq org-startup-with-inline-images t)
(require 'org-ref)
(let ((bib '("~/code/historia/bibliography.bib")))
  (setq reftex-default-bibliography bib
	org-ref-default-bibliography bib))
(require 'custom-org-roam)

;; LLM integration (personal machine only)
(when (file-exists-p "~/.personal_machine")
  (require 'custom-llm))

;; major modes, programming languages, etc.
(require 'custom-markdown-mode)
(require 'custom-latex)
(require 'custom-init-python)
(require 'custom-init-web-mode)

;; Customizations
(require 'custom-appearance)
(require 'custom-basic-behaviour)
(require 'custom-global-keybindings)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:lighter "")
 '(sort-fold-case t t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
