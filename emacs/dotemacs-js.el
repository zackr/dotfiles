(add-to-list 'load-path (concat sdk-directory "emacs/libs/js2-mode"))
(require 'js2-mode)

;(add-to-list 'grep-files-aliases (cons "js" "*.js *.json"))


(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

(provide 'dotemacs-js)
