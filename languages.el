(setq languages-dir (concat dotfiles-dir "languages/"))


(add-hook 'haml-mode-hook
  (lambda () (load-file (concat languages-dir "haml.el"))))

(add-hook 'c-mode-hook
  (lambda () (load-file (concat languages-dir "c.el"))))

(add-hook 'scss-mode-hook
  (lambda () (load-file (concat languages-dir "scss.el"))))

(add-hook 'coffee-mode-hook
  (lambda () (load-file (concat languages-dir "coffee.el"))))
