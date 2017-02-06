(use-package solarized-theme
  :ensure t
  :config (load-theme 'solarized-dark t))

(cond ((eq system-type 'window-nt) (set-default-font "Consolas-11"))
      ((eq system-type 'darwin)
       (cond ((> (x-display-pixel-width) 2000) (set-default-font "Menlo-19"))
             (t (set-default-font "Menlo-12"))))
      (t (set-default-font "DejaVu Sans Mono-9")))

(setq frame-title-format
  (list
   "%b"
    " [%+]"
    ))

(setq icon-title-format
  (list
   (user-login-name)
   "@"
    (system-name)
    " : "
    '(buffer-file-name "%f" (dired-directory dired-directory "%b"))
    " [%+]"
    ))

(show-paren-mode t) ;; highlight matching parens
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(which-function-mode t)
(line-number-mode t)		; always show the line number
(column-number-mode t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq-default show-trailing-whitespace 1)

(provide 'dotemacs-look)
