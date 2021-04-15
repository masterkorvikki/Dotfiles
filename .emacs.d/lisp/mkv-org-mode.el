;;; mkv-org-mode --- using org-mode in with my various things

;;; Commentary:

;;; Code:

(setq org-agenda-files '("~/gtd/inbox.org"
                         "~/gtd/gtd.org"
                         "~/gtd/tickler.org"))
(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

; Customizing the process by which org-mode exports pdfs

(setq org-latex-pdf-process (list
"latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))

; Adding cdlatex-mode
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

(provide 'mkv-org-mode)

;;; mkv-org-mode.el ends here
