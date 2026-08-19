;;; custom-packages.el --- Package installation via straight.el  -*- lexical-binding: t -*-

;; straight.el itself is bootstrapped in ~/.emacs, which must happen
;; before this file is loaded.  Everything below is installed from
;; source and pinned by the lockfile in straight/versions/.
;;
;; IMPORTANT: straight tracks each package's git HEAD, and a growing
;; number of packages now target Emacs 31 -- they call `incf'/`decf'
;; unprefixed, or pass the Emacs 31 argument list to `seconds-to-string'.
;; On Emacs 30 those blow up at runtime rather than at build time, so the
;; breakage shows up as a broken command, not a failed install.  magit,
;; vertico, consult, embark and marginalia have each been rolled back to
;; the newest release that still runs on Emacs 30; the exact commits live
;; in straight/versions/default.el.
;;
;; So: do NOT run `straight-pull-all'.  To update deliberately, pull one
;; package, exercise it, and re-run `straight-freeze-versions'.  To get
;; back to a known-good state, run `straight-thaw-versions'.  Once this
;; machine is on Emacs 31, these rollbacks can be revisited.

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
    visible-mark
    vundo
    yasnippet

    ;; Buffers, files, projects
    diminish
    dumb-jump
    eat
    exec-path-from-shell
    find-file-in-repository
    openwith
    projectile
    wgrep

    ;; Completion: vertico stack
    consult
    corfu
    embark
    embark-consult
    marginalia
    orderless
    vertico

    ;; Git
    diff-hl
    ;; magit declares its dependencies in a multi-line Package-Requires
    ;; header that straight does not parse, so list them explicitly.
    cond-let
    llama
    transient
    with-editor
    git-timemachine
    magit

    ;; Org, notes and bibliography
    ;; bibtex-completion arrives with org-ref, but the config sets
    ;; bibtex-completion-bibliography directly, so name it here too.
    bibtex-completion
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
