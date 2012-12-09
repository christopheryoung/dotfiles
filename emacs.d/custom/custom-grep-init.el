
(setq igrep-find-use-xargs nil) ;; os x's default xargs doesn't accept the -e option
(eval-after-load "grep"
  '(progn
     ;; Don't recurse into some directories
     (add-to-list 'grep-find-ignored-directories "libs")
     (add-to-list 'grep-find-ignored-directories "node_modules")
     (add-to-list 'grep-find-ignored-directories "vendor")))

(provide 'custom-grep-init)
