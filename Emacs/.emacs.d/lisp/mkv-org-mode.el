;;; mkv-org-mode --- using org-mode in with my various things

;;; Commentary:

;;; Code:

;; Setting up my agenda

(setq org-agenda-files '("~/gtd"))
(setq org-agenda-start-on-weekday 0)
(setq org-agenda-include-diary t)
(setq diary-file "~/gtd/diary.org")
(setq org-capture-templates
      (quote (("t" "Todo" entry (file+headline "~/gtd/inbox.org" "Tasks")
               "** TODO %? %^G" :clock-resume t)
	      ("s" "Scheduled todo" entry (file+headline "~/gtd/inbox.org" "Tasks")
               "** TODO %? %^G \nSCHEDULED: %^t\n" :clock-resume t)
	      ("d" "Deadline" entry (file+headline "~/gtd/inbox.org" "Tasks")
               "** TODO %? %^G \nDEADLINE: %^t" :clock-resume t)
	      ("a" "Appointment" entry (file+headline "~/gtd/inbox.org" "Events")
               "** %? %^G \n  %^t" :clock-resume t)
              ("r" "Respond" entry (file+headline "~/gtd/inbox.org" "Tasks")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "Note" entry (file+headline "~/gtd/inbox.org" "Notes")
               "* %? :NOTE:\n%U" :clock-resume t))))


;; Setting up keybindings

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c b") 'org-switchb)

; Setting up todo keywords and faces and also selection

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))

(setq org-todo-keyword-faces
      '(("TODO" :foreground "#d75f00" :weight bold)
	("NEXT" :foreground "#af8700" :weight bold)
	("DONE" :foreground "#00afaf" :weight bold)
	("WAITING" :foreground "#d70000" :weight bold)
	("HOLD" :foreground "#af005f" :weight bold)
	("CANCELLED" :foreground "#5f8700" :weight bold)))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))


(setq org-use-fast-todo-selection t)

(setq org-treat-S-cursor-todo-selection-as-state-change nil)

; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@campus" . ?c)
                            ("@home" . ?H)
                            (:endgroup)
                            ("WAITING" . ?w)
                            ("HOLD" . ?h)
                            ("PERSONAL" . ?p)
                            ("WORK" . ?W)
                            ("NOTE" . ?n)
                            ("CANCELLED" . ?c)
                            ("FLAGGED" . ??))))

;; Allow refiling where I want it

(setq org-refile-targets '((org-agenda-files :maxlevel . 4)))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)

;; Customizing the process by which org-mode exports pdfs

(setq org-latex-pdf-process (list
"latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))

;; Only show deadlines if they're past due
(setq org-deadline-warning-days 0)


;; Adding cdlatex-mode
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; Adding scheme to supported languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((scheme . t)))


(provide 'mkv-org-mode)

;;; mkv-org-mode.el ends here
