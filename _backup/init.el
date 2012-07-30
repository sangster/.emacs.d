;; -*- mode: emacs-lisp -*-


;; Line Numbers
(global-linum-mode 1)
(setq linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

;; Backup files
    (setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))


;; Addons
(load "~/.emacs.d/addons/haml-mode.el")

(load "~/.emacs.d/addons/rspec-mode.el")
(require 'rspec-mode)

(add-to-list 'load-path "~/.emacs.d/addons/feature-mode")
(setq feature-default-language "fi")
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

