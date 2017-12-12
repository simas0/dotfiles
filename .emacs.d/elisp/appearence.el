;; Zenburn
;  (load (format "%s%s" drop-base-path "sys/my_init/other_els/zenburn-theme.el"))
(load-theme 'zenburn t)

;; current file name in title bar, else buffer name
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (setq require-final-newline nil)

;; Do not change super-/sub-script font
  (setq font-latex-script-display (quote (nil)))
  (custom-set-faces
    '(font-latex-subscript-face ((t nil)))
    '(font-latex-superscript-face ((t nil)))
  )

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

;; Default frame height
;  (add-to-list 'default-frame-alist '(height . 59))
;  (add-to-list 'default-frame-alist '(width  . 170))

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

;; send mode-line to header
;  (setq-default header-line-format mode-line-format) ; Copy mode-line
;  (setq-default mode-line-format nil) ; Remove mode-line

;; minibuffer gets orange
  (set-face-background 'minibuffer-prompt "orange")
  (set-face-foreground 'minibuffer-prompt "black")

  (custom-set-faces
    '(cfw:face-title ((t (:foreground "#f0dfaf" :weight normal :height 2.0 :inherit variable-pitch)))) ;; Date (main) title color and background.
    '(cfw:face-header ((t (:foreground "#d0bf8f" :weight normal ))))
    '(cfw:face-sunday ((t :foreground "#cc9393" :background "#3f3f3f"  :weight normal))) ;; Sunday main title and dates color.
    '(cfw:face-saturday ((t :foreground "#cc9393" :background "#3f3f3f"  :weight normal))) ;; Saturday main title and dates color.
    '(cfw:face-holiday ((t :foreground "#cc9393" :background "#3f3f3f"  :weight normal))) ;; Holiday title background and foreground.
    '(cfw:face-grid ((t :foreground "DarkGrey" ))) ;; Grid lines colors.
    '(cfw:face-default-content ((t :foreground "#bfe0bf"))) ;; Default titles of entries.
    '(cfw:face-regions ((t :foreground "#bfe0bf"  :inherit cfw:face-day-title))) ;;
    '(cfw:face-periods ((t :foreground "#bfebbf"  :inherit cfw:face-day-title))) ;; number of entries per day.
    '(cfw:face-day-title ((t :background "#3f3f3f" ))) ;; Day main title color.
    '(cfw:face-default-day ((t :weight normal   :inherit cfw:face-day-title)))
    '(cfw:face-annotation ((t :foreground "RosyBrown"  :inherit cfw:face-day-title)))
    '(cfw:face-disable ((t :foreground "DarkGray"  :inherit cfw:face-day-title)))
    '(cfw:face-today-title ((t :background "#bc8383"  :weight normal))) ;; Today title background and color?
    '(cfw:face-today ((t :background: "#dc8cc3"  :foreground "black" :weight normal))) ;; Today title background and color?
    '(cfw:face-select ((t :background "burlywood4"  ))) ;; Today focus title background and foreground.
    '(cfw:face-toolbar ((t :foreground "Steelblue4"   :background "#3f3f3f")))
    '(cfw:face-toolbar-button-off ((t :foreground "#ffffff" :background "#3f3f3f" :weight normal )))
    '(cfw:face-toolbar-button-on ((t :foreground "#ffffff" :background "burlywood4" :weight normal ))))
    (setq cfw:face-item-separator-color nil)
  )
  (add-hook 'after-init-hook 'zenburn-init)

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
  (when (require 'diminish nil 'noerror)
    (eval-after-load "Undo-Tree"
       '(diminish 'undo-tree-mode "U-T"))
;      (diminish 'predictive-mode "Pred")
;      (diminish 'auto-completion-mode "Comp")
      (diminish 'overwrite-mode "Ovrw")
    )

;; send scroll bar to the right
  (set-scroll-bar-mode 'right)

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

