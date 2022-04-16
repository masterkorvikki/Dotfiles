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
  :defer t
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
  :defer t
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
  :bind (("C-," . company-complete))
  :config
  (setq company-global-modes t)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  :defer t
  :diminish company-mode
  :hook
  (after-init . global-company-mode))

(use-package deft
  :config  (setq deft-extensions '("org" "md" "txt" "tex")
		 deft-use-filename-as-title t
		 deft-recursive t
		 deft-directory "/Users/alicesmith/Zettelkasten")
  :defer t
  :ensure t)

(use-package diff-hl
  :bind
  (("C-c s" . diff-hl-show-hunk))
  :defer t
  :hook
  ((dired-mode . diff-hl-dired-mode)
   (after-init . global-diff-hl-mode)))

(use-package diminish)

(use-package dired-x
  :ensure nil)

(use-package flycheck
  :hook
  (prog-mode . flycheck-mode)
  (after-init . global-flycheck-mode))

(use-package flyspell
  :defer t
  :config
  (define-key flyspell-mode-map (kbd "C-.") nil)
  (define-key flyspell-mode-map (kbd "C-;") nil)
  (define-key flyspell-mode-map (kbd "C-,") nil)
  (setq ispell-program-name "aspell"
	ispell-extra-args '("--sug-mode=ultra"))
  :hook (prog-mode . flyspell-prog-mode))

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
         
	 ;; helm internal commands
	 (:map helm-map
	       ("TAB" . helm-execute-persistent-action)
	       ("C-j" . helm-select-action)))
  :config
  (setq helm-autoresize-mode 1)
  (setq history-length 100)
  (setq history-delete-duplicates t)
  (setq helm-candidate-number-limit 100)
  (helm-mode t)
  :diminish)

(use-package helm-config
  :bind ("C-c h" . helm-command-prefix)
  :defer t
  :ensure nil)

(use-package helm-descbinds
  :config (helm-descbinds-mode)
  :defer t)

(use-package helm-grep
  :defer t
  :ensure nil)

(use-package helm-lsp
  :commands helm-lsp-workspace-symbol
  :defer t)

(use-package hydra)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-tex-server 'digestif)
  :defer t
  :hook
  (lsp-modep . lsp-enable-which-key-integration))

(use-package lsp-ui
  :commands lsp-ui-mode
  :defer t)

(use-package magit
  :bind ("C-x g" . magit-status)
  :defer t)

(use-package mkv-editor
  :ensure nil)

(use-package mkv-elisp
  :ensure nil)

(use-package mkv-keybindings
  :after (hydra mkv-core)
  :ensure nil)

(use-package mkv-org-mode
  :ensure nil)

(use-package rainbow-delimiters
  :defer t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :defer t
  :diminish
  :hook
  (prog-mode . rainbow-mode))

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

(use-package smartparens
  :bind (("C-S-f" . sp-forward-slurp-sexp)
	 ("C-S-b" . sp-forward-barf-sexp))
  :config
  (require 'smartparens-config)
  :diminish smartparens-mode
  :hook
  (text-mode . smartparens-mode)
  (prog-mode . smartparens-strict-mode))

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

(use-package undo-tree
  :config (global-undo-tree-mode)
  :defer t
  :diminish)

(use-package which-key
  :defer t
  :diminish
  :init
  (which-key-mode))

(use-package yasnippet
  :defer t
  :hook
  (text-mode . yas-minor-mode-on))

(use-package yasnippet-snippets
  :defer t)

(use-package zetteldeft
  :config
  (zetteldeft-set-classic-keybindings)
  (setq zetteldeft-tag-line-prefix "#+TAGS:")
  :defer t)

;; Clarifying my selected packages while I'm here
(setq package-selected-packages
      '(yasnippet-snippets
	which-key
	undo-tree
	super-save
	rainbow-mode
	rainbow-delimiters
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
