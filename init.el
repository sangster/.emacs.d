
;; Load path etc.
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path (concat dotfiles-dir "/starter-kit"))

(load-file (concat dotfiles-dir "elpa.el"))
(load-file (concat dotfiles-dir "startup-packages.el"))
(load-file (concat dotfiles-dir "auto-complete.el"))


;; backport some functionality to Emacs 22 if needed
(require 'dominating-file)

(load-file (concat dotfiles-dir "starter-kit.el"))
(load-file (concat dotfiles-dir "system-specific.el"))

(setq scss-compile-at-save nil)


;; org-mode
(setq org-agenda-files (quote ("~/docs/text/org")))

(defun ruby-replace-hash-rocket ()
  "Replace :symbol => value with symbol: value"
  (interactive)
  (query-replace-regexp ":\\(\\w+\\) =>" "\\1:"))

