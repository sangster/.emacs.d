
(defgroup jira nil "Customizations for our Atlassian Jira tool.")

(defcustom jira-username nil
  "Your login username for Jira."
  :group 'jira
  :type 'string )

(defcustom jira-save-password nil
  "Save password in plain-text cache. Warning: it may be unwise to save your password in plain-text."
  :group 'jira
  :type 'boolean)

(defcustom jira-password nil
  "Your login password for Jira. Leave empty to prompt."
  :group 'jira
  :type 'string)


(defun jira/fetch-summary (jira-tag callback)
  "Downloads the summary for the given Jira and passes it to the given callback, asynchronously."
  
  (unless (functionp callback)
    (error "Must provide a callback function to take the summary string."))
  (unless jira-username
    (custom-set-variables '(jira-username (read-from-minibuffer "Jira Username: "))))

 
  (let (passwd)
    (if jira-password
        (setq passwd jira-password)  
      (setq passwd (read-passwd "Jira Password: ")))
    
    (if jira-save-password
        (custom-set-variables '(jira-password passwd)))

    (lexical-let ((callback callback))
      (let ((url-request-extra-headers
             `(("Authorization" . ,(concat "Basic "
                                           (base64-encode-string (concat jira-username ":" passwd)))))))
        (url-retrieve (concat "http://jira/rest/api/2/issue/" jira-tag)
                    (lambda (&rest args)
                      (re-search-forward "\"summary\":\"\\([^\"]+\\)\"")
                      (funcall callback (match-string 1))))))))


; (jira/fetch-summary "PVT-333" (lambda (str) (message "\"%s\"" str)))


