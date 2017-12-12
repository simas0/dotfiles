(require 'key-chord)
(key-chord-mode 1)

;; turn on and off
(global-set-key (kbd "C-x c") 'key-chord-mode)

;; define zap ace-jump
  (defvar ace-jump-should-zap-flag nil)
  (defvar ace-jump-last-position)

  (defun ace-jump-should-zap ()
    (interactive)
    (if ace-jump-should-zap-flag (kill-region ace-jump-last-position (point)))
    (setq ace-jump-should-zap-flag nil))

  (add-hook 'ace-jump-mode-end-hook 'ace-jump-should-zap)

  (defun ace-jump-zap ()
    (interactive)
    (setq ace-jump-should-zap-flag t)
    (setq ace-jump-last-position (point))
    (ace-jump-mode 1))

;; define copy ace-jump
  (defvar ace-jump-should-copy-flag nil)
  (defun ace-jump-should-copy ()
    (interactive)
    (if ace-jump-should-copy-flag (copy-region-as-kill ace-jump-last-position (point)))
    (setq ace-jump-should-copy-flag nil))

  (defun ace-jump-copy ()
    (interactive)
    (setq ace-jump-should-copy-flag t)
    (setq ace-jump-last-position (point))
    (ace-jump-mode 1))

  (add-hook 'ace-jump-mode-end-hook 'ace-jump-should-copy)

(key-chord-define-global ";r" 'ido-recentf-open)

;; chords for regions
(key-chord-define-global "fd" 'ace-jump-mode)
(key-chord-define-global "cv" 'ace-jump-zap)
(key-chord-define-global "fg" 'ace-jump-copy)

;; chords for brackets
(key-chord-define-global "09" "()\C-b")
(key-chord-define-global "[]" "[]\C-b")
(key-chord-define-global ",." "{}\C-b")


;; chords for latex
(add-hook 'LaTeX-mode-hook
          (lambda () (key-chord-define LaTeX-mode-map "34" "$$\C-b")))
(add-hook 'LaTeX-mode-hook
          (lambda () (key-chord-define LaTeX-mode-map ";t" (lambda () (interactive) (insert "\\text{}") (backward-char)))))

;; insert mathbb with ease
  (defun insert-mathbb (inserted-letter)
    (interactive "c")
    (insert "\\mathbb{")
    (insert (upcase inserted-letter))
    (insert "}"))
  (add-hook 'LaTeX-mode-hook
            (lambda () (key-chord-define LaTeX-mode-map "bb" 'insert-mathbb)))

;; insert mathcal with ease
  (defun insert-mathcal (inserted-letter)
    (interactive "c")
    (insert "\\mathcal{")
    (insert (upcase inserted-letter))
    (insert "}"))
  (add-hook 'LaTeX-mode-hook
            (lambda () (key-chord-define LaTeX-mode-map "ml" 'insert-mathcal)))

;; insert \big \big
  (defun insert-big (inserted-letter)
    (interactive "c")
    (cond
     ((string= (char-to-string inserted-letter) ",") (progn (insert "\\big\\{  \\big\\}") (backward-char 7)))
     ((string= (char-to-string inserted-letter) "[") (progn (insert "\\big[  \\big]") (backward-char 6)))
     ((string= (char-to-string inserted-letter) "9") (progn (insert "\\big(  \\big)") (backward-char 6)))))
  (add-hook 'LaTeX-mode-hook
            (lambda () (key-chord-define LaTeX-mode-map ";b" 'insert-big)))

;; insert \Big \Big
  (defun insert-extra-big (inserted-letter)
    (interactive "c")
    (cond
     ((string= (char-to-string inserted-letter) ",") (progn (insert "\\Big\\{  \\Big\\}") (backward-char 7)))
     ((string= (char-to-string inserted-letter) "[") (progn (insert "\\Big[  \\Big]") (backward-char 6)))
     ((string= (char-to-string inserted-letter) "9") (progn (insert "\\Big(  \\Big)") (backward-char 6)))))
  (add-hook 'LaTeX-mode-hook
            (lambda () (key-chord-define LaTeX-mode-map ";g" 'insert-extra-big)))

