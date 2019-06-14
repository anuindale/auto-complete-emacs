(define-minor-mode myauto-complete-mode
  "Myauto-complete mode."
  :lighter "Myauto-complete"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map (kbd "<return>") 'insert-exit)
	    (define-key map (kbd "C-g") 'just-exit)
	    (define-key map (kbd "C-q") 'jump-backward)
	    (define-key map (kbd "C-w") 'jump-forward)
	    (define-key map (kbd "<left>") 'move-mark-left)
	    (define-key map (kbd "<right>") 'move-mark-right)	  
	    map)  

  (setq this-point (point))  
  (setq this-word (current-word))
  (setq word-length (length this-word)) 

  ;;(setq buffer-read-only 1)  
  (transient-mark-mode 1)
  (backward-char word-length)
  (set-mark-command nil)
  (forward-char word-length)

  (defun move-mark-left ()
    (interactive)
    (set-mark (- (mark) 1))
    ;;(message (concat (number-to-string (mark)) " " (number-to-string (point)) ))
    ;;(message (buffer-substring (mark) (point)) )
    (setq this-word (buffer-substring (mark) (point)))        
    (setq word-length (- (point) (mark)) )   
    ;;(message (number-to-string word-length))
    )

  (defun move-mark-right ()
    (interactive)
    (set-mark (+ (mark) 1))
    (setq this-word (buffer-substring (mark) (point)))        
    (setq word-length (- (point) (mark)) )   	
    )

  
  (defun where-backward (what)
    (interactive "sWhat: ")
    (save-excursion
      (search-backward-regexp what)
      (point)
      )
    )

  (defun current-word()
    (interactive)
    (setq beginning-point (1+ (where-backward "[ \$\n,.()]")))
    (buffer-substring beginning-point (point))
    )  


  (defun jump-backward ()
    (interactive)
    (search-backward this-word)
    (search-backward this-word)
    (set-mark-command nil)
    (forward-char word-length)
    )

  (defun jump-forward ()
    (interactive)
    (search-forward this-word)
    (backward-char word-length)
    (set-mark-command nil)
    (forward-char word-length)
    )

  (defun insert-exit ()
    (interactive)
    ;;(setq buffer-read-only nil)    
    (kill-ring-save (mark) (point))
    (deactivate-mark)    
    (goto-char this-point)  
    (delete-backward-char word-length)
    ;;(message (word-length))
    (yank)
    (myauto-complete-mode -1)
    )

  (defun just-exit ()
    (interactive)
    ;;(setq buffer-read-only nil)  
    (goto-char this-point)
    (deactivate-mark)
    (myauto-complete-mode -1)
    )  
  
  
  (provide 'myauto-complete-mode)
  )
