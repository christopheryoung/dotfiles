(require 'package)


(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(defvar my-package-packages '(
			      ace-jump-mode
			      auctex
			      clang-format
			      cquery
			      csv-mode
			      dash
			      diminish
			      discover
			      ebib
			      erlang
			      exec-path-from-shell
			      expand-region
			      fill-column-indicator
			      find-file-in-repository
			      flycheck
			      flx-ido
			      git-timemachine
			      git-gutter
			      git-messenger
			      haskell-mode
			      helm
			      helm-bibtex
			      helm-swoop
			      ht
			      hydra
			      iedit
			      idle-highlight-mode
			      ido-vertical-mode
			      ;; intero
			      ;; ipython
			      ispell
			      json-mode
			      jump-char
			      latex-extra
			      leuven-theme
			      loop
			      lsp-mode
			      magit
			      mark-multiple
			      markdown-mode
			      maxframe
			      midje-mode
			      multi-term
			      multiple-cursors
			      openwith
			      org-ref
			      org-roam
			      org-roam-ui
			      paredit
			      projectile
			      pylint
			      ;;pymacs
			      ;; python-pep8
			      ;; python-pylint
			      pyvenv
			      rainbow-delimiters
			      ;; repository-root
			      s
			      smex
			      sqlite
			      undo-tree
			      use-package
			      visual-fill-column
			      wgrep
			      windmove
			      wrap-region
			      yasnippet
			      )
  "A list of packages to ensure are installed at launch.")

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

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
