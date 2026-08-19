;;; custom-term-init.el --- Terminal  -*- lexical-binding: t -*-

;; eat replaces multi-term, which has been unmaintained since 2020.  It
;; is pure elisp, so unlike vterm there is nothing to compile, and it
;; handles colour and TUI programs far better than term.el.
(autoload 'eat "eat" "Start a terminal emulator in a buffer." t)

;; f5 opened a new multi-term; keep that, but hand back an existing
;; terminal when there is one, which is what I actually want most days.
(defun custom-terminal ()
  "Switch to a terminal buffer, creating one if needed.
With a prefix argument, always start a new terminal."
  (interactive)
  (let ((existing (seq-find (lambda (b)
			      (with-current-buffer b (derived-mode-p 'eat-mode)))
			    (buffer-list))))
    (if (and existing (not current-prefix-arg))
	(switch-to-buffer existing)
      (eat nil t))))

(provide 'custom-term-init)
;;; custom-term-init.el ends here
