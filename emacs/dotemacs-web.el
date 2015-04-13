(use-package web-mode
  :ensure t
  :mode (("\\.html$" . web-mode)
         ("\\.jsx$" . web-mode)
         ("\\.json$" . web-mode)
         ("\\.js$" . web-mode)))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

(use-package jade-mode
  :ensure t
  :mode ("\\.jade$" . jade-mode))

(provide 'dotemacs-web)
