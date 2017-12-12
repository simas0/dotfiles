;; for building regular expressions
  (defun reb-query-replace-this-regxp (replace)
    "Uses the regexp built with re-builder to query the target buffer.
    This function must be run from within the re-builder buffer, not the target
    buffer.

    Argument REPLACE String used to replace the matched strings in the buffer. 
    Subexpression references can be used (\1, \2, etc)."
    (interactive "sReplace with: ")
    (if (eq major-mode 'reb-mode)
        (let ((reg (reb-read-regexp)))
          (select-window reb-target-window)
          (save-excursion
            (beginning-of-buffer)
            (query-replace-regexp reg replace)))
      (message "Not in a re-builder buffer!")
    )
  )

  (defun scroll-down-other-window ()
    (interactive)
    (other-window 1)
    (doc-view-scroll-down-or-previous-page)
    (other-window -1)
  )

  (defun scroll-up-other-window ()
    (interactive)
    (other-window 1)
    (doc-view-scroll-up-or-next-page)
    (other-window -1)
  )

  (defun page-down-other-window ()
    (interactive)
    (other-window 1)
    (doc-view-previous-page)
    (other-window -1)
  )

  (defun page-up-other-window ()
    (interactive)
    (other-window 1)
    (doc-view-next-page)
    (other-window -1)
  )

  (defun kill-buffer-in-other-window ()
    (interactive)
    (other-window 1)
    (kill-this-buffer)
    (other-window -1)
  )


;; functions to copy and paste from register
  (defun copy-to-register-1 ()
    "Copy current line or text selection to register 1.
  See also: `paste-from-register-1', `copy-to-register'."
    (interactive)
    (let* (
           (bds (get-selection-or-unit 'line ))
           (inputStr (elt bds 0) )
           (p1 (elt bds 1) )
           (p2 (elt bds 2) )
           )
      (copy-to-register ?1 p1 p2)
      (message "copied to register 1: 「%s」." inputStr)
  ))

  (defun paste-from-register-1 ()
    "paste text from register 1.
  See also: `copy-to-register-1', `insert-register'."
    (interactive)
    (insert-register ?1 t))

;; switch to next/previous user buffer
  (defun next-user-buffer ()
    "Switch to the next user buffer. User buffers are those whose name does not start with *."
    (interactive)
    (next-buffer)
    (let ((i 0))
      (while (and (string-equal "*" (substring (buffer-name) 0 1)) (< i 20))
        (setq i (1+ i)) (next-buffer))))

  (defun previous-user-buffer ()
    "Switch to the previous user buffer. User buffers are those whose name does not start with *."
    (interactive)
    (previous-buffer)
    (let ((i 0))
      (while (and (string-equal "*" (substring (buffer-name) 0 1)) (< i 20))
        (setq i (1+ i)) (previous-buffer) )))


