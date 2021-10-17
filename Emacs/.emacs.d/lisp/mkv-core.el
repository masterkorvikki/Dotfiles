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
  (("M-g g" . avy-goto-line))
  :config (define-key isearch-mode-map (kbd "C-'") 'avy-isearch))

(use-package browse-kill-ring
  :bind (("C-M-y" . browse-kill-ring)))

(use-package cdlatex
  :config
  (substitute-key-definition 'cdlatex-pbb nil cdlatex-mode-map)
  (substitute-key-definition 'cdlatex-dollar nil cdlatex-mode-map)
  :defer t)

(use-package company
  :config
  (setq company-global-modes t)
  (global-company-mode)
  :defer nil
  :diminish company-mode)

(use-package company-auctex
  :after (company)
  :config (company-auctex-init)
  :hook ((TeX-mode LaTeX-mode) . company-mode))

(use-package counsel
  :config
  (ivy-mode 1)
  :diminish ivy-mode
  :bind (("s-f" . swiper-isearch)
	 ("C-x b". ivy-switch-buffer)
	 ("C-c o" . counsel-outline)))

(use-package diff-hl
  :bind (("C-c C-M-s" . diff-hl-show-hunk))
  :config (global-diff-hl-mode))

(use-package diminish
  :defer t)

(use-package dired-x
  :ensure nil)

(use-package discover-my-major
  :bind (("C-h C-m" . discover-my-major)))

(use-package flycheck
  :config (global-flycheck-mode))

(use-package flyspell
  :defer t
  :config
  (define-key flyspell-mode-map (kbd "C-.") nil)
  (define-key flyspell-mode-map (kbd "C-;") nil)
  (define-key flyspell-mode-map (kbd "C-,") nil)
  (setq ispell-program-name "aspell"
	ispell-extra-args '("--sug-mode=ultra"))
  :ensure nil)

(use-package helm
  :bind (;; helm alternatives to standard commands
         ("C-x C-b" . helm-buffers-list)
	 ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-for-files)
         ("M-y" . helm-show-kill-ring)
	 ("M-x" . helm-M-x)

	 ;; project based keybindings
	 ("M-p" . helm-browse-project)
         ("C-x r h" . helm-register)
	 
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
  (setq hpistory-delete-duplicates t)
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

(use-package hl-todo
  :config (global-hl-todo-mode))

(use-package hydra
  :defer t)

(use-package hyperbole
  :defer t)

(use-package latex-preview-pane
  :defer t)

(use-package magit
  :bind ("C-x g" . magit-status)
  :defer t)

(use-package mkv-elisp
  :ensure nil)

(use-package mkv-latex
  :ensure nil)

(use-package mkv-org-mode
  :ensure nil)

(use-package mkv-pdf
  :ensure nil)

(use-package mkv-shell
  :ensure nil)

(use-package nov
  :config (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  :defer t)

;; pdf-tools has been installed, I am prepared to fight someone
(pdf-loader-install)

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

(use-package shx
  :config (shx-global-mode 1))

(use-package smartparens
  :bind (( "s-<right>" . sp-forward-slurp-sexp)
	 ("s-<left>" . sp-forward-barf-sexp))
  :config
  (require 'smartparens-config)
  (require 'smartparens-latex)
  :diminish smartparens-mode
  :hook
  (text-mode . smartparens-mode))

(use-package solarized-theme)

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

(use-package xscheme)

(use-package yasnippet)

(use-package yasnippet-snippets
  :defer t)

;; Clarifying my selected packages while I'm here
(setq package-selected-packages
      '(org-plus-contrib
	hyperbole
	pdf-tools
	ob-scheme
	yasnippet-snippets
	which-key
	undo-tree
	super-save
	rainbow-mode
	rainbow-delimiters
	shx
	spaceline
	magit
	latex-preview-pane
	helm-company
	discover-my-major
	diminish
	diff-hl
	company-auctex
	company
	browse-kill-ring
	ace-window
	helm-flycheck
	helm-descbinds
	hl-todo
	helm
	flycheck
	anzu
	auto-package-update
	exec-path-from-shell
	smartparens
	cdlatex
	auctex
	solarized-theme
	use-package))

(provide'mkv-core)

;;; mkv-core.el ends here
