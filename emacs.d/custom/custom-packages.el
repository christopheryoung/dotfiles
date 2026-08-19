;;; custom-packages.el --- Package installation via straight.el  -*- lexical-binding: t -*-

;; straight.el itself is bootstrapped in ~/.emacs, which must happen
;; before this file is loaded.  Everything below is installed from
;; source and pinned by the lockfile in straight/versions/.

(defvar my-packages
  '(;; Editing and navigation
    avy
    expand-region
    idle-highlight-mode
    iedit
    jump-char
    multiple-cursors
    paredit
    rainbow-delimiters
    smartscan
    undo-tree
    visible-mark
    wrap-region
    yasnippet

    ;; Buffers, files, projects
    diminish
    dumb-jump
    exec-path-from-shell
    find-file-in-repository
    multi-term
    openwith
    projectile
    wgrep

    ;; Completion: vertico stack
    consult
    embark
    embark-consult
    marginalia
    orderless
    vertico

    ;; Git
    ;; magit declares its dependencies in a multi-line Package-Requires
    ;; header that straight does not parse, so list them explicitly.
    cond-let
    llama
    transient
    with-editor
    git-gutter
    git-timemachine
    magit

    ;; Org, notes and bibliography
    ebib
    markdown-mode
    org-ref
    org-roam
    org-roam-ui

    ;; LaTeX
    auctex
    latex-extra

    ;; Programming languages
    csv-mode
    haskell-mode
    pyvenv
    web-mode)
  "Packages installed with straight.el at startup.")

(dolist (package my-packages)
  (straight-use-package package))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(provide 'custom-packages)
;;; custom-packages.el ends here
