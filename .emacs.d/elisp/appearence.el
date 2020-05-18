;; Zenburn
;  (load (format "%s%s" drop-base-path "sys/my_init/other_els/zenburn-theme.el"))
(load-theme 'zenburn t)

;; current file name in title bar, else buffer name
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (setq require-final-newline nil)

;; proper word wrapping
  (global-visual-line-mode t)

;; show matching brackets
;  (require 'paren)
;  (show-paren-mode t)
  ;; fix \{ \} problems
;  (set-face-background 'show-paren-match-face "#ffff00")
;  (set-face-background 'show-paren-mismatch-face "#d30102")
;  (add-hook 'latex-mode-hook
;    (function (lambda () (require 'latex-paren))))

;; disable startup screen
  (setq inhibit-splash-screen t)

;; show whitespace
  ;(setq-default show-trailing-whitespace t)
  (add-hook 'find-file-hook (lambda ()
          (setq show-trailing-whitespace t)))

;; set up zenburn mode
  (defun zenburn-init ()
    (load-theme 'zenburn)
    (set-face-attribute  'mode-line
                   nil
                   :foreground "gray80"
                   :background "burlywood4"
                   :box '(:line-width 1 :style released-button))
    (set-face-attribute  'mode-line-inactive
                   nil
                   :foreground "gray30"
                   :box '(:line-width 1 :style released-button))
    (set-face-attribute  'region
                   nil
                   :background "burlywood4")

    ;; minibuffer gets orange
    (set-face-background 'minibuffer-prompt "orange")
    (set-face-foreground 'minibuffer-prompt "black"))

;; deactivate toolbar (with copy, paste...)
  (tool-bar-mode -1)

;; define a more economic mode-line
(setq-default mode-line-format
  (list
    ;; add the time, with the date and the emacs uptime in the tooltip
    ;'(:eval (propertize (format-time-string "%H:%M")
    ;          'help-echo
    ;          (concat (format-time-string "%c; ")
    ;                  (emacs-uptime "Uptime:%hh"))))
    ;" - "
    "  "
    ;; the buffer name; the file name as a tool tip
    '(:eval (propertize "%b" 'face 'font-lock-keyword-face
      'help-echo (buffer-file-name)))
    ;; was this buffer modified since the last save?
    '(:eval (when (buffer-modified-p)
      (concat (propertize "!"
        'face 'font-lock-type-face
        'help-echo "Buffer has been modified"))))
    " "
    ;; line and column
    "Pos (" ;; '%02' to set to 2 chars at least; prevents flickering
    (propertize "%03l");'face 'font-lock-keyword-face)
    ", "
    (propertize "%02c");'face 'font-lock-keyword-face)
    ") "
    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
      (concat (propertize "RO"
        ;'face 'font-lock-keyword-face
        'help-echo "Buffer is read-only"))))
    " "
    ;; to see minor-modes
    mode-line-modes
    "%-" ;; fill with '-'
    ))

;; shorten mode names in mode-line
;  (when (require 'diminish nil 'noerror)
;    (eval-after-load "Undo-Tree"
;      '(diminish 'undo-tree-mode "U-T"))
;       (diminish 'overwrite-mode "Ovrw")
;    )

;; set visual beep
  (setq visible-bell t)

;; remove menu bar
  (menu-bar-mode -1)

;; mark 80th column in whitespace mode
  ;(require 'whitespace)
  ;(setq whitespace-style '(face empty tabs lines-tail trailing))
  ;(global-whitespace-mode t)

(setq-default cursor-type 'bar)
(set-cursor-color "#00ff00") 

