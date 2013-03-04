(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq org-capture-templates (list))

;; Load path etc. ------------------------------------------------------------------------
(setq dotfiles-dir (file-name-directory
                     (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path (concat dotfiles-dir "starter-kit"))

(dolist (filename '("elpa" "startup-packages" "auto-complete" "starter-kit" "journal"
                    "system-specific" "languages" "jira" "capture-templates"))
  (load (concat dotfiles-dir filename)))
;; ---------------------------------------------------------------------------------------

(setq scss-compile-at-save nil)

(defun ruby-replace-hash-rocket ()
  "Replace :symbol => value with symbol: value"
  (interactive)
  (query-replace-regexp ":\\(\\w+\\) =>" "\\1:"))

;; org-mode ------------------------------------------------------------------------------
(setq datalinks-dir "~/docs/text/datalinks/"
      org-agenda-files "~/.emacs.d/org-agenda-files"
      org-default-notes-file (concat datalinks-dir "notes.org"))

(define-key global-map "\C-cc" 'org-capture)

;; Capture
(add-to-list 'org-capture-templates '("t" "todo" entry (file (concat datalinks-dir "todo.org"))
                                      "* TODO %?\n%U\n%a\n"))

;; Journal
(if (file-directory-p (concat datalinks-dir "journal/"))
    (setq-default journal-dir (concat datalinks-dir "journal/")))


;; ---------------------------------------------------------------------------------------
