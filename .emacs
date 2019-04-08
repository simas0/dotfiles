;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq drop-base-path "/home/augusto/.emacs.d/elisp/")

(load (format "%s%s" drop-base-path "init-packages.el"))
(load (format "%s%s" drop-base-path "bindings.el"))
(load (format "%s%s" drop-base-path "latex.el"))
(load (format "%s%s" drop-base-path "rust.el"))
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
    ("84890723510d225c45aaff941a7e201606a48b973f0121cb9bcb0b9399be8cba" "bfdcbf0d33f3376a956707e746d10f3ef2d8d9caa1c214361c9c08f00a1c8409" default)))
 '(package-selected-packages
   (quote
    (lua-mode yaml-mode cargo company racer rust-mode protobuf-mode smex zenburn-theme yasnippet use-package undo-tree markdown-mode magit key-chord ido-vertical-mode hydra flx-ido auctex ace-jump-mode solidity-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cfw:face-annotation ((t :foreground "RosyBrown" :inherit cfw:face-day-title)))
 '(cfw:face-day-title ((t :background "#3f3f3f")))
 '(cfw:face-default-content ((t :foreground "#bfe0bf")))
 '(cfw:face-default-day ((t :weight normal :inherit cfw:face-day-title)))
 '(cfw:face-disable ((t :foreground "DarkGray" :inherit cfw:face-day-title)))
 '(cfw:face-grid ((t :foreground "DarkGrey")))
 '(cfw:face-header ((t (:foreground "#d0bf8f" :weight normal))))
 '(cfw:face-holiday ((t :foreground "#cc9393" :background "#3f3f3f" :weight normal)))
 '(cfw:face-periods ((t :foreground "#bfebbf" :inherit cfw:face-day-title)))
 '(cfw:face-regions ((t :foreground "#bfe0bf" :inherit cfw:face-day-title)))
 '(cfw:face-saturday ((t :foreground "#cc9393" :background "#3f3f3f" :weight normal)))
 '(cfw:face-select ((t :background "burlywood4")))
 '(cfw:face-sunday ((t :foreground "#cc9393" :background "#3f3f3f" :weight normal)))
 '(cfw:face-title ((t (:foreground "#f0dfaf" :weight normal :height 2.0 :inherit variable-pitch))))
 '(cfw:face-today ((t :background: "#dc8cc3" :foreground "black" :weight normal)))
 '(cfw:face-today-title ((t :background "#bc8383" :weight normal)))
 '(cfw:face-toolbar ((t :foreground "Steelblue4" :background "#3f3f3f")))
 '(cfw:face-toolbar-button-off ((t :foreground "#ffffff" :background "#3f3f3f" :weight normal)))
 '(cfw:face-toolbar-button-on ((t :foreground "#ffffff" :background "burlywood4" :weight normal)))
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil))))
