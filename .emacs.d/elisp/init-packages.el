(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(add-to-list 'load-path "~/.emacs.d/site-lisp/")


; list the packages you want
(setq package-list
      '(ace-jump-mode auctex flx-ido flx hydra ido-vertical-mode key-chord magit
                      git-commit magit-popup dash markdown-mode undo-tree
                      use-package diminish bind-key with-editor async yasnippet
                      zenburn-theme smex))

; activate all the packages
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
