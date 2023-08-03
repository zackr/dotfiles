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

(use-package p4
  :ensure t
  :config
  (setq p4-executable "/build/apps/bin/p4"))

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

(provide 'dotemacs-dev)
