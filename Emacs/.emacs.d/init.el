;;; init.el --- it all starts here baby
;;; Commentary:

;;; Code:


;;; gc management
(setq gc-cons-threshold 80000000000000)
(add-to-list 'after-init-hook
	     (lambda ()
	       (setq gc-cons-threshold 800000)
               (let ((garbage-collection-messages t)) (garbage-collect))))

;;; set location for customization
(setq custom-file "~/.emacs.d/config/.emacs-custom.el")
(load custom-file)

;;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;;; load only my things
(setq inhibit-default-init t)

;;; package manager initialization
(require 'package)
(setq package-user-dir (concat user-emacs-directory "elpa"))
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))

;;; make sure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(eval-when-compile
  (add-to-list 'load-path "~/.emacs.d/elpa")
  (require 'use-package))

;;; getting use-package to be able to bind keys in compiled code
(require 'bind-key)

;;; making sure my path works
(use-package exec-path-from-shell)
(exec-path-from-shell-initialize)

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

(if (eq system-type 'darwin)
    (setq default-directory "/Users/alicesmith/")
  (setq default-directory "/home/alice/"))

(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'mkv-core)

(provide 'init)

;;; init.el ends here
