;;; package --- thall.

;;; Commentary:

; - TODOS:
; - Suss out proper platform detection
;   - Remember why I wanted platform detection in the first place.
; - Refactor set-compile-command thing so it's not stupid
; - Set up central dir for backup files (currently disabled because rsync)

;;; Code:

;;==========================================================================
;; USE-PACKAGE
;;==========================================================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
  (add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
  (require 'use-package)
  (setq use-package-always-ensure 't)
;;==========================================================================
;; LOAD THALL
;;==========================================================================
; Load helpers
(defvar thall-hf nil)
(setq thall-hf (expand-file-name "thall/thall-helpers.el" user-emacs-directory))
(when (file-exists-p thall-hf) (load thall-hf)
      (message "thall helpers loaded."))

; Listificate files to be loaded
(defvar thall-loadlist nil)
(let ((thalldir user-emacs-directory))
  (setq thall-loadlist
	(mapcar (lambda (x) (expand-file-name x thalldir))
		'("thall/hydra.el" "thall/org.el" "tree-sitter/sources-alist.el"))))

; Load the ones that are listed (and exist)
(mapc #'thall-load-if-exists thall-loadlist)
;;==========================================================================
;; EXEC PATHS
;;==========================================================================
(setenv "PATH" (concat (getenv "PATH") ":/home/thall/.ghcup/bin"))
(setq lsp-haskell-server-path "/home/thall/.ghcup/bin/haskell-language-server-wrapper")
;;==========================================================================
;; UI/QoL stuff
;;==========================================================================
(load-theme 'gruber-darker-thall t)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(tool-bar-mode     -1)
(menu-bar-mode     -1)
(scroll-bar-mode   -1)
(column-number-mode 1)
(setq-default display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(setq show-paren-mode    1)
(setq show-paren-delay   0)
(add-hook 'text-mode-hook 'visual-line-mode)                          ; Sensible line breaking.
(delete-selection-mode t)                                             ; Overwrite selected text.
(setq scroll-error-top-bottom t)                                      ; Scroll to the first and last line of buffer.
(set-language-environment  "UTF-8")
(set-default-coding-systems 'utf-8)
(put 'upcase-region   'disabled nil)
(put 'downcase-region 'disabled nil)
(repeat-mode 1)
(setq warning-suppress-types '((comp) (comp)))
(defalias 'yes-or-no-p 'y-or-n-p)
(setq make-backup-files nil)                                          ; Suppress backup file creation.
(setq gc-cons-threshold most-positive-fixnum)                         ; Minimize garbage collection during startup.
(add-hook 'emacs-startup-hook                                         ; Lower threshold back to 8 MiB (default is 800kB).
	  (lambda ()
	    (setq gc-cons-threshold (expt 2 23))))

(use-package move-text)
(move-text-default-bindings)                                          ; Move line/region with M-up/M-down.

(use-package fancy-compilation                                        ; Fancy-compilation (colourise & scroll output).
  :commands (fancy-compilation-mode))
  (with-eval-after-load 'compile
    (fancy-compilation-mode))

;;; -------------------------------------------- Beacon
(use-package beacon
  :config
  (setq beacon-blink-duration 0.10)
  (setq beacon-color "#a8a8a8"))
(beacon-mode 1)

;;; -------------------------------------------- side-windows
(setq window-sides-slots '(1 2 2 2)) ; (left, top, right, bottom)
(setq fit-window-to-buffer-horizontally t)
(defvar window-params
  '(window-parameters . ((no-delete-other-windows . t))))

(setq
 display-buffer-alist
 `(("\\*Buffer List\\*" display-buffer-in-side-window
    (side . bottom) (slot . 0) (window-height . fit-window-to-buffer)
    (preserve-size . (nil . t)) ,window-params)
   ("\\*\\(?:help\\|Tags List\\)\\*" display-buffer-in-side-window
    (side . right) (slot . 0) (window-width . 0.50)
    (preserve-size . (t . nil)) ,window-params)
   ("\\*\\(grep\\|Completions\\|Flycheck errors\\)\\*"
    display-buffer-in-side-window
    (side . top) (slot . 1) (preserve-size . (nil . t))
    ,window-params)
   ("\\*\\(?:shell\\|compilation\\)\\*" display-buffer-in-side-window
    (side . top) (slot . -1) (preserve-size . (nil . t))
    ,window-params)))
;;==========================================================================
;; MISC. GLOBAL KEYBINDS
;;==========================================================================
;(global-set-key (kbd "C-M-<f9") (lambda () (interactive) (save-buffer) (recompile) ))
(global-set-key (kbd "C-<f9>") #'compile)
(global-set-key (kbd "<f9>"  ) 'window-toggle-side-windows)
(global-set-key (kbd "M-\""  ) 'mark-word)
(global-set-key (kbd "M-#"   ) 'mc/mark-pop)
(global-set-key (kbd "C-<f5>") 'mc/mark-next-like-this)
(global-set-key (kbd "M-<f5>") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-o"   ) 'other-window)
(global-set-key (kbd "M-p"   ) (lambda () (interactive) (scroll-down 10)))
(global-set-key (kbd "M-n"   ) (lambda () (interactive) (scroll-up 10)))
;;==========================================================================
;; Whitespace-mode
;;==========================================================================
(defun set-up-whitespace-handling ()
  "Hooking for `whitespace-mode'.  Styles and faces defined in theme."
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))
  (add-hook 'c-mode-hook        'set-up-whitespace-handling)
  (add-hook 'c++-mode-hook      'set-up-whitespace-handling)
  (add-hook 'emacs-lisp-mode    'set-up-whitespace-handling)
  (add-hook 'erlang-mode-hook   'set-up-whitespace-handling)
  (add-hook 'haskell-mode-hook  'set-up-whitespace-handling)
  (add-hook 'js2-mode-hook      'set-up-whitespace-handling)
  (add-hook 'lua-mode-hook      'set-up-whitespace-handling)
  (add-hook 'markdown-mode-hook 'set-up-whitespace-handling)
  (add-hook 'rust-mode-hook     'set-up-whitespace-handling)
  (add-hook 'sh-mode-hook	'set-up-whitespace-handling)
  (add-hook 'tuareg-mode-hook   'set-up-whitespace-handling)
  (add-hook 'yaml-mode-hook     'set-up-whitespace-handling)
(global-set-key (kbd "<f7>") 'whitespace-mode)
;;==========================================================================
;; HELM
;;==========================================================================
(use-package helm
  :config
  (setq
   helm-candidate-number-limit 500
   helm-autoresize-max-height 80 ; percentage
   helm-autoresize-min-height 20 ; percentage
   helm-visible-mark-prefix   "✓"
   helm-use-frame-when-more-than-two-windows t
   helm-use-frame-when-no-suitable-window    t))
;;; -------------------------------------------- Helm extensions
(use-package helm-descbinds)
(helm-descbinds-mode)
(use-package helm-ls-git)
;;==========================================================================
;; COMPANY
;;==========================================================================
(use-package company
  :delight
  :bind ("M-§" . 'company-complete)
  :custom
    (company-idle-delay 2) ; how long to wait until popup
    ; (company-begin-commands nil) ; uncomment to disable popup
    (company-minimum-prefix-length 3)
    (global-company-mode t)
  :config
    (setq company-selection-wrap-around     t)
    (setq company-tooltip-align-annotations t)
    (setq company-tooltip-offset-display    'lines)
    (setq company-text-icons-add-background t)
    (setq company-global-modes
	  '(not erc-mode message-mode eshell-mode company-mode tuareg-mode))
    (add-hook 'after-init-hook 'global-company-mode)

  :bind
    (:map company-active-map
      ("C-n" . company-select-next)
      ("C-p" . company-select-previous)
      ("M-<" . company-select-first)
      ("M->" . company-select-last)
      ;("C-c C-h" . lsp-ui-doc-toggle)
      ))

  ;; Company front-end                             ; Incompatible with emacs running in TTY
;    (use-package company-box
;      :hook (company-mode . company-box-mode))
;;==========================================================================
;; LSP
;;==========================================================================
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c §")
  :hook
  (c-mode	 . lsp-deferred)
  (c++-mode	 . lsp-deferred)
  (haskell-mode	 . lsp-deferred)
  (js2-mode	 . lsp-deferred)
  (lua-mode	 . lsp-deferred)
  (rust-mode	 . lsp-deferred)
;  (sh-mode	 . lsp-deferred)
  (tuareg-mode	 . lsp-deferred)
  (yaml-mode	 . lsp-deferred)
  (lsp-mode . lsp-enable-which-key-integration)
  :commands
  lsp lsp-deferred
  :custom
  (lsp-inlay-hint-enable t)
  (lsp-eldoc-render-all  t)
;;; -------------------------------------------- rust-analyzer
(defalias 'lra 'lsp-rust-analyzer "Keep line lengths semi-reasonable.")
  (lra-display-chaining-hints				   t)
  (lra-display-closure-return-type-hints		   t)
  (lra-display-lifetime-elision-hints-enable		   "skip_trivial")
  (lra-display-lifetime-elision-hints-use-parameter-names  nil)
  (lra-display-parameter-hints				   t)
  (lra-display-reborrow-hints				   t)
) ;; END (user-package lsp-mode)
;;; -------------------------------------------- LSP extensions
(use-package lsp-ui
  :commands
  lsp-ui-mode)
(use-package helm-lsp
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol))
;;==========================================================================
;; Yasnippet
;;==========================================================================
(use-package yasnippet
  :config
    (yas-reload-all)
    (add-hook 'prog-mode-hook 'yas-minor-mode)
    (add-hook 'text-mode-hook 'yas-minor-mode))
    (yas-global-mode 1)
;;==========================================================================
;; Electric pairs
;;==========================================================================
(add-hook 'prog-mode-hook 'electric-pair-local-mode)
;;==========================================================================
;; IDO
;;==========================================================================
(use-package ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)
; Display ido results vertically
;(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;;==========================================================================
;; SMEX
;;==========================================================================
(use-package smex)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ; This is your old M-x.
  (global-set-key (kbd "C-c M-c M-x") 'execute-extended-command)
;;==========================================================================
;; FLYCHECK
;;==========================================================================
(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (define-key flycheck-mode-map flycheck-keymap-prefix nil)
  ;(setq flycheck-keymap-prefix (kbd "C-c f"))
  (setq flycheck-keymap-prefix (kbd "C-<f4>"))
  (define-key flycheck-mode-map flycheck-keymap-prefix
              flycheck-command-map))

;;; -------------------------------------------- Flycheck hooks
(flycheck-add-mode 'javascript-eslint 'js2-mode)
;;==========================================================================
;; WEB-MODE | JS/JSX
;;==========================================================================
(use-package web-mode)
(use-package js2-mode)
(setq js-indent-level 2)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
;(setq web-mode-content-types-alist '(("jsx")))
;;==========================================================================
;; WHICH-KEY
;;==========================================================================
(use-package which-key
    :config
      (which-key-mode 1)
      (setq which-key-idle-delay 0.75
	    which-key-idle-secondary-delay 0.5)
      (which-key-setup-side-window-bottom)
    :hook (
      (c-mode            . lsp-deferred)
      (c++-mode          . lsp-deferred)
      (haskell-mode      . lsp-deferred)
      (emacs-lisp-mode   . which-key-mode))
    )
;;==========================================================================
;; MACROS | FUNCTIONS
;;==========================================================================
(fset 'copy-line-to-new-line
      (kmacro-lambda-form [?\C-a ?\C-  ?\C-e ?\M-w return ?\C-y] 0 "%d"))
(global-set-key (kbd "C-c C-S-l") 'copy-line-to-new-line)

(defun add-todo-highlighting ()
  "Extra highlighting for keywords in comment lines (\"TODO\", \"FIXME\", etc.)."
  (font-lock-add-keywords nil
   '(("\\<\\(TODO\\|FIXME\\):" 1 font-lock-warning-face prepend))))
  (add-hook 'prog-mode-hook 'add-todo-highlighting t)

(defun kill-unmodified-non-system-buffers ()
  "Kill all unmodified non-system buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (string-match-p "\\*" (buffer-name buffer))
      (kill-buffer-if-not-modified buffer)))
  (message "Killed unmodified non-system buffers."))

(global-set-key (kbd "C-x M-k") 'kill-unmodified-non-system-buffers)

(defun revert-current-buffer-no-prompt()
  "Revert (reload from file) the current buffer.
Does *not* prompt for confirmation.  Reports in minibuffer when reverting."
  (interactive)
  (revert-buffer nil t t)
  (message (concat "Buffer reverted: " (buffer-name))))
(global-set-key (kbd "<f6>") 'revert-current-buffer-no-prompt)

(defun uncomment-current-line-or-region ()
  "Uncomment current line, or region if active."
  (interactive)
  (if (use-region-p)
      (uncomment-region (region-beginning) (region-end))
    (uncomment-region (line-beginning-position) (line-end-position)))
  (message "Uncommented line/region."))
;;==========================================================================
;; DEFAULT COMPILE COMMANDS
;;==========================================================================
(set-compile-command 'rust-mode "cargo check")
(set-compile-command 'haskell-mode "cabal build")
(set-compile-command 'tuareg-mode "dune build")
;;==========================================================================
;; ONE-LINER LOADS
;;==========================================================================
(use-package magit)
(use-package multiple-cursors)
(use-package tuareg)
;;==========================================================================
;; RAINBOWS
;;==========================================================================
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode :delight " rnbw"
  :hook
  (prog-mode . rainbow-mode))
;;==========================================================================
;; DELIGHT
;;==========================================================================
(use-package delight)
(delight '(
	   (abbrev-mode " Abv" abbrev)
	   (company-mode)
	   (company-box-mode)
	   (eldoc-mode nil t)
	   (lsp-lens-mode nil lsp-mode)
	   (merlin-mode nil)
	   (tuareg-mode " Trg" :major)     ;TODO: Why u no work
	   (utop-minor-mode)
	   (markdown-mode " md")
	   (which-key-mode)
	   (whitespace-mode " ws")
	   (yas-minor-mode nil yasnippet)
	   ))
;;==========================================================================
;; ORG-AI
;;==========================================================================
(use-package org-ai
  :commands (org-ai-mode org-ai-global-mode)
  :init
  (add-hook 'org-mode-hook #'org-ai-mode)
  (org-ai-global-mode)
  :config
  (setq org-ai-default-chat-model "gpt-3.5-turbo")
  (org-ai-install-yasnippets))
;;==========================================================================
;; KEYMAPS
;;==========================================================================
(thall-load-if-exists (expand-file-name "thall/thall-keymaps.el" user-emacs-directory))

;;==========================================================================
;; OPAM auto-config
;;==========================================================================
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

(message "thall.")

(provide '.emacs)
;;; .emacs ends here
