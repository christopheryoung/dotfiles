(require 'tex-site)
(require 'font-latex)
(require 'org)
(require 'org-src)

;; Some defaults
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; setup for latex-extras
;; Note the excellent keybinding C-c C-a, which compiles until done
(eval-after-load 'latex '(latex/setup-keybinds))

;; Enable syntax highlighting for LaTeX blocks
(setq org-src-fontify-natively t)

;; Associate LaTeX with org-mode src blocks
(add-to-list 'org-src-lang-modes '("latex" . latex))

;; Automatically switch to LaTeX mode for LaTeX src blocks
(defun my/org-latex-mode-setup ()
  (when (string-equal (org-element-property :language (org-element-at-point)) "latex")
    (LaTeX-mode)))

(add-hook 'org-src-mode-hook 'my/org-latex-mode-setup)

;; Function to insert LaTeX block
(defun my/org-insert-latex-block ()
  "Insert a LaTeX block in org-mode."
  (interactive)
  (insert "#+BEGIN_SRC latex\n\n#+END_SRC")
  (forward-line -1)
  (indent-for-tab-command))

;; Bind the function to a key combination, e.g., C-c C-l
(define-key org-mode-map (kbd "C-c C-l") 'my/org-insert-latex-block)

(defun my/export-latex ()
  "Call the Python script org_to_pdf_pipeline.py with the full path of the current buffer as an argument."
  (interactive)
  (let ((buffer-path (buffer-file-name))
	(script-path (expand-file-name "~/code/historia/org_to_pdf_pipeline.py")))
    (if buffer-path
	(start-process "python-script" "*Python Script Output*" "python3" script-path buffer-path)
      (message "Buffer is not visiting a file!"))))

(provide 'custom-latex)
