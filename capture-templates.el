(defun sangster/get-all-property-values (prop)
  "In the current buffer, return all the values for the given prop"
  (org-map-entries (lambda () (org-entry-get (point) prop)) (concat "+" prop "={.+}") 'file))


(defun sangster/find-jira-point ()

  (goto-char (point-min))
  (let ((title-marker (org-find-exact-headline-in-buffer "Jiras")))
    (if title-marker
        (goto-char title-marker)
      (progn (org-insert-heading)
             (insert "Jiras")
             (beginning-of-line))))
  
  (forward-char)
  
  (let* ((completions (append (sangster/get-all-property-values "ID") '("PVT-" "EDR-")))
         (jira-tag (completing-read "Jira: " completions nil nil))
         (jira-marker (org-find-entry-with-id jira-tag)))
    (if jira-marker ; if jira exists in the file
        ; then just go to it and add a new entry
        (progn (goto-char jira-marker)
               (forward-char)
               (org-end-of-subtree t))

      ; else, add the new heading for it and download its summary
      (org-insert-subheading t)
      (insert jira-tag)

      (lexical-let ((summary-marker (point-marker)))
        (org-entry-put (point) "ID" jira-tag)

        (jira/fetch-summary jira-tag ; grab summary for this jira
                            (lambda (summary)
                              (with-current-buffer (marker-buffer summary-marker)
                                (save-excursion
                                  (goto-char (marker-position summary-marker))
                                  (insert ": " summary))))))

      (org-end-of-subtree t))

    (save-excursion ; show jira summary we are capturing for
      (outline-up-heading 1 t)
      (message "%s" (buffer-substring (line-beginning-position) (line-end-position))))))

; --------------------

(add-to-list 'org-capture-templates
             '("w" "Work Notes" plain
               (file+function (concat datalinks-dir "work-notes.org") sangster/find-jira-point)
               "\n\n*** %T\n%?"))
