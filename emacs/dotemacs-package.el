(require 'package)
(setq package-archives
      '(("gnu"       . "http://elpa.gnu.org/packages/")
        ("original"  . "http://tromey.com/elpa")
        ("org"       . "http://orgmode.org/elpa/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa"     . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(unless package-archive-contents (package-refresh-contents))

(let ((pkg 'use-package))
  (unless (package-installed-p pkg)
    (package-install pkg)))

(require 'use-package)

(provide 'dotemacs-package)
