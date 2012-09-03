;; You can keep system- or user-specific customizations here

(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config   (concat dotfiles-dir user-login-name ".el")
      user-specific-dir      (concat dotfiles-dir user-login-name))

(add-to-list 'load-path user-specific-dir)


(if (file-exists-p system-specific-config) (load system-specific-config))

(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))

(if (file-exists-p user-specific-config) (load user-specific-config))

