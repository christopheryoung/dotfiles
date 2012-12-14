
(defun insert-comma-at-the-end-of-the-previous-line ()
  (interactive)
  (save-excursion
    (previous-line)
    (move-end-of-line nil)
    (insert ",")))

(setq-default js2-global-externs '("module" "require" "jQuery" "$" "_" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
(setq-default js2-idle-timer-delay 0.1)
(setq-default js2-strict-inconsistent-return-warning nil)
(setq-default js2-auto-indent-p t)

(add-hook 'js2-mode-hook
          (lambda ()
            (imenu-add-menubar-index)
            (local-set-key (kbd "C-c ,") 'insert-comma-at-the-end-of-the-previous-line)
            (local-set-key (kbd "C-c C-n") 'js2-next-error)
            ;; for some reason js2 mode turns off idle-highlight-mode, so make
            ;; sure it's on
            (idle-highlight-mode t)))

(require 'js2-imenu-extras)
(js2-imenu-extras-setup)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Next two formatting tweaks thanks to:
;; https://github.com/magnars/.emacs.d/blob/master/setup-js2-mode.el

;; Use lambda for anonymous functions
(font-lock-add-keywords
 'js2-mode `(("\\(function\\) *("
              (0 (progn (compose-region (match-beginning 1)
                                        (match-end 1) "\u0192")
                        nil)))))

;; Use right arrow for return in one-line functions
(font-lock-add-keywords
 'js2-mode `(("function *([^)]*) *{ *\\(return\\) "
              (0 (progn (compose-region (match-beginning 1)
                                        (match-end 1) "\u2190")
                        nil)))))

(provide 'custom-init-js2)
