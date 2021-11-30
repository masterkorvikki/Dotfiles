;;; init.el --- it all starts here baby
;;; Commentary:

;;; Code:

;;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; Making the frame open big enough to do things
(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 150))

;;; visual customization
(blink-cursor-mode -1)
(global-hl-line-mode t)
(global-linum-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(winner-mode +1)
(setq frame-title-format " %b ")
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'org-mode)
(setq ring-bell-function 'ignore)
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(load-theme 'solarized-dark t)
(setq custom-safe-themes t)

(setq default-directory "/home/alice/")

(add-to-list 'load-path "~/.emacs.d/lisp")
(use-package mkv-core
  :ensure nil)
(use-package mkv-programming
  :ensure nil)
(use-package mkv-editor
  :ensure nil)
(use-package mkv-keybindings
  :ensure nil)

(provide 'init)

;;; init.el ends here
