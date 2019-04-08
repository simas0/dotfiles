(require 'company)

(setq company-tooltip-align-annotations t)
(add-hook 'prog-mode-hook 'company-mode)

(provide 'init-company-mode)


(add-hook 'rust-mode-hook
          '(lambda ()
             (setq racer-cmd "/home/augusto/.cargo/bin/racer")
             (setq racer-rust-src-path "/home/augusto/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")
             (local-set-key (kbd "TAB") #'company-indent-or-complete-common)))

(setq rust-format-on-save t)

(setq company-idle-delay nil)
(setq company-minimum-prefix-length 400)

(add-hook 'rust-mode-hook  #'company-mode)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
