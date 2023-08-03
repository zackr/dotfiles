(require 'package)
;(setq package-archives '(("melpa" . "http://melpa.org/packages/")
;                         ("marmalade" . "https://marmalade-repo.org/packages/")
;                         ("melpa-stable" . "http://stable.melpa.org/packages/")
;                         ("gnu" . "http://elpa.gnu.org/packages/")
                                        ;                         ))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless package-archive-contents (package-refresh-contents))

(let ((pkg 'use-package))
  (unless (package-installed-p pkg)
    (package-install pkg)))

(require 'use-package)

(use-package auto-package-update
   :ensure t
   :config
   (setq auto-package-update-delete-old-versions t
         auto-package-update-interval 4)
   (auto-package-update-maybe))

(provide 'dotemacs-package)
