;;; custom-init-web-mode.el --- HTML/template editing  -*- lexical-binding: t -*-

(autoload 'web-mode "web-mode" "Major mode for editing web templates." t)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(provide 'custom-init-web-mode)
;;; custom-init-web-mode.el ends here
