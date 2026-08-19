;;; custom-text-mode-init.el --- Plain text  -*- lexical-binding: t -*-

(setq auto-mode-alist (cons '("README" . text-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.txt$" . text-mode) auto-mode-alist))

(provide 'custom-text-mode-init)
;;; custom-text-mode-init.el ends here
