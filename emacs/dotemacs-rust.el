(use-package rust-mode
  :ensure t
  :mode ("\\.rs$" . rust-mode))

(use-package company
  :ensure t)

(use-package racer
  :ensure t)

(setq smart-tab-completion-functions-alist
      '((emacs-lisp-mode . lisp-complete-symbol)
        (text-mode . dabbrev-completion)
        (rust-mode . company-indent-or-complete-common)))

(setq racer-cmd "/Users/zack/.cargo/bin/racer")
(setq racer-rust-src-path "/Users/zack/src/rust/rust/src")

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
;(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

(provide 'dotemacs-rust)
