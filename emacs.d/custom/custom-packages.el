
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
                              dash
                              expand-region
                              find-file-in-project
                              go-mode
                              iedit
                              igrep
                              javadoc-help
                              js2-mode
                              js2-refactor
                              haskell-mode
                              ispell
                              magit
                              markdown-mode
                              maxframe
                              midje-mode
                              multi-term
                              multiple-cursors
                              nrepl
                              paredit
                              protobuf-mode
                              python-mode
                              pyregexp
                              quack
                              rainbow-delimiters
                              repository-root
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

(provide 'custom-packages)
