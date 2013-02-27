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


(load-file (concat dotfiles-dir "starter-kit.el"))
(load-file (concat dotfiles-dir "system-specific.el"))
(load-file (concat dotfiles-dir "languages.el"))
(load-file (concat dotfiles-dir "capture-templates.el"))

(setq scss-compile-at-save nil)

(defun ruby-replace-hash-rocket ()
  "Replace :symbol => value with symbol: value"
  (interactive)
  (query-replace-regexp ":\\(\\w+\\) =>" "\\1:"))

;;
;; org-mode
;;
(setq datalinks-dir "~/docs/text/datalinks/"
      org-agenda-files "~/.emacs.d/org-agenda-files"
      org-default-notes-file (concat datalinks-dir "notes.org"))

(define-key global-map "\C-cc" 'org-capture)


(load "journal")
(if (file-directory-p (concat datalinks-dir "journal/"))
    (setq-default journal-dir (concat datalinks-dir "journal/")))

