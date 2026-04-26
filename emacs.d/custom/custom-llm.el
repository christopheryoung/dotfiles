;;; custom-llm.el --- LLM integration via gptel -*- lexical-binding: t -*-

;; Install gptel via straight.el (self-contained, only on personal machine)
(straight-use-package 'gptel)
(require 'gptel)

;; --- Backend configuration ---

;; Claude (Anthropic) - default backend
;; Auth-source entry: machine api.anthropic.com login apikey password <key>
;; gptel's built-in model list updates with the package;
;; switch to Opus or other models via C-c g m.
(setq gptel-model 'claude-sonnet-4-20250514)
(setq gptel-backend
      (gptel-make-anthropic "Claude"
        :stream t
        :key #'gptel-api-key-from-auth-source))

;; OpenAI backend (switch to via C-c g m)
;; Auth-source entry: machine api.openai.com login apikey password <key>
(gptel-make-openai "OpenAI"
  :stream t
  :key #'gptel-api-key-from-auth-source
  :models '(gpt-4o gpt-4o-mini o3-mini))

;; Ollama backend (local models, no API key needed)
(gptel-make-ollama "Ollama"
  :stream t
  :host "localhost:11434"
  :models '(llama3.1:8b))

;; --- Org-mode as default chat format ---
(setq gptel-default-mode 'org-mode)

;; --- Keybindings under C-c g ---
(global-set-key (kbd "C-c g g") 'gptel)
(global-set-key (kbd "C-c g s") 'gptel-send)
(global-set-key (kbd "C-c g m") 'gptel-menu)
(global-set-key (kbd "C-c g r") 'gptel-rewrite)
(global-set-key (kbd "C-c g a") 'gptel-add)

;; --- Proofreading via LLM ---

(defun custom-llm--proofread-prompt (filename)
  "Return the system prompt for proofreading.
FILENAME is used to instruct the model on output format."
  (format
   "You are a proofreader. The user will send you the contents \
of a file. Each line is prefixed with its line number followed \
by a colon (e.g. \"42: some text\"). Identify typos, spelling \
mistakes, grammatical errors, and stylistic infelicities. For \
each issue, output exactly one line in this format:

%s:LINE_NUMBER: DESCRIPTION

Use the line number shown at the start of the line where the \
issue occurs. DESCRIPTION is a brief explanation of the problem \
and a suggested fix. Output nothing else—no preamble, no \
summary. If there are no issues, output the single line: \
No issues found."
   filename))

(defun custom-llm--proofread-callback
    (response _info)
  "Handle the proofreading RESPONSE from gptel.
_INFO is ignored."
  (if (not response)
      (message "Proofread: no response from LLM.")
    (let ((buf (get-buffer-create "*Proofread*")))
      (with-current-buffer buf
        (let ((inhibit-read-only t))
          (erase-buffer)
          (insert response)
          (goto-char (point-min))
          (compilation-mode)))
      (display-buffer buf)
      (message "Proofreading complete."))))

(defun custom-llm--numbered-buffer-contents ()
  "Return the current buffer contents with line numbers prepended."
  (let ((lines (split-string
                (buffer-substring-no-properties
                 (point-min) (point-max))
                "\n"))
        (n 1)
        result)
    (dolist (line lines)
      (push (format "%d: %s" n line) result)
      (setq n (1+ n)))
    (string-join (nreverse result) "\n")))

(defun custom-llm-proofread-buffer ()
  "Send the current buffer to an LLM for proofreading.
Results appear in a *Proofread* buffer in compilation mode."
  (interactive)
  (let ((filename (or (buffer-file-name)
                      (buffer-name)))
        (content (custom-llm--numbered-buffer-contents)))
    (message "Proofreading %s..." filename)
    (gptel-request content
      :system (custom-llm--proofread-prompt filename)
      :callback #'custom-llm--proofread-callback)))

(global-set-key (kbd "C-c g p") 'custom-llm-proofread-buffer)

(provide 'custom-llm)
;;; custom-llm.el ends here
