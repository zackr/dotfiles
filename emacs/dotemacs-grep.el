(defadvice rgrep (around rgrep-init)
  "Init grep defaults before calling rgrep non-interactively."
  (when (not (called-interactively-p))
    (grep-compute-defaults))
  ad-do-it)

(ad-activate 'rgrep)

;(rgrep "igrep" "*" default-directory)

(use-package ag
  :ensure t)
(define-key global-map [(f2)] 'ag)
(define-key global-map [(shift f2)] 'rgrep)
(define-key global-map [(f12)] 'rgrep)

(provide 'dotemacs-grep)
