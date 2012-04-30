(require 'cc-mode)

(c-add-style "kde-c" '("stroustrup"
		       (c-basic-offset . 4)
		       (c-offsets-alist
			(case-label . 0)
                        (inline-open . 0)
			(access-label . -)
			(label . 0)
			(statement-cont . c-lineup-math)
			)))

;(define-key c++-mode-map [(f6)] 'ff-find-other-file)
;(define-key c-mode-map [(f6)] 'ff-find-other-file)
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key [(f6)] 'ff-find-other-file)
            (c-set-style "kde-c")
            ))

(provide 'dotemacs-cpp)
