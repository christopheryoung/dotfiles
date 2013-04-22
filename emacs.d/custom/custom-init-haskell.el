
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'haskell-font-lock-symbols t)
(add-to-list 'completion-ignored-extensions ".hi")

(require 'auto-complete-haskell)

(require 'hs-lint)
(require 'haskell-ac)

(custom-set-variables
 '(haskell-mode-hook '(turn-on-haskell-indentation)))

(defun my-haskell-mode-hook ()
  "hs-lint binding, plus autocompletion and paredit."
  (local-set-key "\C-cl" 'hs-lint)
  (local-set-key (kbd "C-h h") 'haskell-hoogle)
  (setq ac-sources
        (append '(ac-source-yasnippet
                  ac-source-abbrev
                  ac-source-words-in-buffer
                  my/ac-source-haskell)
                ac-sources))
  (dolist (x '(haskell literate-haskell))
    (add-hook
     (intern (concat (symbol-name x)
                     "-mode-hook")))))

(provide 'custom-init-haskell)
