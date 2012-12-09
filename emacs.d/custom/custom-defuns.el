
(require 'cl)

;; M-q is very handy for formatting text, but sometimes you want to remove the
;; formatting . . .
(defun remove-line-breaks ()
  "Remove line endings in a paragraph."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

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

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR. All credit to Steve Yegge"
  (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))

    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn
        (copy-file filename newname 1)
        (delete-file filename)
        (set-visited-file-name newname)
        (set-buffer-modified-p nil) t))))

;; indent entire buffer
(defun indent-buffer ()
  "Indent the buffer"
  (interactive)
  (save-excursion
    (delete-trailing-whitespace)
    (indent-region (point-min) (point-max) nil)
    (untabify (point-min) (point-max))))

(setq cheatsheets '(("Clojure" "http://jafingerhut.github.com/cheatsheet-clj-1.3/cheatsheet-tiptip-cdocs-summary.html")
                    ("ClojureDocs" "http://clojuredocs.org/")
                    ("Elisp Cookbook" "http://www.emacswiki.org/emacs/ElispCookbook")
                    ("HTML5" "http://www.nihilogic.dk/labs/canvas_sheet/HTML5_Canvas_Cheat_Sheet.pdf")
                    ("Magit" "http://cheat.errtheblog.com/s/magit/")
                    ("Paredit" "http://www.emacswiki.org/emacs/PareditCheatsheet")
                    ("ZenCoding" "https://github.com/rooney/zencoding")
                    ))

(defun search-interwebs(query)
  (interactive "sSearch for: ")
  (browse-url (concat "https://duckduckgo.com/?q=" query)))

(defun get-cheatsheet ()
  (interactive)
  (setq choice (ido-completing-read "Cheatsheet: " (maplist 'caar cheatsheets)))
  (when choice
    (let ((cheatsheet-url (car (cdr (assoc choice cheatsheets))))) ;; Seriously? Gotta learn elisp!
      (browse-url cheatsheet-url))))

;; Make it easy to get to my worklog
(defun open-worklog ()
  (interactive)
  (find-file "~/Dropbox/cy/notes/worklog.txt"))

(defun worklog-date-stamp ()
  (interactive)
  (insert (format-time-string "%m/%d/%Y ")))




(provide 'custom-defuns)
