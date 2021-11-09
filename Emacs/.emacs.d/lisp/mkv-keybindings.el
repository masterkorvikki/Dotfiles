;;; mkv-keybindings.el --- all the keybindings I like to use

;;; Commentary:

;;; Code:

;; Hydra to unite all the shells
(defhydra hydra-shell (global-map "C-x m" :exit t)
  ("e" eshell "eshell")
  ("E" (lambda () (interactive) (eshell t)) "new eshell")
  ("s" shell "default shell"))

;; Hydra to navigate errors
(defhydra hydra-error (global-map "M-#")
  "goto-error"
  ("h" first-error "first")
  ("j" next-error "next")
  ("k" previous-error "prev")
  ("v" recenter-top-bottom "recenter")
  ("q" nil "quit"))

;; Catch-all hydra
(defhydra hydra-mkv (:exit t :idle 0.8)
  ("a" org-agenda "agenda")
  ("b" org-mark-ring-goto "back" :exit nil)
  ("e" magit-ediff-dwim "ediff")
  ("E" eval-expression "eval")
  ("f" hydra--universal-argument "C-u" :exit nil :idle 0.8)
  ("g" helm-do-grep-ag "search with ag")
  ("i" ispell-word "spell-check")
  ("q" nil "quit")
  ("v" hydra-avy/body "avy")
  ("y" avy-copy-region "yank region"))

(global-set-key (kbd "C-c m") 'hydra-mkv/body)

;; The avy commands all in one place
(defhydra hydra-avy (:exit t)
  ("j" avy-goto-char "char")
  ("w" avy-goto-word-0 "word-0")
  ("SPC" avy-goto-whitespace-end "ws")
  ("e" avy-goto-word-1 "word-1")
  ("l" avy-goto-line "line")
  ("s" avy-goto-char-timer "timer")
  ("f" helm-find-files)
  ("q" nil))

(global-set-key (kbd "C-;") 'hydra-avy/body)

;; Making helm a little easier to use with a hydra
(defhydra helm-like-unite (:hint nil :color pink)
  "
Nav ^^^^^^^^^        Mark ^^          Other ^^       Quit
^^^^^^^^^^------------^^----------------^^----------------------
_K_ ^ ^ _k_ ^ ^     _m_ark           _v_iew         _i_: cancel
^↕^ _h_ ^✜^ _l_     _t_oggle mark    _H_elp         _q_: quit
_J_ ^ ^ _j_ ^ ^     _U_nmark all     _f_ollow: %(helm-attr 'follow)
^^^^^^^^^^ 
"
  ;; arrows
  ("h" helm-beginning-of-buffer)
  ("j" helm-next-line)
  ("k" helm-previous-line)
  ("l" helm-end-of-buffer)
  ;; beginning/end
  ("g" helm-beginning-of-buffer)
  ("G" helm-end-of-buffer)
  ;; scroll
  ("K" helm-scroll-other-window-down)
  ("J" helm-scroll-other-window)
  ;; mark
  ("m" helm-toggle-visible-mark)
  ("t" helm-toggle-all-marks)
  ("U" helm-unmark-all)
  ;; exit
  ("<escape>" keyboard-escape-quit "" :exit t)
  ("o" keyboard-escape-quit :exit t)
  ("i" nil)
  ;; sources
  ("}" helm-next-source)
  ("{" helm-previous-source)
  ;; rest
  ("H" helm-help)
  ("v" helm-execute-persistent-action)
  ("f" helm-follow-mode)
  ("q" hydra-keyboard-quit
   :exit t))

(define-key helm-map (kbd "C-o") 'helm-like-unite/body)

;; Adding some of the more obscure helm stuff to a hydra
(defhydra hydra-helm (global-map "C-c j" :exit t)
  ("a" helm-apropos "apropos")
  ("g" helm-do-grep-ag "grep")
  ("i" helm-imenu "imenu")
  ("l" helm-locate "locate")
  ("m" helm-man-woman "man page")
  ("r" helm-recentf "recent files")
  ("t" helm-top "top"))

;; A complementary binding to the apropos-command (C-h a)
(define-key 'help-command "A" 'apropos)

(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)


;; kill lines backwards with a useful keybinding
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

;; Make ibuffer a thing I use
(global-set-key (kbd "C-x M-b") 'ibuffer)

;; Text completion/correction hydra
(defhydra hydra-textc (global-map "C-c t" :exit t)
  ("n" flyspell-goto-next-error "next error")
  ("s" ispell-word "spellcheck")
  ("c" helm-company "company")
  ("e" hippie-expand "expand" :exit nil)
  ("q" nil))

;; Also give me a shortcut for the most common ones

(global-set-key (kbd "C-=") 'ispell-word)
(global-set-key (kbd "M-=") 'hippie-expand)

;; making things work like MacOS
(global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-S") 'write-file)
(global-set-key (kbd "s-q") 'save-buffers-kill-emacs)

;; making dired a little nicer
(define-key dired-mode-map (kbd "<left>") 'dired-up-directory)
(define-key dired-mode-map (kbd "<right>") 'dired-find-file)

;; Go to other windows easily with one keystroke =s-something=
(defun vsplit-last-buffer ()
  "Split the last buffer in half vertically."
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer))

(defun hsplit-last-buffer ()
  "Split the last buffer in half horizontally."
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer))

;; Make closing Emacs windows like closing tabs in a web browser
(defun mkv-close-current-window ()
  "Close the current window, even if it's the only one."
  (interactive)
  (cond ((and (one-window-p) (not (daemonp))) (save-buffers-kill-emacs))
	((and (one-window-p) (daemonp)) (delete-frame))
	(t (delete-window))))

(global-set-key (kbd "s-T") 'vsplit-last-buffer)
(global-set-key (kbd "s-t") 'hsplit-last-buffer)
(global-set-key (kbd "s-W") (kbd "C-x 1"))
(global-set-key (kbd "s-w") 'mkv-close-current-window)

(define-key key-translation-map (kbd "<s-mouse-1>") (kbd "<mouse-2>"))

(provide 'mkv-keybindings)

;;; mkv-keybindings.el ends here
