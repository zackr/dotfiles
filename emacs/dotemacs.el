(add-to-list 'load-path (concat sdk-directory "emacs"))
(setq custom-file (concat sdk-directory "emacs/dotemacs-custom.el"))

(require 'dotemacs-package)
(require 'dotemacs-look)
(require 'dotemacs-behavior)
(require 'dotemacs-grep)
(require 'dotemacs-dev)
(require 'dotemacs-cpp)
(require 'dotemacs-js)
(require 'dotemacs-python)
(require 'dotemacs-web)
(require 'dotemacs-rust)
(require 'dotemacs-swift)

(load custom-file)
