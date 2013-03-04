(defun sangster/find-jira-point ()

  (goto-char (point-min))
  (let ((title-marker (org-find-exact-headline-in-buffer "Jiras")))
    (if title-marker
        (goto-char title-marker)
      (progn (org-insert-heading)
             (insert "Jiras")
             (beginning-of-line))))
  
  (forward-char)
  
  (let* ((jira-tag (completing-read "Jira: " '(("PVT-" 1) ("EDR-" 2)) nil nil))
         (jira-marker (org-find-entry-with-id jira-tag)))
    (if jira-marker
        (progn (goto-char jira-marker)
               (forward-char)
               (org-end-of-subtree t))

      (org-insert-subheading t)
      (insert jira-tag)

      (lexical-let ((summary-marker (point-marker)))
        (org-entry-put (point) "ID" jira-tag)
      
        (jira/fetch-summary jira-tag
                            (lambda (summary)
                              (with-current-buffer (marker-buffer summary-marker)
                                (save-excursion
                                  (goto-char (marker-position summary-marker))
                                  (insert ": " summary))))))
      
      (org-end-of-subtree t))))

; --------------------

(add-to-list 'org-capture-templates
             '("w" "Work Notes" plain
               (file+function (concat datalinks-dir "work-notes.org") sangster/find-jira-point)
               "\n\n*** %T\n%?"))
