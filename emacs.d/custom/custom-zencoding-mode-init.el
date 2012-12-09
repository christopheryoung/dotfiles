
(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-hook 'sgml-mode-hook ( lambda ()
                            (local-set-key (kbd "C-c C-j") 'zencoding-expand-line)))


(provide 'custom-zencoding-mode-init)
