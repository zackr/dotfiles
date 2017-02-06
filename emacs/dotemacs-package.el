(require 'package)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
;                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ))

(package-initialize)

(unless package-archive-contents (package-refresh-contents))

(let ((pkg 'use-package))
  (unless (package-installed-p pkg)
    (package-install pkg)))

(require 'use-package)

(provide 'dotemacs-package)
