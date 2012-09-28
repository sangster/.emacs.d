(setq languages-dir (concat dotfiles-dir "languages/"))

(message "a b c d")

(add-hook 'haml-mode-hook
  (lambda () (load-file (concat languages-dir "haml.el"))))

(add-hook 'c-mode-common-hook
  (lambda () (load-file (concat languages-dir "c.el")))
