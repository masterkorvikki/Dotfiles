;;; early-init.el --- it really starts here though
;;; Commentary:

;;; Code:

;;; gc management
(setq gc-cons-threshold 80000000000000)
(add-to-list 'after-init-hook
	     (lambda ()
	       (setq gc-cons-threshold 800000)
               (let ((garbage-collection-messages t)) (garbage-collect))))

;;; temporarily disable the file name handler.
(setq default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(defun mkv-reset-file-name-handler-alist ()
  (setq file-name-handler-alist
        (append default-file-name-handler-alist
                file-name-handler-alist))
  (cl-delete-duplicates file-name-handler-alist :test 'equal))
(add-hook 'after-init-hook 'mkv-reset-file-name-handler-alist)

;;; confirm quit emacs
(setq confirm-kill-emacs 'y-or-n-p)

;;; set location for customization
(setq custom-file "~/.emacs.d/.emacs-custom.el")
(load custom-file)

;;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;;; load only my things
(setq inhibit-default-init t)

;;; package manager initialization
(require 'package)
(setq package-user-dir (concat user-emacs-directory "elpa"))
(setq package-enable-at-startup nil)

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
(when (or (memq window-system '(mac ns x)) (daemonp))
  (exec-path-from-shell-initialize))

(provide 'early-init)

;;; early-init.el ends here
