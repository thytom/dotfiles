;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Packages
(require 'evil-surround)
(require 'evil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("2116ed2bb7af1ff05bef1d9caf654ae2820088c86d50c83cd8f90bf83ce0cbcc" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(package-selected-packages
   (quote
    (smart-mode-line evil-commentary use-package evil-surround))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;; User defined settings

(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))
(setq backup-by-copying t)
(setq x-select-enable-clipboard nil)
(setq sml/theme 'light)

(sml/setup)

(load-theme 'zenburn)

;; Set Transparency
(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))


(evil-mode 1) ; Vim-Like
(evil-commentary-mode 1) ; Commenting with gcc
(menu-bar-mode -1) ; Disable Menu Bar
(global-display-line-numbers-mode)
(global-evil-surround-mode 1)

; (with-eval-after-load 'evil-maps
;   (define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)
;   (define-key evil-motion-state-map (kbd ";") 'evil-ex))

;; Start emacs with an empty buffer
(setf inhibit-splash-screen t)
(switch-to-buffer (get-buffer-create "Empty Buffer"))
(delete-other-windows)