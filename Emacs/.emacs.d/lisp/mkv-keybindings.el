;;; mkv-keybindings.el --- all the keybindings I like to use

;;; Commentary:

;;; Code:

(require 'hydra)

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

;; Adding some of the more obscure helm stuff to a hydra
(defhydra hydra-helm (:exit t)
  ("a" helm-apropos "apropos")
  ("g" helm-do-grep-ag "grep")
  ("i" helm-imenu "imenu")
  ("l" helm-locate "locate")
  ("m" helm-man-woman "man page")
  ("r" helm-recentf "recent files")
  ("t" helm-top "top"))

(global-set-key (kbd "C-c j") 'hydra-helm/body)

;; A complementary binding to the apropos-command (C-h a)
(define-key 'help-command "A" 'apropos)

;; kill lines backwards with a useful keybinding
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

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
