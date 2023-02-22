(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/code/historia/zettelkasten"))
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n g" . org-roam-graph)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n c" . org-roam-capture)
	 ("C-c n r" . org-roam-node-random)
	 :map org-mode-map
	 ("C-M-i" . completion-at-point))
  :config
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol))


(setq org-roam-mode-section-functions
      (list #'org-roam-backlinks-section
	    #'org-roam-reflinks-section
	    ))

(org-roam-db-autosync-mode)

(setq org-roam-graph-viewer "/Applications/Firefox.app/Contents/MacOS/firefox")

(add-to-list 'display-buffer-alist
	     '("\\*org-roam\\*"
	       (display-buffer-in-direction)
	       (direction . below)
	       (window-width . 0.33)
	       (window-height . 0.5)))

(use-package org-roam-ui
    :after org-roam
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
	  org-roam-ui-follow t
	  org-roam-ui-update-on-save t
	  org-roam-ui-open-on-start t))

(provide 'custom-org-roam)
