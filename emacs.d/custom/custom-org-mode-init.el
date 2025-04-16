;; Just a stub at the moment

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(add-hook 'org-mode-hook
	  (lambda ()
	    (add-hook 'before-save-hook 'whitespace-cleanup nil t)))


(require 'ox-latex)
(setq org-latex-listings 'minted)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))


(define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)

(setq org-goto-interface 'outline-path-completion)
(setq org-outline-path-complete-in-steps nil)
(setq org-goto-max-level 1)

(provide 'custom-org-mode-init)
