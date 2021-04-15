;;; mkv-elisp --- making elisp even nicer to edit

;;; Commentary:

;;; Code:

;; Lisp configuration
(define-key read-expression-map (kbd "TAB") 'completion-at-point)

(defun mkv-emacs-lisp-mode-defaults ()
  "My defaults for coding in Emacs Lisp."
  (eldoc-mode +1)
  (add-hook 'after-save-hook 'emacs-lisp-byte-compile 90 t)
  (setq mode-name "EL"))

(add-hook 'emacs-lisp-mode-hook 'mkv-emacs-lisp-mode-defaults)
(add-hook 'lisp-interaction-mode-hook 'mkv-emacs-lisp-mode-defaults)

(provide 'mkv-elisp)

;;; mkv-elisp.el ends here
