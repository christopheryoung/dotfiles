;;; custom-spelling.el --- Spell checking with jinx  -*- lexical-binding: t -*-

;; jinx replaces flyspell.  It checks only the visible part of the buffer
;; and talks to enchant directly, so it stays responsive in the long org
;; and LaTeX files this config spends most of its time in.  flyspell
;; re-checked eagerly and got slow in exactly those buffers.
;;
;; enchant comes from the Brewfile; jinx compiles a small module against
;; it on first use.

(require 'jinx)

;; Prose everywhere, and comments and docstrings in code.
(add-hook 'text-mode-hook #'jinx-mode)
(add-hook 'org-mode-hook #'jinx-mode)
(add-hook 'markdown-mode-hook #'jinx-mode)
(add-hook 'prog-mode-hook #'jinx-mode)

;; M-$ was flyspell's correct-word; jinx-correct is the equivalent and
;; also offers to save the word to a personal dictionary.
(keymap-global-set "M-$" #'jinx-correct)
(keymap-global-set "C-M-$" #'jinx-languages)

(provide 'custom-spelling)
;;; custom-spelling.el ends here
