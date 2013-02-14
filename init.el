(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))


;; Load path etc.
(setq dotfiles-dir (file-name-directory
                     (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path (concat dotfiles-dir "starter-kit"))

(load-file (concat dotfiles-dir "elpa.el"))
(load-file (concat dotfiles-dir "startup-packages.el"))
(load-file (concat dotfiles-dir "auto-complete.el"))


;; backport some functionality to Emacs 22 if needed
(require 'dominating-file)


(load-file (concat dotfiles-dir "starter-kit.el"))
(load-file (concat dotfiles-dir "system-specific.el"))
(load-file (concat dotfiles-dir "languages.el"))

(setq scss-compile-at-save nil)

(defun ruby-replace-hash-rocket ()
  "Replace :symbol => value with symbol: value"
  (interactive)
  (query-replace-regexp ":\\(\\w+\\) =>" "\\1:"))

;;
;; org-mode
;;
(setq org-agenda-files "~/.emacs.d/org-agenda-files")
(setq org-default-notes-file "~/docs/text/datalinks/notes.org")
(define-key global-map "\C-cc" 'org-capture)


(load "journal")
(if (file-directory-p "~/docs/text/datalinks/journal/")
    (setq-default journal-dir "~/docs/text/datalinks/journal/"))

