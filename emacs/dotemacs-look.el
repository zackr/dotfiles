(if (>= emacs-major-version 24)
    (progn
      (add-to-list 'custom-theme-load-path
                   (concat sdk-directory "emacs/libs/emacs-color-theme-solarized"))
      (load-theme 'solarized-dark t))
  (progn
    (require 'color-theme)
    (color-theme-initialize)
    (color-theme-billw)))

(if (eq system-type 'windows-nt)
    (set-default-font "Consolas-11")
  (set-default-font "DejaVu Sans Mono-9"))
;(set-default-font "Inconsolata-11")


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

(provide 'dotemacs-look)
