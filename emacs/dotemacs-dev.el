(defun match-paren ()
  "Go to the matching parenthesis if on parenthesis otherwise do nothing."
  (interactive)
  (cond ((looking-at "[ \t]*[\({]") (forward-sexp) (backward-char))
	((looking-at "[\)}]") (forward-char) (backward-sexp))))

;(define-key global-map [(control j)] 'goto-line)
(global-set-key [(control %)] 'match-paren)

(define-key global-map [(shift f5)] 'makeclean)
(define-key global-map [(f5)] 'make)

;; Navigate using subwords for CamelCaseIdentifiers
(global-subword-mode 1)

;(use-package p4
;  :ensure t
;  :config
;  (setq p4-executable "/build/apps/bin/p4"))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package yaml-mode
  :defer t
  :mode ("\\.yaml\\'" "\\.yml\\'")
  )

(use-package dockerfile-mode
  :defer t
  :mode ("Dockerfile\\'" . dockerfile-mode)
  )

(use-package hcl-mode
  :defer t
  :mode ("\\.hcl\\'" . hcl-mode)
  )

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

;(use-package lsp-mode
;  :ensure t
;  :init
;  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;  (setq lsp-keymap-prefix "C-c l")
;  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;         (c-mode . lsp)
;         ;; if you want which-key integration
;         (lsp-mode . lsp-enable-which-key-integration))
;  :commands lsp)

;; optionally
;(use-package lsp-ui 
;  :ensure t
;  :commands lsp-ui-mode)
;; if you are helm user
;(use-package helm-lsp 
;  :ensure t
;  :commands helm-lsp-workspace-symbol)
;; if you are ivy user
;(use-package lsp-ivy 
;  :ensure t
;  :commands lsp-ivy-workspace-symbol)
;(use-package lsp-treemacs 
;  :ensure t
;  :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(provide 'dotemacs-dev)
