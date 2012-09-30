(setq languages-dir (concat dotfiles-dir "languages/"))


(add-hook 'haml-mode-hook
  (lambda () (load-file (concat languages-dir "haml.el"))))

(add-hook 'c-mode-hook
  (lambda () (load-file (concat languages-dir "c.el"))))
