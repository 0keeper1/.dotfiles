;;; START CORE SETTING
(global-display-line-numbers-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(auto-save-visited-mode 1)

(setq make-backup-files nil
      auto-save-visited-interval 30
      frame-title-format "Devil Editor"
      inhibit-startup-screen t
      gc-cons-threshold 100000000
      large-file-warning-threshold 100000000
      idle-update-delay 2
      initial-buffer-choice  nil
      inhibit-startup-message t)
;;; END CORE SETTING

;;; START MAIN CONFIGS

;; START MELPA

(use-package package
  :ensure t
  :config
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  ; (package-initialize)
  ; (package-refresh-contents)
)
;; END MELPA

;; START MODUS-THEME
(use-package modus-themes
  :ensure t
  :config
  (load-theme 'modus-vivendi :no-confirm)
  (setq modus-themes-disable-other-themes t
	modus-themes-bold-constructs t)
  (setq modus-themes-completions
      '((matches . (extrabold underline))
        (selection . (semibold italic)))))
;; END MODUS-THEME

;; START AWESOME-TRAY
(use-package awesome-tray
  :load-path "~/.emacs.d/elpa/awesome-tray/"
  :config
  (awesome-tray-mode)
  (setq awesome-tray-mode-line-active-color "White"))
;; END AWESOME-TRAY

;; START ALL-THE-ICON
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))
;; END ALL-THE-ICON

;; START WHICH-KEY
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-setup-side-window-right))
;; END WHICH-KEY

;; START TREE-SITTER
(use-package tree-sitter
  :ensure t
  :hook (tree-sitter-after-on-hook . tree-sitter-hl-mode)
  :config
  (global-tree-sitter-mode)
  (tree-sitter-require 'rust))

(use-package tree-sitter-langs
  :ensure t)
;; END TREE-SITTER

;; START LSP-MODE
(use-package lsp-mode
  :ensure t
  :hook
  (rusic-mode . lsp)
  (nasm-mode . lsp)
  (python-mode . lsp)
  (lsp-mode . lsp-enable-which-key-integration)
  (c-mode . lsp)
  (C++-mode . lsp)
  (zig-mode . lsp)
  (arduino-mode . lsp)
)
;; END LSP-MODE

;; START RUSTIC (RUST)
(use-package rustic
  :ensure t
  :config
  (setq lsp-inlay-hint-enable t
	rust-format-on-save t))
;; END RUSTIC

;; START ZIG-MODE
(use-package zig-mode
  :ensure t)
;; END ZIG-MODE

;; START ASM-LSP (ASSEMBLY)
(use-package nasm-mode
  :ensure t)
;; END ASM-LSP

;; START PYTHON-MODE (PYTHON)
(use-package python-mode
  :ensure t)
;; END PYTHON-MODE

;; START ARDUINO-MODE
(use-package arduino-mode
  :ensure t)
;; END ARDUINO-MODE

;; START ELCORD
(use-package elcord
  :ensure t
  :config (elcord-mode))
;; END ELCORD

;; START MAGIT
(use-package magit
  :ensure t)
;; END MAGIT

;; START LSP-UI
(use-package lsp-ui
  :ensure t
  :config
  (lsp-ui-doc-mode)
  (setq lsp-ui-doc-show-with-cursor t
	lsp-ui-doc-show-with-mouse 0
	lsp-ui-doc-delay 0.4
	lsp-ui-doc-position 'at-point
	lsp-ui-peek-enable t))
;; END LSP-UI

;; START COMPAY
(use-package company
  :ensure t
  :config
  (company-mode)
  (setq company-tooltip-limit 4
	company-tooltip-align-annotations t
	company-tooltip-annotation-padding 1
	company-tooltip-margin 2
	company-text-icons-add-background t
	company-format-margin-function 'company-text-icons-margin
	company-search-regexp-function 'company-search-words-regexp))
;; END COMPANY

;; START COMPANY-BOX
(use-package company-box
  :ensure t
  :after (company)
  :hook (company-mode . company-box-mode))
;; END COMPANY-BOX

;; START COMPANY-QUICKHELP
(use-package company-quickhelp
  :after (company)
  :ensure t
  :config
  (company-quickhelp-mode)
  (setq company-quickhelp-delay 0.3
	company-quickhelp-color-background "black"
	company-quickhelp-color-foreground "white"
	company-quickhelp-max-lines 8))
;; END COMPANY-QUICKHELP

;; START RTAGS
(use-package rtags
  :ensure t)
;; END RTAGS

;; START FLYCHECK
(use-package flycheck
  :ensure t)
;; END FLYCHECK

;; START HELM
;; (use-package helm
;;   :ensure t
;;   :config
;;   (helm-mode))
;; END HELM

;; START HELM-LSP
;; (use-package helm-lsp
;;   :after (helm lsp-mode)
;;   :ensure t)
;; END HELM-LSP

;; START PROJECTILE
(use-package projectile
  :ensure t
  :config
  (projectile-mode))
;; END PROJECTILE

;; START TREEMACS
(use-package treemacs
  :ensure t
  :config
  (treemacs-git-commit-diff-mode)
  (treemacs-load-theme "wombat")
  (setq treemacs-follow-mode t
	treemacs-filewatch-mode t
	treemacs-fringe-indicator-mode 'always)
  :bind
  (:map global-map
	("M-0" . treemacs-select-window)
	("C-x t 1" . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag))
  )
;; END TREEMACS

;; START TREEMACS-MAGIT
(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)
;; END TREEMACS-MAGIT

;; START LSP-TREEMACS
(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :ensure t)
;; END LSP-TREEMACS

;; START TREEMACS-PROJECTILE
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)
;; END TREEMACS-PROJECTILE

;; START CENTUAR-TABS
(use-package centaur-tabs
  :ensure t
  :demand
  :config
  (centaur-tabs-mode)
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project)
  (setq centaur-tabs-style "alternate"
	centaur-tabs-set-icons t
	centaur-tabs-set-bar 'over
	centaur-tabs-set-close-button nil
	centaur-tabs-label-fixed-length 10
	centaur-tabs-show-new-tab-button t
	centaur-tabs-show-count nil
	centaur-tabs-cycle-scope 'tabs)
  :bind
  (:map global-map
	("M-[" . centaur-tabs-backward)
	("M-]" . centaur-tabs-forward)))
;; END CENTUAR-TABS

;;; END MAIN CONFIGS
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(awesome-tray-mode-line-active-color "#ffffff")
 '(elcord-editor-icon "emacs_icon")
 '(elcord-use-major-mode-as-main-icon t)
 '(inhibit-startup-echo-area-message "")
 '(inhibit-startup-screen nil)
 '(initial-buffer-choice "~/")
 '(initial-scratch-message nil)
 '(package-selected-packages
   '(rtags zig-mode which-key treemacs-projectile tree-sitter-langs rustic python-mode nasm-mode lsp-ui lsp-treemacs helm-lsp flycheck elcord company arduino-mode))
 '(user-emacs-directory-warning nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
