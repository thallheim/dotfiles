;;; package --- thall.

;;; Commentary:

; - TODOS:
; - Suss out proper platform detection
;   - Remember why I wanted platform detection in the first place.
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
        (mapcar
         (lambda (x) (expand-file-name x thalldir))
         '("thall/hydra.el" "thall/org.el" "tree-sitter/sources-alist.el"))))

; Load the ones that are listed (and exist)
(mapc #'thall-load-if-exists thall-loadlist)
;;==========================================================================
;; Env. settings
;;==========================================================================
(setenv "PATH" (concat (getenv "PATH")
                       ":/home/thall/.ghcup/bin"))
(setq lsp-haskell-server-path
      "/home/thall/.ghcup/bin/haskell-language-server-wrapper")
(setq epg-gpg-program "/usr/bin/gpg2")
(setenv "GPG_AGENT_INFO" nil)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
;;==========================================================================
;; UI/QoL settings
;;==========================================================================
(load-theme 'gruber-darker-thall t)
(tool-bar-mode     -1)
(menu-bar-mode     -1)
(scroll-bar-mode   -1)
(column-number-mode 1)
(global-display-line-numbers-mode)
(add-hook 'text-mode-hook 'visual-line-mode)                ; Sensible line breaking.
(delete-selection-mode t)                                   ; Overwrite selected text.
(put 'upcase-region   'disabled nil)
(put 'downcase-region 'disabled nil)
(repeat-mode 1)
(add-hook 'emacs-startup-hook                               ; GC threshold (default 800kB).
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default display-line-numbers-type 'relative)
(setq
 ring-bell-function 'ignore
 inhibit-startup-message t
 fill-column 80
 indent-tabs-mode nil                    ; Convert tabs to spaces
 tab-width 4                             ; Set tab size to 4 spaces
 show-paren-mode    1
 show-paren-delay   0
 scroll-error-top-bottom t               ; Scroll to the first and last line of buffer.
 warning-suppress-types '((comp) (comp))
 make-backup-files nil                   ; Suppress backup file creation.
 gc-cons-threshold most-positive-fixnum  ; Minimize garbage collection during startup.
 text-scale-mode-step 1.1)

;;==========================================================================
;; UI/QoL packages
;;==========================================================================
(use-package move-text)
(move-text-default-bindings)
(use-package fancy-compilation
  :commands (fancy-compilation-mode))
  (with-eval-after-load 'compile
    (fancy-compilation-mode))
(use-package helpful)
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)
(global-set-key (kbd "C-c i") #'helpful-at-point)
(global-set-key (kbd "C-h F") #'helpful-function)
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
(global-set-key (kbd "C-<f9>" ) #'compile)
(global-set-key (kbd "<f9>"   ) 'window-toggle-side-windows)
(global-set-key (kbd "M-\""   ) 'mark-word)
(global-set-key (kbd "M-#"    ) 'mc/mark-pop)
(global-set-key (kbd "C-<f4>" ) 'mc/mark-next-like-this)
(global-set-key (kbd "C-<f5>" ) 'mc/mark-previous-like-this)
(global-set-key (kbd "M-o"    ) 'other-window)
;(global-set-key (kbd "C-x M-b") 'dired-find-file-other-window)
(global-set-key (kbd "C-x M-b") 'bookmark-jump-other-window)
(global-set-key (kbd "C-x j"  ) 'duplicate-dwim)
(global-set-key (kbd "M-p"    ) (lambda () (interactive) (scroll-down 10)))
(global-set-key (kbd "M-n"    ) (lambda () (interactive) (scroll-up 10)))
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
  (add-hook 'haskell-mode-hook  'set-up-whitespace-handling)
  (add-hook 'js2-mode-hook      'set-up-whitespace-handling)
  (add-hook 'lua-mode-hook      'set-up-whitespace-handling)
  (add-hook 'markdown-mode-hook 'set-up-whitespace-handling)
  (add-hook 'rust-mode-hook     'set-up-whitespace-handling)
  (add-hook 'sh-mode-hook       'set-up-whitespace-handling)
  (add-hook 'tuareg-mode-hook   'set-up-whitespace-handling)
  (add-hook 'yaml-mode-hook     'set-up-whitespace-handling)
(global-set-key (kbd "<f7>") (lambda () (interactive) (whitespace-mode 'toggle)))
;;==========================================================================
;; HELM
;;==========================================================================
(use-package helm
  :config
  (setq
   helm-candidate-number-limit 1500
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
    (company-idle-delay 3) ; how long to wait until popup
    ; (company-begin-commands nil) ; uncomment to disable popup
    (company-minimum-prefix-length 1)
    (global-company-mode t)
  :config
  (setq company-selection-wrap-around       t
        company-tooltip-limit               10
        company-tooltip-align-annotations   t
        company-tooltip-offset-display      'lines
        company-text-icons-add-background   t
        company-tooltip-width-grow-only     t
        company-global-modes
        '(not erc-mode message-mode eshell-mode company-mode tuareg-mode))
  (add-hook 'after-init-hook 'global-company-mode)

  :bind
  (:map company-active-map
        ;("<tab>" . company-complete-selection)
        ("<tab>" .  #'company-indent-or-complete-common)
        ("C-n"   . company-select-next)
        ("C-p"   . company-select-previous)
        ("M-<"   . company-select-first)
        ("M->"   . company-select-last)))
        ;("C-c C-h" . lsp-ui-doc-toggle)
;; (:map lsp-mode-map
;; ("<tab>" . company-indent-or-complete-common)))

;;; -------------------------------------------- Company front-end
; (Incompatible with emacs running in TTY)
;    (use-package company-box
;      :hook (company-mode . company-box-mode))
;;; -------------------------------------------- Handle whitespace in company overlay
(defvar wsm-initially-on nil
  "Stores whether `whitespace-mode' was initially on.
Used by `wsm-off' and `wsm-on'.")

(defun wsm-off (&rest _)
  "Temporarily deactivate `whitespace-mode' if company completion is active."
  (setq wsm-initially-on whitespace-mode)
  (when whitespace-mode
    (whitespace-mode -1)))

(defun wsm-on (&rest _)
  "Re-activate `whitespace-mode' when company completion overlay closes."
  (when wsm-initially-on
    (whitespace-mode 1)))

(add-hook 'company-completion-started-hook 'wsm-off)
(add-hook 'company-completion-cancelled-hook 'wsm-on)
(add-hook 'company-completion-finished-hook 'wsm-on)
;;==========================================================================
;; LSP
;;==========================================================================
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c §")
  :hook
  (c-mode	. lsp-deferred)
  (c++-mode	. lsp-deferred)
  (haskell-mode . lsp-deferred)
  (js2-mode	. lsp-deferred)
  (lua-mode	. lsp-deferred)
  (rust-mode	. lsp-deferred)
;  (sh-mode	. lsp-deferred)
  (tuareg-mode	. lsp-deferred)
  (yaml-mode	. lsp-deferred)
  (lsp-mode . lsp-enable-which-key-integration)
  :commands
  lsp lsp-deferred
  :custom
  (lsp-diagnostic-clean-after-change t)
  (lsp-inlay-hint-enable nil) ; (!) NOTE: Bad interaction with lsp-ui-sideline.
  (lsp-eldoc-render-all nil)
  (lsp-lens-enable nil)

;;; -------------------------------------------- rust-analyzer
  (lsp-rust-analyzer-display-chaining-hints                             nil)
  (lsp-rust-analyzer-display-closure-return-type-hints                  t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable              "skip_trivial")
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-parameter-hints                            nil)
  (lsp-rust-analyzer-display-reborrow-hints                             nil)
  (lsp-rust-analyzer-lens-run-enable                                    t)
  (lsp-rust-analyzer-lens-debug-enable                                  t)
  (lsp-rust-analyzer-lens-implementations-enable                        t)
  (lsp-rust-analyzer-lens-references-enable                             t)
  (lsp-rust-analyzer-closing-brace-hints-min-lines                      15)
  (lsp-rust-analyzer-max-inlay-hint-length                              30)
)
;;; -------------------------------------------- LSP extensions
(use-package lsp-ui
  :commands
  lsp-ui-mode
  :custom
  (lsp-ui-doc-enable                    t)
  (lsp-ui-doc-show-with-cursor          nil)
  (lsp-ui-sideline-enable               t) ; (!) Bad interaction w/ lsp lenses.
  (lsp-ui-sideline-show-hover           nil)
  (lsp-ui-sideline-show-diagnostics     t)
  (lsp-ui-sideline-show-code-actions    t)
  (setq lsp-ui-sideline-diagnostic-max-line-length  40 ; Default 100
        lsp-ui-sideline-diagnostic-max-lines        10)

  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

  )
(use-package helm-lsp
  :config
  (define-key lsp-mode-map
              [remap xref-find-apropos] #'helm-lsp-workspace-symbol))
;;==========================================================================
;; Yasnippet
;;==========================================================================
(use-package yasnippet
  :config
  (yas-reload-all)
  (yas-global-mode 1)
  :hook
  (
  (prog-mode-hook . yas-minor-mode)
  (text-mode-hook . yas-minor-mode)))
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
  (setq flycheck-keymap-prefix (kbd "C-c f"))
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

(use-package rainbow-mode :delight
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
