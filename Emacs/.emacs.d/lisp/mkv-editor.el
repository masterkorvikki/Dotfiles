;;; mkv-editor --- making the editing experience nice
;;; Commentary:

;;; Code:

;;; newline at the end of file
(setq require-final-newline t)

;;; enable all the cool commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; .zsh file is shell script too
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode))

;;; tab can indent or complete
(setq tab-always-indent 'complete)

;;; makes sure dired uses the gnu ls
(when (string= system-type "darwin")
  (setq insert-directory-program "/usr/local/bin/gls"
        dired-listing-switches "-al --group-directories-first"))

;;; make sure saveplace works
(save-place-mode 1)

;;; window movement with shift and arrowkeys
(windmove-default-keybindings)

;; using wikitionary from emacs
(autoload 'ispell-get-word "ispell")

(defun lookup-word (word)
  (interactive
   (list (save-excursion (car (ispell-get-word nil)))))
  (split-window)
  (eww (format "http://en.wiktionary.org/wiki/%s" word)))

(global-set-key (kbd "C-c w") 'lookup-word)

(provide 'mkv-editor)

;;; mkv-editor.el ends here
