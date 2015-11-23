
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-o") 'ace-jump-mode)
             (rainbows-delimiters-mode)))

(add-hook 'python-mode-hook 'jedi:setup)

;; look at C-h v : jedi:server-args
(defvar jedi-config:with-virtualenv "~/.virtualenvs/sch")
(defvar jedi-config:vcs-root-sentinel ".git")

;; getting errors unless I add this hook; eldoc is still on even with this
;; hook, which is good, since it then works, but also puzzling (perhaps with
;; this hook I'm disabling a different or improperly configured version of
;; el-doc that interferes with the one that elpy sets up for me?).
(add-hook 'python-mode-hook '(lambda () (eldoc-mode)))
(add-hook 'elpy-mode-hook '(lambda ()
                             (eldoc-mode)
                             (whitespace-mode t)
                             (rainbows-delimiters-mode)
                             (local-set-key (kbd "C-h C-j") 'elpy-show-defun)))

(setq python-fill-docstring-style 'django)

(package-initialize)
;; why do I need to do this again? elpy-enable doesn't
;; seem to cooperate unless I do
(elpy-enable)
(setq elpy-rpc-backend "jedi")

(elpy-use-ipython)
;;(require 'pydoc-info)

(defun python-helm-docs ()
  (interactive)
  (setq-local helm-dash-docsets '("Python_2")))

(add-hook 'python-mode-hook 'python-helm-docs)

(eval-after-load "helm-dash"
  '(defun helm-dash-actions (actions doc-item) `(("Go to doc" . eww))))

(defun annotate-ipdb ()
  (interactive)
  (highlight-lines-matching-regexp "import ipdb")
  (highlight-lines-matching-regexp "ipdb.set_trace()"))

(add-hook 'python-mode-hook 'annotate-pdb)

;;----------
;; Keybinding to add breakpoint:
(defun python-add-breakpoint ()
  (interactive)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

(elpy-enable)

(provide 'custom-init-python)
