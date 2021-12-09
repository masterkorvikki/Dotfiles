;;; mkv-latex.el -- writing in latex, it's cool

;;; Commentary:

;;; Code:

;; AUCTeX configuration
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq reftex-plug-into-AUCTeX t)

(setq-default TeX-master nil)

;; use pdflatex
(setq TeX-PDF-mode t)

;; sensible defaults for macOS, other OSes should be covered out-of-the-box
(when (eq system-type 'darwin)
  (setq TeX-view-program-selection
        '((output-dvi "DVI Viewer")
          (output-pdf "PDF Viewer")
          (output-html "HTML Viewer")))

  (setq TeX-view-program-list
        '(("DVI Viewer" "open %o")
          ("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")
          ("HTML Viewer" "open %o"))))

(defun mkv-latex-defaults ()
  "My defaults for `LaTeX-Mode'."
  (turn-on-auto-fill)
  (abbrev-mode +1)
  (turn-on-cdlatex)
  (turn-on-flyspell)
  (turn-on-reftex)
  (yas-minor-mode-on)
  (outline-minor-mode +1)
  (prettify-symbols-mode +1)
  (xenops-mode))

;; a few outline mode bindings just because they're useful

(setq outline-minor-mode-prefix (kbd "M-o"))


(add-hook 'LaTeX-mode-hook 'mkv-latex-defaults)

(provide 'mkv-latex)

;;; mkv-latex.el ends here
