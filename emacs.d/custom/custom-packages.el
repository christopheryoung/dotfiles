
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(defvar my-package-packages '(
                              ace-jump-mode
                              ace-jump-zap
                              auctex
                              auto-complete
                              clojure-mode
                              csv-mode
                              dash
                              diminish
                              dired-details
                              discover
                              ebib
                              elpy
                              erlang
                              exec-path-from-shell
                              expand-region
                              fill-column-indicator
                              find-file-in-repository
                              git-timemachine
                              git-gutter
                              git-messenger
                              grizzl
                              haskell-mode
                              ht
                              hydra
                              iedit
                              igrep
                              ipython
                              ispell
                              ;; js2-mode
                              ;; js2-refactor
                              json-mode
                              jump-char
                              latex-extra
                              leuven-theme
                              loop
                              magit
                              mark-multiple
                              markdown-mode
                              maxframe
                              midje-mode
                              multi-term
                              multiple-cursors
                              paredit
                              projectile
                              pylint
                              pymacs
                              python-pep8
                              python-pylint
                              pyvenv
                              rainbow-delimiters
                              repository-root
                              s
                              smex
                              starter-kit
                              starter-kit-bindings
                              starter-kit-js
                              starter-kit-lisp
                              undo-tree
                              wgrep
                              windmove
                              wrap-region
                              yasnippet
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

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(provide 'custom-packages)
