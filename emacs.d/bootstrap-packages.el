;;; bootstrap-packages.el --- First-run package install  -*- lexical-binding: t -*-

;; Run this once on a new machine, before starting Emacs normally:
;;
;;     emacs --batch -l ~/.emacs.d/bootstrap-packages.el
;;
;; It exists because of an ordering problem. straight.el clones each
;; package's default branch, which for several packages here is ahead of
;; what Emacs 30 can run -- magit's HEAD, for one, calls `incf'
;; unprefixed and errors on load. Since .emacs does (require 'magit) at
;; startup, a new machine could not even reach an Emacs where you could
;; type M-x straight-thaw-versions.
;;
;; So this file clones the packages without loading them, checks each
;; repository out at the commit recorded in straight/versions/default.el,
;; and clears the build cache so the next normal start rebuilds at those
;; versions.
;;
;; It checks the commits out with git directly rather than calling
;; `straight-thaw-versions', which routes through a confirmation layer
;; that cannot run in batch mode.

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
			 user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))

;; Clones and builds everything, but does not `require' any of it.
(require 'custom-packages)

;; gptel is requested from custom-llm.el, which only loads on a personal
;; machine; mirror that here so the lockfile can pin it.
(when (file-exists-p "~/.personal_machine")
  (straight-use-package 'gptel))

(defun bootstrap--pin-to-lockfile ()
  "Check every repository out at the commit recorded in the lockfile.
Returns a plist of counts.  Uses git directly rather than
`straight-thaw-versions', which routes through a confirmation layer that
cannot run in batch mode."
  (let* ((lockfile (expand-file-name "straight/versions/default.el"
				     user-emacs-directory))
	 (repos-dir (expand-file-name "straight/repos/" user-emacs-directory))
	 (pinned (when (file-exists-p lockfile)
		   (with-temp-buffer
		     (insert-file-contents lockfile)
		     (goto-char (point-min))
		     (read (current-buffer)))))
	 (done 0) (missing 0) (failed 0))
    (dolist (entry pinned)
      (let* ((repo (car entry))
	     (commit (cdr entry))
	     (dir (expand-file-name repo repos-dir)))
	(cond
	 ((not (file-directory-p dir))
	  (setq missing (1+ missing)))
	 ((zerop (let ((default-directory dir))
		   (call-process "git" nil nil nil "checkout" "--quiet" commit)))
	  (setq done (1+ done)))
	 (t
	  (setq failed (1+ failed))
	  (message "  could not check out %s at %s" repo commit)))))
    (list :pinned done :missing missing :failed failed :total (length pinned))))

(let ((counts (bootstrap--pin-to-lockfile)))
  (if (zerop (plist-get counts :total))
      (message "No lockfile; packages are left at their default branches")
    (message "Pinned %d of %d repositories (%d not cloned, %d failed)"
	     (plist-get counts :pinned) (plist-get counts :total)
	     (plist-get counts :missing) (plist-get counts :failed))))

;; Anything straight is using that the lockfile does not name is running
;; unpinned. That normally means a recipe changed upstream and now points
;; at a different repository -- straight resolved it from whatever melpa
;; was cloned at, before the lockfile could pin melpa itself. Running
;; this file a second time resolves recipes from the now-pinned melpa and
;; settles it; anything still listed here needs a look.
(let (unpinned
      (lockfile (expand-file-name "straight/versions/default.el"
				  user-emacs-directory)))
  (let ((names (when (file-exists-p lockfile)
		 (mapcar #'car (with-temp-buffer
				 (insert-file-contents lockfile)
				 (goto-char (point-min))
				 (read (current-buffer)))))))
    (maphash (lambda (repo _v)
	       (unless (member repo names) (push repo unpinned)))
	     straight--repo-cache)
    (when unpinned
      (message "Not pinned by the lockfile: %s"
	       (mapconcat #'identity (sort unpinned #'string<) ", ")))))

;; Force a rebuild so the byte-compiled files match the pinned sources.
(let ((cache (expand-file-name "straight/build-cache.el" user-emacs-directory)))
  (when (file-exists-p cache) (delete-file cache)))

(message "Done. Start Emacs normally; it will rebuild at these versions.")

;;; bootstrap-packages.el ends here
