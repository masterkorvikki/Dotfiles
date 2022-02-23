;;; early-init.el --- it really starts here though
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

(provide 'early-init)

;;; early-init.el ends here
