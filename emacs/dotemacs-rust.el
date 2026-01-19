(use-package rust-mode
  :ensure t
  :mode ("\\.rs$" . rust-mode))

(use-package company
  :ensure t)

(use-package eglot
  :ensure t
  :config (add-to-list 'eglot-server-programs
                       `(rust-mode . ("rust-analyzer" :initializationOptions
                                     ( :procMacro (:enable t)
                                       :cargo ( :buildScripts (:enable t)
                                                :features "all"))))))

(provide 'dotemacs-rust)
