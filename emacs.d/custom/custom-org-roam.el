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

(defun display-half-frame (buffer-name)
  "Ensure the buffer named BUFFER-NAME occupies half the frame vertically."
  (let ((buf (get-buffer-create buffer-name)))
    (unless (get-buffer-window buf)
      (split-window-vertically))
    (set-window-buffer (next-window) buf)
    (balance-windows)))

;; Modify the display-buffer-alist to use our custom function.
(add-to-list 'display-buffer-alist
	     '("\\*org-roam\\*"
	       (lambda (buffer alist)
		 (display-half-frame "*org-roam*")
		 ;; Return the window displaying *org-roam*.
		 (get-buffer-window "*org-roam*"))))

(add-hook 'org-roam-mode-hook
	  (lambda ()
	    (add-hook 'before-save-hook 'whitespace-cleanup nil t)))


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
