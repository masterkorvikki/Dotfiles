;;; mkv-programming --- adding things to the programming modes
;;; Commentary:

;;; Code:

(defun mkv-prog-mode ()
  "Some defaults for the various programming modes."
  (flyspell-prog-mode)
  (smartparens-strict-mode +1))

(setq mkv-prog-mode-hook 'mkv-prog-mode)

(add-hook 'prog-mode-hook (lambda ()
                            (run-hooks 'mkv-prog-mode-hook)))

(provide 'mkv-programming)

;;; mkv-programming.el ends here
