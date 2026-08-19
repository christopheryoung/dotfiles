;;; custom-defuns.el --- Handy commands  -*- lexical-binding: t -*-

;; M-q is very handy for formatting text, but sometimes you want to remove the
;; formatting . . .
(defun remove-line-breaks ()
  "Remove line endings in a paragraph."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;; . . . or remove the formatting in the entire buffer . . .
(defun remove-line-breaks-in-buffer ()
  "Remove line endings in every line of the buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (< (point) (point-max))
      (let ((fill-column (point-max)))
	(fill-paragraph nil)
	(forward-paragraph)))))

;;  . . . or add it back afterwards . . .
(defun add-line-breaks-in-buffer ()
  "Apply `org-fill-paragraph` to every line in the buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (< (point) (point-max))
      (org-fill-paragraph nil)
      (forward-paragraph))))


;; Thanks: http://tuxicity.se/emacs/elisp/2010/03/11/duplicate-current-line-or-region-in-emacs.html
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
	(exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
	(exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (_ arg)
	(goto-char end)
	(newline)
	(insert region)
	(setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

;; jump to matching paren
;; Thanks to https://github.com/avar/dotemacs/blob/master/.emacs
(defun match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
	((looking-back "[\]\)\}]" 1) (backward-sexp))
	;; now, try to succeed from inside of a bracket
	((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
	((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
	(t (self-insert-command (or arg 1)))))

;; Note: `rename-visited-file' (built in since Emacs 28) replaces the
;; old rename-file-and-buffer / move-buffer-file pair that lived here.

;; indent entire buffer
(defun indent-buffer ()
  "Indent the buffer"
  (interactive)
  (save-excursion
    ;(delete-trailing-whitespace)
    (indent-region (point-min) (point-max) nil)
    (untabify (point-min) (point-max))))

(defun search-interwebs(query)
  (interactive "sSearch for: ")
  (browse-url (concat "https://duckduckgo.com/?q=" query)))

;; Make it easy to get to my worklog
(defun open-worklog ()
  (interactive)
  (find-file "~/Dropbox/cy/notes/worklog.txt"))

(defun worklog-date-stamp ()
  (interactive)
  (insert (format-time-string "%m/%d/%Y ")))


(defun search-all-buffers (regexp)
   (interactive "sRegexp: ")
   (multi-occur-in-matching-buffers "." regexp t))

(defun snapshot ()
  "Run the `snapshot' script."
  (interactive)
  (save-some-buffers t)
  (shell-command "snapshot")
  (switch-to-buffer "*Messages*"))

(defun capture-website (url)
  "Capture a website with the `capture' script, a wrapper around monolith."
  (interactive "sEnter URL to capture: ")
  (shell-command (concat "capture " url)))

(defun my-dired-move-file-to-library ()
  "Move the selected file in Dired to ~/Dropbox/library."
  (interactive)
  (let* ((file (dired-get-file-for-visit))
	 (destination-directory "~/Dropbox/library/")
	 (destination (expand-file-name (file-name-nondirectory file) destination-directory)))
    (dired-rename-file file destination nil)
    (message "Moved '%s' to '%s'" (file-name-nondirectory file) destination)))

;; Bind this function to a key in Dired mode
;;(define-key dired-mode-map (kbd "C-c m") 'my-dired-move-file-to-library)


(provide 'custom-defuns)
;;; custom-defuns.el ends here
