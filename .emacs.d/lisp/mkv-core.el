;;; mkv-core --- package configurations
;;; Commentary:

;;; Code:

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package ace-window
  :bind (("C-." . ace-window)
	 ([remap other-window] . ace-window))
  :config (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :diminish)

(use-package anzu
  :bind (("M-%" . anzu-query-replace)
	 ("C-M-%" . anzu-query-replace-regexp))
  :diminish anzu-mode
  :init
  (global-anzu-mode t)
  (setq query-replace-highlight t)
  (setq search-highlight t)
  (setq anzu-cons-mode-line-p nil))

(use-package avy
  :bind
  (("C-:" . avy-goto-char)
   ("C-'" . avy-goto-char-timer)
   ("M-g g" . avy-goto-line)
   ("M-g w" . avy-goto-word-1))
  :config (define-key isearch-mode-map (kbd "C-'") 'avy-isearch))

(use-package browse-kill-ring
  :bind (("C-M-y" . browse-kill-ring)))

(use-package cdlatex
  :config
  (substitute-key-definition 'cdlatex-pbb nil cdlatex-mode-map)
  (substitute-key-definition 'cdlatex-dollar nil cdlatex-mode-map)
  :defer t)

(use-package company
  :config (setq company-global-modes t)
  :diminish company-mode
  :defer t
  :hook (after-init-hook . global-company-mode))

(use-package company-auctex
  :after (company)
  :config (company-auctex-init)
  :hook ((TeX-mode LaTeX-mode) . company-mode))

(use-package diff-hl
  :config (global-diff-hl-mode)
  :defer t)

(use-package diminish
  :defer t)

(use-package dired-x
  :ensure nil)

(use-package discover-my-major
  :bind (("C-h C-m" . discover-my-major)))

(use-package flycheck
  :defer t
  :init (global-flycheck-mode))

(use-package flyspell
  :defer t
  :config
  (define-key flyspell-mode-map (kbd "C-.") nil)
  (setq ispell-program-name "aspell"
	ispell-extra-args '("--sug-mode=ultra"))
  :ensure nil)

(use-package helm
  :bind (;; helm alternatives to standard commands
	 ("C-x C-f" . helm-find-files)
	 ("C-x d" . helm-find-files)
	 ("C-x b" . helm-mini)
	 ("C-x C-b" . helm-buffers-list)
	 ("C-x C-d" . helm-find-files)
	 ("C-x f" . helm-for-files)
	 ("M-x" . helm-M-x)
	 ("M-y" . helm-show-kill-ring)

	 ;; project based keybindings
	 ("M-p" . helm-browse-project)
         ("C-x r h" . helm-register)

	 ;; most interesting helm menus are under one prefix
	 ("C-c h h" . helm-mini)
	 ("C-c h i" . helm-info)
	 ("C-c h m" . helm-man-woman)
	 ("C-c h a" . helm-apropos)
	 ("C-c h l" . helm-locate)
	 ("C-c h i" . helm-imenu)
	 ("C-c h t" . helm-top)
	 ("C-c h r" . helm-recentf)
	 ("C-c h w" . helm-google-suggest)
         ("C-c h o" . helm-occur)
         
	 ;; helm internal commands
	 (:map helm-map
	       ("TAB" . helm-execute-persistent-action)
	       ("C-j" . helm-select-action))

	 (:map minibuffer-local-map
	       ("C-c C-l" . helm-minibuffer-history))

	 (:map isearch-mode-map
	       ("C-o" . helm-occur-from-isearch)))
  :config
  (helm-autoresize-mode 1)
  (setq history-length 100)
  (setq history-delete-duplicates t)
  (setq helm-ff-keep-cached-candidates "local")
  (setq helm-ff-refresh-cache-delay 300)
  (setq helm-ff-cache-mode-max-idle-time 300)
  (setq helm-candidate-number-limit 100)
  (setq helm-case-fold-search t)
  (setq helm-man-or-woman-function 'woman)
  (setq helm-split-window-inside-p t)
  :diminish
  :init
  (helm-mode t))

(use-package helm-company
  :after (helm company)
  :bind (("C-c C-," . helm-company))
  :commands (helm-company)
  :init
  (define-key company-mode-map (kbd "C-,") 'helm-company)
  (define-key company-active-map (kbd "C-,") 'helm-company))

(use-package helm-config
  :bind ("C-c h" . helm-command-prefix)
  :ensure nil)

(use-package helm-grep
  :ensure nil)

(use-package helm-descbinds
  :config (helm-descbinds-mode))

(use-package helm-projectile
  :config (helm-projectile-on))

(use-package swiper-helm
  :bind ("s-f" . swiper-helm))

(use-package hl-todo
  :config (global-hl-todo-mode)
  :defer t)

(use-package imenu-anywhere
  :bind (("C-c i" . imenu-anywhere)))

(use-package latex-preview-pane
  :defer t)

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package mkv-elisp
  :ensure nil)

(use-package mkv-latex
  :ensure nil)

(use-package mkv-org-mode
  :ensure nil)

(use-package operate-on-number
  :defer t)

(use-package projectile
  :defer t)

(use-package rainbow-delimiters
  :defer t
  :init
  (progn
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)))

(use-package rainbow-mode
  :defer t
  :diminish
  :init
  (progn
    (add-hook 'prog-mode-hook 'rainbow-mode)))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (require 'smartparens-latex)
  (setq sp-base-key-bindings 'paredit)
  (sp-use-paredit-bindings)
  :diminish smartparens-mode
  :hook
  (text-mode . smartparens-mode))

(use-package solarized-theme)

(use-package smartrep
  :config
  (smartrep-define-key global-map "C-c ."
    '(("+" . apply-operation-to-number-at-point)
      ("-" . apply-operation-to-number-at-point)
      ("*" . apply-operation-to-number-at-point)
      ("/" . apply-operation-to-number-at-point)
      ("\\" . apply-operation-to-number-at-point)
      ("^" . apply-operation-to-number-at-point)
      ("<" . apply-operation-to-number-at-point)
      (">" . apply-operation-to-number-at-point)
      ("#" . apply-operation-to-number-at-point)
      ("%" . apply-operation-to-number-at-point)
      ("'" . operate-on-number-at-point)))
  :defer t)

(use-package spaceline
   :config
   (spaceline-emacs-theme)
   (spaceline-toggle-buffer-encoding-abbrev-off))

(use-package super-save
  :config (super-save-mode +1)
  :defer t
  :diminish)

(use-package tex
  :config
  (setq TeX-source-correlate-method 'synctex)
  (TeX-source-correlate-mode)
  (setq TeX-source-correlate-start-server t)
  :ensure auctex)

(use-package undo-tree
  :config (global-undo-tree-mode)
  :defer t
  :diminish)

(use-package which-key
  :defer t
  :diminish
  :init
  (which-key-mode))

(use-package yasnippet)

(use-package yasnippet-snippets
  :defer t)

(use-package zop-to-char
  :bind ([remap zap-to-char] . zop-to-char))

(provide 'mkv-core)

;;; mkv-core.el ends here
