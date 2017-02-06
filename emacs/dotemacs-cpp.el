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

(require 'compile)
(add-hook 'c-mode-common-hook
          (lambda ()
            (unless (file-exists-p "Makefile")
              (set (make-local-variable 'compile-command)
                   (format "make -C /Users/zack/src/vmware/git/vmcore-main mksReplay"
                           )))))

(defun compile-mks-replay ()
  (interactive)
  (set (make-local-variable 'compile-command)
       (format "make -C /Users/zack/src/vmware/git/vmcore-main mksReplay"))
  (let ((default-directory "/Users/zack/src/vmware/git/vmcore-main"))
    (message default-directory)
    (call-interactively #'compile)))

(provide 'dotemacs-cpp)
