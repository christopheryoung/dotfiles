;;; custom-avy.el --- Jumping around with avy  -*- lexical-binding: t -*-

;; Replaces ace-jump-mode, unmaintained since 2014.  C-o keeps working
;; the way it always has, including the prefix argument submodes that
;; ace-jump-mode-submode-list used to provide:
;;
;;   C-o          jump to a word starting with the character you type
;;   C-u C-o      jump to any occurrence of the character you type
;;   C-u C-u C-o  jump to a line

(require 'avy)

;; ace-jump only ever offered candidates in the current window.  avy
;; defaults to every window in the frame, which would send point into a
;; neighbouring split, so keep the old scope.
(setq avy-all-windows nil)

;; was ace-jump-mode-case-fold
(setq avy-case-fold-search t)

(defvar custom-avy-submode-list
  '(avy-goto-word-1
    avy-goto-char
    avy-goto-line)
  "Jump commands `custom-avy-jump' selects between by prefix argument.
Mirrors the old `ace-jump-mode-submode-list'.")

(defun custom-avy-jump (prefix)
  "Jump with avy, picking a submode from the PREFIX argument.
No prefix jumps to a word, one \\[universal-argument] to a
character, two to a line."
  (interactive "p")
  (let* ((index (min (/ prefix 4)
		     (1- (length custom-avy-submode-list))))
	 (command (nth index custom-avy-submode-list))
	 ;; The prefix selected the submode; don't let it also reach
	 ;; the submode, where avy reads it as a window-scope flip.
	 (current-prefix-arg nil))
    (call-interactively command)))

(provide 'custom-avy)
;;; custom-avy.el ends here
