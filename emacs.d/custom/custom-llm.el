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

(provide 'custom-llm)
;;; custom-llm.el ends here
