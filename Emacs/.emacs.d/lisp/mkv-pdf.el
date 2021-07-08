;;; mkv-pdf --- I hate this file format

;;; Commentary:

;;; Code:

(defun mkv-inhibit-global-linum-mode ()
  "Counter-act `global-linum-mode'."
  (add-hook 'after-change-major-mode-hook
            (lambda () (linum-mode 0))
            :append :local))

(defun mkv-pdf-mode ()
  "Making pdf-tools behave"
  (setq debug-on-error nil)
  (mkv-inhibit-global-linum-mode))

(setq mkv-pdf-mode-hook 'mkv-pdf-mode)

(add-hook 'pdf-view-mode-hook (lambda ()
				(run-hooks 'mkv-pdf-mode-hook)))


(provide 'mkv-pdf)

;;; mkv-pdf.el ends here
