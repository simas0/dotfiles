(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;; set LaTeXPdf as default
(setq TeX-PDF-mode t)

;; change equation standard label prefix
(setq LaTeX-equation-label "e:")

;; Alt-2 for latex
;(global-set-key (kbd "M-2") 'TeX-command-master)

;; define insert equation
(defun LaTeX-equation-environment () (interactive) (LaTeX-environment "equation"))

;; activate reftex
(require 'reftex)
(setq reftex-label-alist '(AMSTeX)) ; use eqref instead of (ref)
(setq reftex-ref-macro-prompt nil)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; setup outline-minor-mode
(setq outline-regexp "\\\\section")
(add-hook 'outline-minor-mode-hook 'my-outline-easy-bindings)
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)
(defun my-outline-easy-bindings ()
  (require 'outline-mode-easy-bindings nil t))

;; shortcuts
(global-unset-key (kbd "C-l"))
					;  (eval-after-load 'latex
					;    '(define-key LaTeX-mode-map (kbd "C-M-u") 'kill-forward-real-word))
					;  (eval-after-load 'latex
					;    '(define-key LaTeX-mode-map (kbd "C-M-j") 'backward-real-word))
					;  (eval-after-load 'latex
					;    '(define-key LaTeX-mode-map (kbd "C-M-l") 'forward-real-word))
(eval-after-load 'latex
  '(define-key LaTeX-mode-map (kbd "C-l c") 'reftex-citation))
(eval-after-load 'latex
  '(define-key LaTeX-mode-map (kbd "C-l b") 'LaTeX-environment))
(eval-after-load 'latex
  '(define-key LaTeX-mode-map (kbd "C-l e") 'LaTeX-equation-environment))
(eval-after-load 'latex
  '(define-key LaTeX-mode-map (kbd "C-l r") 'reftex-reference))
(eval-after-load 'latex
  '(define-key LaTeX-mode-map (kbd "C-l ]") 'LaTeX-close-environment))
(eval-after-load 'latex
  '(define-key LaTeX-mode-map (kbd "M-q")   'LaTeX-fill-environment))
(eval-after-load 'latex
  '(define-key LaTeX-mode-map (kbd "C-l u") 'find-unused-label))

;; Alt-2 runs latex
(eval-after-load 'latex
  '(define-key LaTeX-mode-map (kbd "M-2") 'TeX-command-master))

;; So that RefTeX finds my bibliography
(setq reftex-default-bibliography (format "%s%s" drop-base-path "Latex/BibTeX/all.bib"))

;; search for unused labels
(defun find-unused-label ()
  "Search for an unused label in the text (i.e. without a corresponding reference)."
  (interactive)
  (let (original label problem)
    (setq original (point))
    (setq problem nil)
    (while (and (re-search-forward "\\label{\\([a-zA-Z:]+\\)}" nil t) (not problem))
      (setq label (point))
      (goto-char 0)
      (if (re-search-forward (concat "{" (match-string 1) "}" ) nil t 2) () (setq problem t))
      (goto-char label)
      )
    (if problem (goto-char label) (goto-char original))
    (if problem (message "This seems to be unused") (message "No unused label"))
    )
  )

(setq bibretrieve-backends '(("msn" . 10) ("arxiv" . 5)))

;; include bibretrieve to get bibtex entries from mathscinet
;  (if (eq system-type 'windows-nt)
;    (load "C:/Users/Augusto/Dropbox/sys/my_init/other_els/bibretrieve.el")
;    (load (format "%s%s" drop-base-path "sys/my_init/other_els/bibretrieve.el"))
;  )

;; okular para abrir dvi
  (setq TeX-view-program-list
        '(("Okular"
          ("okular --unique %o" (mode-io-correlate "#src:%n%b")))))

  (setq TeX-view-program-selection
      '((output-dvi "Okular")
        (output-pdf "Okular")))


;; report warnings and bad-boxes
;(setq TeX-debug-bad-boxes t)
;(setq TeX-debug-warnings t)
(setq TeX-parse-all-errors t)

(custom-set-faces
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil))))
