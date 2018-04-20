;; windows navigation
  (define-key key-translation-map (kbd "M-i") (kbd "C-p"))
  (define-key key-translation-map (kbd "M-k") (kbd "C-n"))
  (define-key key-translation-map (kbd "M-j") (kbd "C-b"))
  (define-key key-translation-map (kbd "M-l") (kbd "C-f"))
  (define-key key-translation-map (kbd "C-f") (kbd "M-l"))
  (define-key key-translation-map (kbd "M-u") (kbd "C-d"))

;; find files
  (global-set-key (kbd "C-x M-l") 'find-file)

;; force to get used to C-g
  (global-unset-key (kbd "ESC ESC ESC"))

;; set search shotcuts
  (global-unset-key (kbd "M-l"))
  (global-set-key (kbd "M-l") 'isearch-forward)
  (define-key (current-global-map) [remap search-forward] 'isearch-forward)

;; improve isearch behaviour
  (defun windows-isearch-hook ()
    (define-key isearch-mode-map (kbd "M-l") 'isearch-repeat-forward)
    (define-key isearch-mode-map (kbd "RET") 'isearch-exit)
    (define-key isearch-mode-map (kbd "<escape>") 'isearch-cancel)
    (define-key isearch-mode-map (kbd "C-S-f") 'isearch-repeat-backward)
    (define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat)
    (define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance))
  (add-hook 'isearch-mode-hook 'windows-isearch-hook)

;; turn f3 into next search
  (global-unset-key (kbd "<f3>"))
  (define-key isearch-mode-map (kbd "<f3>") 'isearch-repeat-forward)
  (define-key isearch-mode-map (kbd "S-<f3>") 'isearch-repeat-backward)

;; need to call isearch-forward twice (fix this later)
  (global-set-key (kbd "<f3>") 'isearch-forward)
  (global-set-key (kbd "S-<f3>") 'isearch-backward)

;;(define-key isearch-mode-map (kbd "<ESC>-<ESC>") 'isearch-done)

;; set yank-pop
  (global-set-key (kbd "C-y") 'yank-pop)

;; fix ç
  (global-unset-key (kbd "ć"))
  (global-set-key (kbd "ć") (lambda () (interactive) (ucs-insert 231)))

;; move a paragraph but independent of the mode you are in.
  (defun forward-block ()
    "Move cursor forward to next occurrence of double newline char.
  In most major modes, this is the same as `forward-paragraph', however,
  this function behaves the same in any mode.
  forward-paragraph is mode dependent, because it depends on
  syntax table that has different meaning for “paragraph” depending on mode."
    (interactive)
    (skip-chars-forward "\n")
    (when (not (search-forward-regexp "\n[[:blank:]]*\n" nil t))
      (goto-char (point-max)) ) )

  (defun backward-block ()
    "Move cursor backward to previous occurrence of double newline char.
     See: `forward-block'"
    (interactive)
    (skip-chars-backward "\n")
    (when (not (search-backward-regexp "\n[[:blank:]]*\n" nil t))
      (goto-char (point-min))
    )
  )

  (global-unset-key (kbd "M-."))
  (global-set-key (kbd "M-.") 'forward-block)
  (global-unset-key (kbd "M-o"))
  (global-set-key (kbd "M-o") 'backward-block)

  (global-unset-key (kbd "C-M-j"))
  (global-set-key (kbd "C-M-j") 'backward-word)
  (global-unset-key (kbd "C-M-l"))
  (global-set-key (kbd "C-M-l") 'forward-word)

  (global-unset-key (kbd "M-c"))
  (global-set-key (kbd "M-c") 'recenter-top-bottom)

;; fix some keybindings
  (global-unset-key (kbd "M-;"))
  (global-set-key (kbd "M-;") 'end-of-visual-line)
  (global-unset-key (kbd "M-h"))
  (global-set-key (kbd "M-h") 'beginning-of-visual-line)
  (global-set-key (kbd "∇") (lookup-key global-map (kbd "C-x")))
  (global-unset-key (kbd "M-u"))
  (global-set-key (kbd "M-u") 'delete-char)
  (global-unset-key (kbd "C-M-u"))
  (global-set-key (kbd "C-M-u") 'kill-word)
  (global-set-key (kbd "C-k") 'kill-visual-line)

;; setup the ido keybindings
  (defun ido-my-keys ()
   "Add my keybindings for ido."
    (local-unset-key (kbd "C-f"))
    (define-key ido-completion-map (kbd "C-f") 'ido-next-match)
    (define-key ido-completion-map (kbd "M-j") 'ido-prev-match)
  )
  (add-hook 'ido-setup-hook 'ido-my-keys)

;; RET gets identation right
(global-set-key (kbd "RET") 'newline-and-indent)

;; disable M-. from javascript mode map
(defun my-js-hook ()
  (define-key js-mode-map "\M-." nil))
(add-hook 'js-mode-hook 'my-js-hook)
