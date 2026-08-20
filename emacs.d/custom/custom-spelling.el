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

;; The desktop file records which minor modes were on in each buffer, and
;; this one was written while jinx-mode was still enabled by hooks: it
;; names jinx-mode for 264 buffers, every one of which would switch it
;; back on and quietly defeat the default above.
;;
;; Two different variables are involved, which is easy to get wrong.
;; desktop consults `desktop-minor-mode-handlers' when *restoring* and
;; falls back to calling the mode function; `desktop-minor-mode-table'
;; only affects what gets *saved*. So the handler stops the existing
;; desktop file from turning jinx on, and the table entry keeps it out of
;; the file next time it is written.
(with-eval-after-load 'desktop
  (add-to-list 'desktop-minor-mode-handlers '(jinx-mode . ignore))
  (add-to-list 'desktop-minor-mode-table '(jinx-mode nil)))

(provide 'custom-spelling)
;;; custom-spelling.el ends here
