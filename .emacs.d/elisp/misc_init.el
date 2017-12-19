;; inhibit startup-welcome-screen
(setq inhibit-startup-screen t)

;; lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;; bind Caps-Lock to <f13> and Super_R to Control_R
;(shell-command "xmodmap -e 'clear Lock' -e 'keycode 66 = F13' -e 'clear Control' -e 'clear mod4' -e 'keycode 134 = Control_R' -e 'add Control = Control_R' -e 'add Control = Control_L'")

;; set gertec keyboard
;(shell-command "xinput -list | grep \"GASIA PS2toUSB Adapter\" | grep keyboard |sed -n 's/.*id=\([0-9]\+\).*/\1/p' | head -n 1 | xargs setxkbmap \"lo\" -device")

;; fix backslash
(shell-command "xmodmap -e 'keycode 94 = backslash'")

(cua-mode 1)

(setq cua-keep-region-after-copy t)

;; set undo
  (global-set-key (kbd "C-z") 'undo-tree-undo)
  (global-unset-key (kbd "C-Z"))
  (global-unset-key (kbd "C-S-z"))
  (global-set-key (kbd "C-Z") 'undo-tree-redo)
  (global-set-key (kbd "C-S-z") 'undo-tree-redo)

;; set proper undo in terminal
  (global-set-key [?\C-z] 'undo-tree-undo)
  (global-unset-key (kbd "C-a"))
  (global-set-key (kbd "C-a") 'undo-tree-redo)

;; F11 = Full Screen
  (defun toggle-fullscreen (&optional f)
    (interactive)
    (let ((current-value (frame-parameter nil 'fullscreen)))
      (set-frame-parameter nil 'fullscreen
        (if (equal 'fullboth current-value)
          (if (boundp 'old-fullscreen) old-fullscreen nil)
          (progn (setq old-fullscreen current-value)
            'fullboth)))))
  (global-set-key [f11] 'toggle-fullscreen)

;; recently opened files
  (require 'recentf)
  (recentf-mode 1)
  (setq recentf-max-menu-items 15)
  (defun ido-recentf-open ()
    "Use `ido-completing-read' to \\[find-file] a recent file"
    (interactive)
    (if (find-file (ido-completing-read "Find recent file: " recentf-list))
        (message "Opening file...")
      (message "Aborting")))

;; start ido mode (find and predict of path/buffer names)
  (setq ido-everywhere t)
  (ido-mode t)
  (setq ido-enable-flex-matching t)
  (setq ido-file-extensions-order '(".org" ".tex" ".txt" ".el" ".cpp" ".cfg" ".cnf" ".xml" ".log"))

;; tab auto-completes in eval minibuffer
  (define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)

;; use smex (IDO-type M-x)
;  (require 'smex)   ; Not needed if you use package.el
;  (smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                    ; when Smex is auto-initialized on its first run.
;  (global-set-key (kbd "M-x") 'smex)

;; ESC replaces C-g
;; this will not work in the terminal and I've tried hard other alternatives
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; ESC does not kill other window
  (defadvice keyboard-escape-quit (around my-keyboard-escape-quit activate)
    (let (orig-one-window-p)
      (fset 'orig-one-window-p (symbol-function 'one-window-p))
      (fset 'one-window-p (lambda (&optional nomini all-frames) t))
      (unwind-protect
          ad-do-it
        (fset 'one-window-p (symbol-function 'orig-one-window-p))
      )
    )
  )

;; typing while something is selected deletes selection
  (delete-selection-mode 1)

;; bookmarks
;  (require 'bm)
;  (global-set-key (kbd "<C-f2>") 'bm-toggle)
;  (global-set-key (kbd "<f2>") 'bm-next)

;; open some files externally
  (add-to-list 'load-path "/path/to/downloaded/openwith.el")
  (when (require 'openwith nil 'noerror)
      (setq openwith-associations
            (list
             (list (openwith-make-extension-regexp
                    '("mpg" "mpeg" "mp3" "mp4"
                      "avi" "wmv" "wav" "mov" "flv"
                      "ogm" "ogg" "mkv"))
                      "vlc"
                      '(file))
             (list (openwith-make-extension-regexp
                    '("xbm" "pbm" "pgm" "ppm" "pnm"
                      "png" "gif" "bmp" "tif" "jpeg" "jpg"))
                      "viewnior"
                      '(file))
             (list (openwith-make-extension-regexp
                    '("zip" "rar" "gz"))
                      "file-roller"
                      '(file))
             (list (openwith-make-extension-regexp
                    '("doc" "xls" "ppt" "odt" "ods" "odg" "odp"))
                      "libreoffice"
                      '(file))
             '("\\.lyx" "lyx" (file))
             '("\\.djvu\\'" "djview4" (file))
             '("\\.chm" "kchmviewer" (file))
             (list (openwith-make-extension-regexp
                    '("pdf" "ps" "ps.gz" "dvi"))
                      "okular"
                      '(file))
             ))
      (openwith-mode 1))

;; using firefox as standard browser
  (setq gnus-button-url 'browse-url-generic
    browse-url-generic-program "firefox"
    browse-url-browser-function gnus-button-url)

;; fix problem with S-down
  (global-unset-key (kbd "S-<down>"))
  (global-set-key (kbd "S-<down>") 'next-line)

;; cl-lib is required for function loop below 
  (require 'cl-lib)

;; start ace jump mode
  (autoload
    'ace-jump-mode
    "ace-jump-mode"
    "Emacs quick move minor mode"
    t)
  ;; you can select the key you prefer to
  ;;(global-unset-key (kbd "M-f"))
  ;;(define-key global-map (kbd "M-f") 'ace-jump-mode)
  (setq ace-jump-mode-scope 'window) ; jump in window only (dov-view's fault)

  (setq ace-jump-mode-move-keys
    (nconc (cl-loop for i from ?a to ?z collect i)
           (cl-loop for i from ?0 to ?9 collect i)
           (cl-loop for i from ?A to ?Z collect i)))

;; ignore accents when searching/ace jumping
(let ((eqv-list '("aAàÀáÁâÂãÃäÄåÅ"
		  "cCçÇčČ"
		  "eEèÈéÉêÊëË"
		  "iIìÌíÍîÎïÏ"
		  "nNñÑ"
		  "oOòÒóÓôÔõÕöÖøØ"
		  "uUùÙúÚûÛüÜ"
		  "yYýÝÿ"))
      (table (standard-case-table)) canon)
  (setq canon (copy-sequence table))
  (mapcar (lambda (s)
	    (mapcar (lambda (c) (aset canon c (aref s 0))) s)) eqv-list)
  (set-char-table-extra-slot table 1 canon)
  (set-char-table-extra-slot table 2 nil)
  (set-standard-case-table table))

;; Define unfill-paragraph, It is the opposite of fill-paragraph
  (defun unfill-paragraph ()
    "Takes a multi-line paragraph and makes it into a single line of text."
    (interactive)
    (let ((fill-column (point-max)))
      (fill-paragraph nil)))
  (defun unfill-region ()
    (interactive)
    (let ((fill-column (point-max)))
      (fill-region (region-beginning) (region-end) nil)))
  (defun unfill-buffer ()
    (interactive)
    (progn
      (unfill-paragraph)
      (re-search-forward "[^.]\n[[:space:]]*[a-zA-Z$]")))

;; fill paragraphs with respect to senteces
(setq sentence-end-double-space nil)

;  (defun wrap-at-sentences ()
;    "Fills the current paragraph, but starts each sentence on a new line."
;    (interactive)
;    (save-excursion
;      ;; Select the entire paragraph.
;      (mark-paragraph)
;      ;; Move to the start of the paragraph.
;      (goto-char (region-beginning))
;      ;; Record the location of the end of the paragraph.
;      (setq end-of-paragraph (region-end))
;      ;; Wrap lines with 'hard' newlines (i.e., real line breaks).
;      (let ((use-hard-newlines 't))
;        ;; Loop over each sentence in the paragraph.
;        (while (< (point) end-of-paragraph)
;          ;; Determine the region spanned by the sentence.
;          (setq start-of-sentence (point))
;          (forward-sentence)
;          ;; Wrap the sentence with hard newlines.
;          (fill-region start-of-sentence (point))
;          ;; Delete the whitespace following the period, if any.
;          (while (char-equal (char-syntax (preceding-char)) ?\s)
;            (delete-char -1))
;          ;; Insert a newline before the next sentence.
;          (insert "\n")))))

(defun auto-fill-by-sentences ()
  (if (looking-back (sentence-end))
      ;; Break at a sentence
      (progn
	(LaTeX-newline)
	t)
    ;; Fall back to the default
    (do-auto-fill)))
;  (add-hook 'LaTeX-mode-hook (lambda () (setq auto-fill-function 'auto-fill-by-sentences)))

;; Modified from http://pleasefindattached.blogspot.com/2011/12/emacsauctex-sentence-fill-greatly.html
(defadvice LaTeX-fill-region-as-paragraph (around LaTeX-sentence-filling)
  "Start each sentence on a new line."
  (let ((from (ad-get-arg 0))
	(to-marker (set-marker (make-marker) (ad-get-arg 1)))
	tmp-end)
    (while (< from (marker-position to-marker))
      (forward-sentence)
      ;; might have gone beyond to-marker---use whichever is smaller:
      (ad-set-arg 1 (setq tmp-end (min (point) (marker-position to-marker))))
      ad-do-it
      (ad-set-arg 0 (setq from (point)))
      (unless (or (looking-back "^\\s *")
		  (looking-at "\\s *$"))
	(LaTeX-newline)))
    (set-marker to-marker nil)))
(ad-activate 'LaTeX-fill-region-as-paragraph)

;; control backups and auto-saves
;; Put autosave files (ie #foo#) and backup files (ie foo~) in
;; ~/.emacs.d/autosaves/
(defvar autosave-dir "~/.emacs.d/autosaves/")
(setq backup-directory-alist `((".*" . ,"~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t))); location for all auto-save files
(setq tramp-auto-save-directory autosave-dir); auto-save tramp files in local directory

;; create the autosave dir if necessary, since emacs won't.
(make-directory autosave-dir t)

;; configure backup
(setq vc-make-backup-files t)
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; yasnippet configuration
;;(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20150212.240/")
(require 'yasnippet)
(setq yas-snippet-dirs (format "%s%s" drop-base-path "snippets"))
(yas-global-mode 1)
(yas-reload-all)

;; fill paragraphs with fmt (using Knuth's algorithm)
(defun unscrewup-paragraph (beg end)
  (interactive "r")
  (progn
    (setq current (point))
    (mark-paragraph)
    (setq beg (region-beginning))
    (setq end (region-end))
    (shell-command-on-region beg end "fmt" nil t)
    (goto-char current)))
(global-set-key (kbd "M-q") 'unscrewup-paragraph)

;; set a personal dictionary for ispell
  (setq ispell-personal-dictionary (format "%s%s" drop-base-path "dictionaries/my_dict"))

(require 'package)
(package-initialize)

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(require 'use-package)

;; hydra
;(use-package hydra
;  :ensure hydra)

;(require 'hydra)

;(defhydra hydra-splitter (global-map "C-M-o")
;  "splitter"
;  ("h" shrink-window-horizontally)
;  ("j" shrink-window)
;  ("k" enlarge-window)
;  ("l" enlarge-window-horizontally)
;  ("q" nil "quit"))

(use-package ido-vertical-mode
  :ensure ido-vertical-mode)

(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; c-s saves
(global-unset-key (kbd "C-s"))
(global-set-key (kbd "C-s") 'save-buffer)

;; goto last change
;(require 'goto-last-change)
;(global-set-key (kbd "C-M-z") 'goto-last-change)

;; fixing ido
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)

;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; To use spaces instead of tabs when indenting
(setq-default indent-tabs-mode nil)

;; Best positions for recentering screen
(setq recenter-positions '(0.3 0.5 0.7))

;; use flyspell in text and LaTeX
  (defun turn-on-flyspell ()
    (interactive)
    (unless (equal (message "%s" major-mode) "org-mode")
      (progn
        (flyspell-mode 1)
        (flyspell-buffer)
        (setq flyspell-issue-message-flag nil))))
;  (add-hook 'text-mode-hook 'turn-on-flyspell)
;  (add-hook 'LaTeX-mode-hook 'turn-on-flyspell)

(setq-default ispell-program-name "ispell")

;; not working, see later
;;(require 'auto-dictionary)
;;(add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))

;; not working for a whole deal of buffers
  (defun set-show-trailing-whitespace-true ()
    "My function to set whitespace visible"
    (interactive)
    (setq show-trailing-whitespace t))
  (add-hook 'text-mode-hook 'set-show-trailing-whitespace-true)


;; smex

  (smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                    ; when Smex is auto-initialized on its first run.

;; Bind some keys:

  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)

