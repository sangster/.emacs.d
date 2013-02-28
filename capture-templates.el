(defun sangster/find-jira-point ()
  ; (debug)
  (goto-char (point-min))
  (let ((title-marker (org-find-exact-headline-in-buffer "Jiras")))
    (if title-marker
        (goto-char title-marker)
        (progn (org-insert-heading)
               (insert "Jiras")
               (beginning-of-line))))
  
  (forward-char)
  
  (let* ((jira-tag (completing-read "Jira: " '(("PVT-" 1) ("EDR-" 2)) nil nil))
         (jira-marker (org-find-exact-headline-in-buffer jira-tag)))
    (if jira-marker
        (progn (goto-char jira-marker)
               (forward-char)
               (org-end-of-subtree t))
      (org-insert-subheading t)
      (insert jira-tag)
      (newline))))

; --------------------

(setq org-capture-templates
      '( ("w" "Work Notes" entry
          (file+function (concat datalinks-dir "work-notes.org") sangster/find-jira-point)
          "*** %T\n\n%?")))
