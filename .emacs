;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq drop-base-path "/home/augusto/.emacs.d/elisp/")

(load (format "%s%s" drop-base-path "init-packages.el"))
(load (format "%s%s" drop-base-path "bindings.el"))
(load (format "%s%s" drop-base-path "latex.el"))
(load (format "%s%s" drop-base-path "key-chord-bindings.el"))
(load (format "%s%s" drop-base-path "gertec_code.el"))
(load (format "%s%s" drop-base-path "gertec.el"))
(load (format "%s%s" drop-base-path "misc_init.el"))
(load (format "%s%s" drop-base-path "org_changes.el"))
(load (format "%s%s" drop-base-path "appearence.el"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bfdcbf0d33f3376a956707e746d10f3ef2d8d9caa1c214361c9c08f00a1c8409" default)))
 '(package-selected-packages
   (quote
    (smex zenburn-theme yasnippet use-package undo-tree markdown-mode magit key-chord ido-vertical-mode hydra flx-ido auctex ace-jump-mode solidity-mode))))
