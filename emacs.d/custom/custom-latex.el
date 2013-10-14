
(require 'tex-site)
(require 'font-latex)

;; Thanks to
;; https://github.com/jhamrick/emacs/blob/master/.emacs.d/settings/latex-settings.el
;; for tex view stuff below
(setq TeX-view-program-list
      (quote
       (("Skim"
         (concat "/Applications/Skim.app/"
                 "Contents/SharedSupport/displayline"
                 " %n %o %b")))))
(setq TeX-view-program-selection
      (quote (((output-dvi style-pstricks) "dvips and gv")
              (output-dvi "xdvi")
              (output-pdf "Skim")
              (output-html "xdg-open"))))

;; Some defaults
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-PDF-mode t)

;; hide footnotes, etc., by default
(add-hook 'LaTeX-mode-hook (lambda ()
                             (TeX-fold-mode 1)))
(add-hook 'find-file-hook 'TeX-fold-buffer t)

;; setup for latex-extras
;; Note the excellent keybinding C-c C-a, which compiles until done
(eval-after-load 'latex '(latex/setup-keybinds))

(provide 'custom-latex)
