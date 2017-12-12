;; Changes to Org-mode
  ;; avoid subtree destruction with C-k in org-mode
  (setq org-ctrl-k-protect-subtree t)
  (setq org-catch-invisible-edits 'show)
  ;; RETURN follows link in org-mode (instead of C-c C-o)
  (setq org-return-follows-link t)
  ;; add time stamp when DONE
  (setq org-log-done 'time)

;; fix org-mode/yasnippet conflict
;  (defun yas/org-very-safe-expand ()
;    (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
;  (add-hook 'org-mode-hook
;          (lambda ()
;            (make-variable-buffer-local 'yas/trigger-key)
;            (setq yas/trigger-key [tab])
;            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
;            (define-key yas/keymap [tab] 'yas/next-field)))

(require 'org-install)

;; encrypt org headlines
  (require 'org-crypt)
     (org-crypt-use-before-save-magic)
     (setq org-tags-exclude-from-inheritance (quote ("crypt")))
     (setq org-crypt-key "08B8C677")

;     (setq org-crypt-key nil)
       ;; GPG key to use for encryption
       ;; Either the Key ID or set to nil to use symmetric encryption.

;     (setq auto-save-default nil)
       ;; Auto-saving does not cooperate with org-crypt.el: so you need
       ;; to turn it off if you plan to use org-crypt.el quite often.
       ;; Otherwise, you'll get an (annoying) message each time you
       ;; start Org.

       ;; To turn it off only locally, you can insert this:
       ;;
       ;; # -*- buffer-auto-save-file-name: nil; -*-

;; org-mode stuck projects are TODO's without SCHEDULE or DEADLINE
  (setq org-stuck-projects
      '("TODO={.+}/-DONE" nil nil "SCHEDULED:\\|DEADLINE:"))

; fix some key bindings
(add-hook 'org-mode-hook
  (lambda ()
    (local-set-key (kbd "M-;") 'end-of-visual-line)
    (local-set-key (kbd "M-h") 'beginning-of-visual-line)
    (local-set-key (kbd "C-y") 'cua-paste-pop)
    (local-set-key (kbd "M-o") 'outline-previous-visible-heading)
    (local-set-key (kbd "M-.") 'outline-next-visible-heading)))
