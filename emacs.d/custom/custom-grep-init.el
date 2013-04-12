
;; note: C-c C-p to make grep buffer writable, C-c C-e to apply changes to buffers
(require 'wgrep)

(setq igrep-find-use-xargs nil) ;; os x's default xargs doesn't accept the -e option
(eval-after-load "grep"
  '(progn
     ;; Don't recurse into some directories
     (add-to-list 'grep-find-ignored-directories "libs")
     (add-to-list 'grep-find-ignored-directories "node_modules")
     (add-to-list 'grep-find-ignored-directories "vendor")
     (add-to-list 'grep-find-ignored-directories "_site")
     (add-to-list 'grep-find-ignored-directories "_cache")))

;; Borrowed from the emacs starter kit
(eval-after-load 'grep
  '(when (boundp 'grep-find-ignored-files)
     (add-to-list 'grep-find-ignored-files "*.class")))

(provide 'custom-grep-init)
