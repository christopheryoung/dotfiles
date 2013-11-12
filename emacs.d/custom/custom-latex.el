
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
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; hide footnotes, etc., by default
(add-hook 'LaTeX-mode-hook (lambda ()
                             (TeX-fold-mode 1)))

;; http://www.flannaghan.com/2013/01/11/tex-fold-mode
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (TeX-fold-mode 1)
            (add-hook 'find-file-hook 'TeX-fold-buffer t t)
            (add-hook 'after-change-functions
                      (lambda (start end oldlen)
                        (when (= (- end start) 1)
                          (let ((char-point
                                 (buffer-substring-no-properties
                                  start end)))
                            (when (or (string= char-point "}")
                                      (string= char-point "$"))
                              (TeX-fold-paragraph)))))
                      t t)))

;; setup for latex-extras
;; Note the excellent keybinding C-c C-a, which compiles until done
(eval-after-load 'latex '(latex/setup-keybinds))

(provide 'custom-latex)
