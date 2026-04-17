;; Modern completion framework
;; Uses Vertico + Consult + Orderless + Marginalia + Embark

;; Vertico: vertical completion UI
(require 'vertico)
(vertico-mode 1)

;; Hide group titles (like "Buffer", "File", etc.)
(setq vertico-group-format nil)

;; Enable saving of command history for M-x
;; This gives us recently-used commands at the top
(savehist-mode 1)

;; Better directory navigation in vertico
(define-key vertico-map (kbd "RET") 'vertico-directory-enter)
(define-key vertico-map (kbd "DEL") 'vertico-directory-delete-char)
(define-key vertico-map (kbd "M-DEL") 'vertico-directory-delete-word)

;; Cycle through candidates
(define-key vertico-map (kbd "C-n") 'vertico-next)
(define-key vertico-map (kbd "C-p") 'vertico-previous)

;; Orderless: flexible matching (space-separated patterns)
(require 'orderless)
(setq completion-styles '(orderless basic))
(setq completion-category-defaults nil)
(setq completion-category-overrides
      '((file (styles partial-completion))))

;; Marginalia: rich annotations in the minibuffer
(require 'marginalia)
(marginalia-mode 1)

;; Disable buffer annotations to reduce clutter
(setq marginalia-annotators (assq-delete-all 'buffer marginalia-annotators))

;; Consult: enhanced search and navigation commands
(require 'consult)

;; Hide group titles in consult-buffer
(consult-customize consult-buffer :group nil)

;; Replace default commands with consult versions
(global-set-key (kbd "C-x b") 'consult-buffer)
(global-set-key (kbd "C-x 4 b") 'consult-buffer-other-window)
(global-set-key (kbd "C-x 5 b") 'consult-buffer-other-frame)
(global-set-key (kbd "M-y") 'consult-yank-pop)
(global-set-key (kbd "M-s l") 'consult-line)
(global-set-key (kbd "M-s L") 'consult-line-multi)
(global-set-key (kbd "M-s g") 'consult-grep)
(global-set-key (kbd "M-s G") 'consult-git-grep)
(global-set-key (kbd "M-s r") 'consult-ripgrep)
(global-set-key (kbd "C-x C-r") 'consult-recent-file)

;; Embark: context actions
(require 'embark)
(require 'embark-consult)
(global-set-key (kbd "C-;") 'embark-act)
(global-set-key (kbd "C-h B") 'embark-bindings)

;; Keep ido enabled for certain contexts if desired
;; (ido will be used where vertico doesn't apply)
(setq ido-enable-flex-matching t)
(setq ido-everywhere nil)  ; Let vertico handle most completions

;; Configure completion to work well with org-ref
;; org-ref uses completing-read which vertico will handle automatically
(setq org-ref-completion-library 'org-ref-ivy-cite)

(provide 'custom-completion-init)
