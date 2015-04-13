(setq-default make-backup-files nil)
(setq-default indent-tabs-mode nil)
(setq require-final-newline t)
(fset 'yes-or-no-p 'y-or-n-p)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

; UTF-8
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(use-package smart-tab
  :ensure t
  :config (global-smart-tab-mode 1))

(setq-default require-final-newline t)

(if (>= emacs-major-version 24)
    (progn
      (electric-pair-mode t)
      (electric-indent-mode t))
    ;; autopair mode
    (when (require 'autopair nil t)
      (autopair-global-mode)
      (setq autopair-autowrap t)
      (setq autopair-blink nil)))

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

(provide 'dotemacs-behavior)
