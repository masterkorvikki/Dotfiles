;;; mkv-keybindings.el --- all the keybindings I like to use

;;; Commentary:

;;; Code:

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x M-m") 'shell)

;; A complementary binding to the apropos-command (C-h a)
(define-key 'help-command "A" 'apropos)

(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)


;; kill lines backwards with a useful keybindings
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

;;; I can never spell
(global-set-key (kbd "C-<") 'ispell-word)

;;; I also hate typing things
(global-set-key (kbd "C->") 'hippie-expand)

;; making things work like MacOS
(global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-S") 'write-file)
(global-set-key (kbd "s-q") 'save-buffers-kill-emacs)

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
