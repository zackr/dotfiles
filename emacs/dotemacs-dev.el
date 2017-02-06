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

(provide 'dotemacs-dev)
