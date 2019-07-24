;; Zenburn
;  (load (format "%s%s" drop-base-path "sys/my_init/other_els/zenburn-theme.el"))
(load-theme 'zenburn t)

;; current file name in title bar, else buffer name
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (setq require-final-newline nil)

;; proper word wrapping
  (global-visual-line-mode t)

;; show matching brackets
  (require 'paren)
  (show-paren-mode t)
  ;; fix \{ \} problems
  (set-face-background 'show-paren-match-face "#ffff00")
  (set-face-background 'show-paren-mismatch-face "#d30102")
  (add-hook 'latex-mode-hook
    (function (lambda () (require 'latex-paren))))

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
  (set-face-foreground 'minibuffer-prompt "black")

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

; set frame size according to screen resolution (horizontal)
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (when (display-graphic-p)
    (progn
      ;; use 175 char wide window for largeish displays
      ;; and smaller 80 column windows for smaller displays
      ;; pick whatever numbers make sense for you
      (if (> (x-display-pixel-width) 1400)
	(set-frame-size (selected-frame) 175 50)
	(set-frame-size (selected-frame) 124 35))
      ;; for the height, subtract a couple hundred pixels
      ;; from the screen height (for panels, menubars and
      ;; whatnot), then divide by the height of a char to
      ;; get the height we want
      ;; (add-to-list 'default-frame-alist
      ;;   (cons 'height (/ (- (x-display-pixel-height) 100)
      ;;   (frame-char-height))))
    )))
;; not working
;;(add-hook 'before-make-frame-hook 'set-frame-size-according-to-resolution)
;;(add-hook 'after-init-hook 'set-frame-size-according-to-resolution)

; set frame size according to screen resolution (vertical screen)
(defun set-frame-size-according-to-resolution-vertical ()
  (interactive)
  (when (display-graphic-p)
    (progn
      ;; use 175 char wide window for largeish displays
      ;; and smaller 80 column windows for smaller displays
      ;; pick whatever numbers make sense for you
      (if (> (x-display-pixel-width) 1000)
          (set-frame-size (selected-frame) 100 80)
        (set-frame-size (selected-frame) 70 40))
      ;; for the height, subtract a couple hundred pixels
      ;; from the screen height (for panels, menubars and
      ;; whatnot), then divide by the height of a char to
      ;; get the height we want
      ;; (add-to-list 'default-frame-alist
      ;;   (cons 'height (/ (- (x-display-pixel-height) 100)
      ;;   (frame-char-height))))
    )))
;; not working
;;(add-hook 'before-make-frame-hook 'set-frame-size-according-to-resolution)
;;(add-hook 'after-init-hook 'set-frame-size-according-to-resolution)

;; remove menu bar
(menu-bar-mode -1)

;; mark 80th column in whitespace mode
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)
