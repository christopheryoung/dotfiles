;;; custom-spelling.el --- Spell checking with jinx  -*- lexical-binding: t -*-

;; jinx replaces flyspell.  It checks only the visible part of the buffer
;; and talks to enchant directly, so it stays responsive in long org and
;; LaTeX files, where flyspell got slow.
;;
;; enchant comes from the Brewfile; jinx compiles a small module against
;; it on first use.
;;
;; Checking is off by default in every buffer.  M-$ turns it on for the
;; buffer at hand and corrects the word at point, which is how M-$ has
;; always behaved; C-c $ toggles it for the buffer without correcting.

(require 'jinx)

(defun custom-spellcheck-correct ()
  "Correct the word at point, enabling `jinx-mode' first if needed."
  (interactive)
  (unless (bound-and-true-p jinx-mode)
    (jinx-mode 1))
  (call-interactively #'jinx-correct))

(keymap-global-set "M-$" #'custom-spellcheck-correct)
(keymap-global-set "C-c $" #'jinx-mode)
(keymap-global-set "C-M-$" #'jinx-languages)

(provide 'custom-spelling)
;;; custom-spelling.el ends here
