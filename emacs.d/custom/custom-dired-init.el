
;; allow dired to be able to delete or copy a whole dir
;; “always” means no asking. “top” means ask once. Any other symbol means ask
;; each and every time for a dir and subdir.
(setq dired-recursive-copies (quote always))
(setq dired-recursive-deletes (quote top))

(global-auto-revert-mode 1) ;; auto-refresh buffers
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(provide 'custom-dired-init)
