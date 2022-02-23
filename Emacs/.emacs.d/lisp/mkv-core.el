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
  :bind
  (("C-." . ace-window)
   ([remap other-window] . ace-window))
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-dispatch-alist
	'((?x aw-delete-window "Delete Window")
	  (?m aw-swap-window "Swap Windows")
	  (?M aw-move-window "Move Window")
	  (?c aw-copy-window "Copy Window")
	  (?i aw-switch-buffer-in-window "Select Buffer")
	  (?n aw-flip-window)
	  (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	  (?c aw-split-window-fair "Split Fair Window")
	  (?v aw-split-window-vert "Split Vert Window")
	  (?b aw-split-window-horz "Split Horz Window")
	  (?o delete-other-windows "Delete Other Windows")
	  (?? aw-show-dispatch-help)))
  :diminish)

(use-package anzu
  :bind
  (("M-%" . anzu-query-replace)
   ("C-M-%" . anzu-query-replace-regexp))
  :diminish anzu-mode
  :config
  (setq query-replace-highlight t)
  (setq search-highlight t)
  (setq anzu-cons-mode-line-p nil)
  :hook
  (after-init . global-anzu-mode))

(use-package avy
  :config
  (define-key isearch-mode-map (kbd "C-'") 'avy-isearch)
  :defer t)

(use-package cdlatex
  :config
  (substitute-key-definition 'cdlatex-pbb nil cdlatex-mode-map)
  (substitute-key-definition 'cdlatex-dollar nil cdlatex-mode-map)
  :defer t)

(use-package company
  :config
  (setq company-global-modes t)
  (setq company-idle-delay 0.3)
  (setq company-minimum-prefix-length 3)
  :diminish company-mode
  :hook
  (after-init . global-company-mode))

(use-package deft
  :ensure t
  :init
    (setq deft-extensions '("org" "md" "txt" "tex")
          deft-use-filename-as-title t
	  deft-recursive t
	  deft-directory "/Users/alicesmith/Zettelkasten"))

(use-package diff-hl
  :bind
  (("C-c s" . diff-hl-show-hunk))
  :hook
  ((dired-mode . diff-hl-dired-mode)
   (after-init . global-diff-hl-mode)))

(use-package diminish)

(use-package dired-x
  :ensure nil)

(use-package flycheck
  :config (global-flycheck-mode))

(use-package flyspell
  :defer t
  :config
  (define-key flyspell-mode-map (kbd "C-.") nil)
  (define-key flyspell-mode-map (kbd "C-;") nil)
  (define-key flyspell-mode-map (kbd "C-,") nil)
  (setq ispell-program-name "aspell"
	ispell-extra-args '("--sug-mode=ultra")))

(use-package helm
  :bind (;; helm alternatives to standard commands
         ("C-x C-b" . helm-buffers-list)
	 ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-for-files)
         ("C-M-y" . helm-show-kill-ring)
	 ("M-x" . helm-M-x)
	 ("C-c o" . helm-imenu)
	 ("s-f" . helm-occur)
	 ("C-h g" . helm-descbinds)

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
  (setq history-delete-duplicates t)
  (setq helm-candidate-number-limit 100)
  (setq helm-case-fold-search t)
  (setq helm-split-window-inside-p t)
  (helm-mode t)
  :diminish)

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

(use-package hydra)

(use-package lsp-mode
  :commands lsp
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package mkv-editor
  :ensure nil)

(use-package mkv-elisp
  :ensure nil)

(use-package mkv-keybindings
  :after (hydra mkv-core)
  :ensure nil)

(use-package mkv-latex
  :ensure nil)

(use-package mkv-org-mode
  :ensure nil)

(use-package mkv-pdf
  :ensure nil)

(use-package mkv-programming
  :ensure nil)

(use-package mkv-shell
  :ensure nil)

(use-package nov
  :config (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  :defer t)

(use-package rainbow-delimiters
  :defer t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :defer t
  :diminish
  :init
  (progn
    (add-hook 'prog-mode-hook 'rainbow-mode)))

(use-package rustic
  :bind (:map rustic-mode-map
	      ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  (setq rustic-format-on-save t))

(use-package shx
  :config (shx-global-mode 1))

(use-package smartparens
  :bind (("C-S-f" . sp-forward-slurp-sexp)
	 ("C-S-b" . sp-forward-barf-sexp))
  :config
  (require 'smartparens-config)
  :diminish smartparens-mode
  :hook
  (text-mode . smartparens-mode))

(use-package solarized-theme)

(use-package spaceline
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-buffer-encoding-abbrev-off)
  (spaceline-helm-mode))

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

(use-package vterm)

(use-package which-key
  :defer t
  :diminish
  :init
  (which-key-mode))

(use-package xenops)

(use-package yasnippet
  :hook
  (text-mode . yas-minor-mode-on))

(use-package yasnippet-snippets
  :defer t)

(use-package zetteldeft
  :config
  (zetteldeft-set-classic-keybindings)
  (setq zetteldeft-tag-line-prefix "#+TAGS:"))

;; Clarifying my selected packages while I'm here
(setq package-selected-packages
      '(yasnippet-snippets
	which-key
	undo-tree
	super-save
	rainbow-mode
	rainbow-delimiters
	shx
	spaceline
	magit
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

(provide 'mkv-core)

;;; mkv-core.el ends here
