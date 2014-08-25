
(defvar server-buffer-clients)
(when (and (fboundp 'server-start) (string-equal (getenv "TERM") 'xterm))
  (server-start)
  (defun fp-kill-server-with-buffer-routine ()
    (and server-buffer-clients (server-done)))
  (add-hook 'kill-buffer-hook 'fp-kill-server-with-buffer-routine))

;; Much help from here in setting up jedi and elpy:
;; https://github.com/wernerandrew/jedi-starter/blob/master/jedi-starter.el

(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-o") 'ace-jump-mode)
             ))
(add-hook 'python-mode-hook 'jedi:setup)

;; look at C-h v : jedi:server-args
(defvar jedi-config:with-virtualenv "~/.virtualenvs/sch")
(defvar jedi-config:vcs-root-sentinel ".git")

;;(defvar jedi-config:use-system-python t)

;; getting errors unless I add this hook; eldoc is still on even with this
;; hook, which is good, since it then works, but also puzzling (perhaps with
;; this hook I'm disabling a different or improperly configured version of
;; el-doc that interferes with the one that elpy sets up for me?).
(add-hook 'python-mode-hook '(lambda () (eldoc-mode)))
(add-hook 'elpy-mode-hook '(lambda ()
                             (eldoc-mode)
                             (local-set-key (kbd "C-h C-j") 'elpy-show-defun)))

(add-to-list 'ac-sources 'ac-source-jedi-direct)


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

(provide 'custom-init-python)
