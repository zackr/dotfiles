;;; dotemacs-look.el --- UI and visual configuration

;;; Theme
(use-package solarized-theme
  :ensure t
  :config (load-theme 'solarized-dark t))

;;; Font
(defun zk/pick-font ()
  "Select a font appropriate for the current system and display."
  (cond ((eq system-type 'windows-nt) "Consolas-11")
        ((eq system-type 'darwin)
         (if (> (x-display-pixel-width) 2000) "Menlo-19" "Menlo-12"))
        (t
         (if (> (x-display-pixel-width) 2000) "DejaVu Sans Mono-16" "DejaVu Sans Mono-9"))))

;;; Frame setup — runs for every new graphical frame (including emacsclient)
(defun zk/setup-frame (frame)
  "Apply look settings to FRAME when it is graphical."
  (when (display-graphic-p frame)
    (let ((font (zk/pick-font))
          (width (or (cdr (assq 'width default-frame-alist)) 110))
          (height (or (cdr (assq 'height default-frame-alist)) 35)))
      (set-frame-font font nil (list frame))
      (set-frame-size frame width height)
      (add-to-list 'default-frame-alist `(font . ,font)))
    (with-selected-frame frame
      (tool-bar-mode -1)
      (menu-bar-mode -1))))

(add-hook 'after-make-frame-functions #'zk/setup-frame)

;; Non-daemon: apply to the initial frame immediately
(when (display-graphic-p)
  (zk/setup-frame (selected-frame)))

;;; Frame
(setq frame-inhibit-implied-resize t)
(setq default-frame-alist '((width . 110)
                             (height . 35)
                             (tool-bar-lines . 0)
                             (menu-bar-lines . 0)))
(setq initial-frame-alist default-frame-alist)

;;; Chrome
(blink-cursor-mode -1)
(show-paren-mode t)

;;; Title bar
(setq frame-title-format '("%b [%+]"))
(setq icon-title-format
      (list (user-login-name) "@" (system-name) " : "
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))
            " [%+]"))

;;; Mode line
(which-function-mode t)
(line-number-mode t)
(column-number-mode t)

;;; Startup
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;;; Editor visuals
(setq-default show-trailing-whitespace 1)

(provide 'dotemacs-look)
