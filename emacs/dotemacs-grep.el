(defadvice rgrep (around rgrep-init)
  "Init grep defaults before calling rgrep non-interactively."
  (when (not (called-interactively-p))
    (grep-compute-defaults))
  ad-do-it)

(ad-activate 'rgrep)

;(rgrep "igrep" "*" default-directory)

(define-key global-map [(f2)] 'lgrep)
(define-key global-map [(shift f2)] 'rgrep)
(define-key global-map [(f12)] 'rgrep)

(provide 'dotemacs-grep)
