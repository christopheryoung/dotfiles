;;; custom-dired-init.el --- Dired tweaks  -*- lexical-binding: t -*-
;; allow dired to be able to delete or copy a whole dir
;; “always” means no asking. “top” means ask once. Any other symbol means ask
;; each and every time for a dir and subdir.
(setq dired-recursive-copies (quote always))
(setq dired-recursive-deletes (quote top))

;; global-auto-revert-mode itself is enabled in custom-basic-behaviour
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(setq large-file-warning-threshold (* 100 1024 1024))

(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)

(provide 'custom-dired-init)
;;; custom-dired-init.el ends here
