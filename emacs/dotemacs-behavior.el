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

(add-to-list 'load-path (concat sdk-directory "emacs/libs/smart-tab"))
(require 'smart-tab)
(global-smart-tab-mode 1)

(setq-default require-final-newline t)

(provide 'dotemacs-behavior)
