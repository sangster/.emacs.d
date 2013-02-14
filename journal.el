;;Since list people have asked for this a couple times, I thought
;; code below belongs in a more public place.  So here it is.
;;Free, GPL'd code for whoever.
;;Enjoy,
;;ken fisler
;;
;; To specify the directory in which to put your journal entries,
;; put the following into your ~/.emacs, specifying the directory:
;;(load "journal")
;;(if (file-directory-p "~/personal/diary/")
;;       (setq-default journal-dir "~/personal/diary/")
;;)
;;
;; Because "format-time-string" isn't a builtin function until a later version
;; of emacs, the below won't work with this version (19.22.1).
;;
;; Put this entire file into ".../site-lisp" or somewhere in emacs'
;; path.

(defun journal (filename)
  "Open ORG file named after today's date, format YYYY-MM-DD-Day.html,
in subdirectory named in variable journal-dir, set in ~/.emacs,
else in $HOME."
  (interactive
   (progn
     (setq default-directory journal-dir)
     (setq filename (concat (format-time-string "%Y-%m-%d-%a" nil) ".org"))
     (list (read-file-name
            "Open journal file: " journal-dir filename nil filename))))
  (find-file filename))



(defun now ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%-I:%M %p")))


(defun today ()
  "Insert string for today's date nicely formatted in American style,
e.g. Sunday, September 17, 2000."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%A, %B %e, %Y")))


;; Get the time exactly 24 hours from now.  This produces three
;; integers, like the current-time function.  Each integers is 16
;; bits.  The first and second together are the count of seconds since
;; Jan 1, 1970.  When the second word increments above 6535, it resets
;; to zero and carries 1 to the high word. The third integer is a
;; count of milliseconds (on machines which can produce this
;; granularity).  The math in the defun below, then, is to accommodate
;; the way the current-time variable is structured.  That is, the
;; number of seconds in a day is 86400.  In effect, we add 65536 (= 1
;; in the high word) + 20864 to the current-time.  However, if 20864
;; is too big for the low word, if it would create a sum larger than
;; 65535, then we "add" 2 to the high word and subtract 44672 from the
;; low word.


(defun tomorrow-time ()
  "*Provide the date/time 24 hours from the time now in the same format as current-time."
  (setq
   now-time (current-time)   ; get the time now
   hi (car now-time)         ; save off the high word
   lo (car (cdr now-time))   ; save off the low word
   msecs (nth 2 now-time)    ; save off the milliseconds
   )

  (if (> lo 44671)           ; If the low word is too big for adding to,
      (setq hi (+ hi 2)      ; carry 2 to the high word and subtract
            lo (- lo 44672)) ; from the low,  
    ))
