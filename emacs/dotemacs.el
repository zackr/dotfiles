(add-to-list 'load-path (concat sdk-directory "emacs"))
(setq custom-file (concat sdk-directory "emacs/dotemacs-custom.el"))

(require 'dotemacs-look)
(require 'dotemacs-behavior)
(require 'dotemacs-grep)
(require 'dotemacs-dev)
(require 'dotemacs-cpp)
(require 'dotemacs-js)
(require 'dotemacs-coffee)
(require 'dotemacs-python)

(load custom-file)
