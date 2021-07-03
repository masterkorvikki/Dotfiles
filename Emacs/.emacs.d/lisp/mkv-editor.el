;;; mkv-editor --- making the editing experience nice
;;; Commentary:

;;; Code:

(setq debug-on-error t)
;;; newline at the end of file
(setq require-final-newline t)

;;; enable all the cool commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;;; make dired work nicer
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
(setq dired-dwim-target t)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;;; I like abbrev mode
(add-hook 'text-mode-hook 'abbrev-mode)

;; .zsh file is shell script too
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode))

;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

;;; tab can indent or complete
(setq tab-always-indent 'complete)

;;; makes sure dired uses the gnu ls
(when (string= system-type "darwin")
  (setq dired-use-ls-dired t
        insert-directory-program "/usr/local/bin/gls"
        dired-listing-switches "-al --group-directories-first"))

;;; make sure saveplace works
(save-place-mode 1)

;;; window movement with shift and arrowkeys
(windmove-default-keybindings)

(provide 'mkv-editor)

;;; mkv-editor.el ends here
