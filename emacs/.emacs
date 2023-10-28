;-i TODOS:
; - Suss out proper platform detection
;   - Remember why I wanted platform detection in the first place.
; - Refactor set-compile-command thing so it's not stupid
; - Set up central dir for backup files (currently disabled because rsync)
;   
; -----------------------------------------------------------------------
;
;; ====================  USE-PACKAGE
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


;; ====================  EXTERNAL CONFIGS
(setq hydra-config (expand-file-name "thall/hydra.el" user-emacs-directory))
(when (file-exists-p hydra-config)
  (load hydra-config))

(setq org-config (expand-file-name "thall/org.el" user-emacs-directory))
(when (file-exists-p org-config)
  (load org-config))

 ; tree-sitter lang sources
(setq ts-sources (expand-file-name "tree-sitter/sources-alist.el" user-emacs-directory))
(when (file-exists-p ts-sources)
  (load ts-sources))
 

;; ====================  EXEC PATHS
(setenv "PATH" (concat (getenv "PATH") ":/home/robin/.ghcup/bin"))
(setq lsp-haskell-server-path "/home/robin/.ghcup/bin/haskell-language-server-wrapper")


;; ====================  UI/QoL stuff
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
(use-package rainbow-mode :delight " rnbw")
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

; --------------------------------------------- side-windows
(setq window-sides-slots '(0 0 2 2)) ; (left, top, right, bottom)
(add-to-list 'display-buffer-alist
	     `(,(rx (| "*compilation*" "*grep*" ))
            display-buffer-in-side-window
            (side . bottom)
            (slot . 0)
	    (window-height . 80)
	    (preserve-size . (t . nil))
            ;(window-width . fit-window-to-buffer)
	    (window-parameters . ((no-delete-other-windows . t)))
	    ))

(add-to-list 'display-buffer-alist
	     `(,(rx (| "*eshell*"))
            display-buffer-in-side-window
            (side . right)
            (slot . 0)
            (window-parameters . ((no-delete-other-windows . t)))
            (window-width . 80)))

(add-to-list 'display-buffer-alist
         `("^test[-_]"
           display-buffer-in-direction
           (direction . right)))


;; ====================  MISC. KEYBINDS
(global-set-key (kbd "<f9>"    ) #'compile)
(global-set-key (kbd "C-<f9>"  ) 'window-toggle-side-windows)
(global-set-key (kbd "C-M-<f9>") (lambda () (interactive) (save-buffer) (recompile) ))
(global-set-key (kbd "M-\""    ) 'mark-word)
(global-set-key (kbd "M-#"     ) 'mc/mark-next-like-this-word)
(global-set-key (kbd "M-SPC"   ) 'set-mark-command)                     ; C-SPC is no bueno when emacs runs under tmux over ssh (Windows OpenSSH issue)
(global-set-key (kbd "C-c ,"   ) 'comment-line)
(global-set-key (kbd "C-c ."   ) 'comment-region)
(global-set-key (kbd "C-c SPC" ) 'cycle-spacing)
(global-set-key (kbd "C-c f b" ) 'flymake-show-buffer-diagnostics)
(global-set-key (kbd "C-c f P" ) 'flymake-show-project-diagnostics)
(global-set-key (kbd "C-c f n" ) 'flymake-goto-next-error)
(global-set-key (kbd "C-c f p" ) 'flymake-goto-previous-error)
(global-set-key (kbd "M-o"     ) 'other-window)


;; ====================  Whitespace mode
(defun set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))
  (add-hook 'c-mode-hook        'set-up-whitespace-handling)
  (add-hook 'c++-mode-hook      'set-up-whitespace-handling)
  (add-hook 'emacs-lisp-mode    'set-up-whitespace-handling)
  (add-hook 'erlang-mode-hook   'set-up-whitespace-handling)
  (add-hook 'haskell-mode-hook  'set-up-whitespace-handling)
  (add-hook 'lua-mode-hook      'set-up-whitespace-handling)
  (add-hook 'markdown-mode-hook 'set-up-whitespace-handling)
  (add-hook 'nim-mode-hook      'set-up-whitespace-handling)
  (add-hook 'tuareg-mode-hook   'set-up-whitespace-handling)
  (add-hook 'yaml-mode-hook     'set-up-whitespace-handling)
(global-set-key (kbd "<f7>") 'whitespace-mode)


;; ====================  HELM
(use-package helm
  :config
    (setq 
       helm-autoresize-max-height "80"
       helm-autoresize-min-height "20"
       helm-visible-mark-prefix   "✓"))
(global-set-key (kbd "C-c h a")   'helm-org-agenda-files-headings)
(global-set-key (kbd "C-c h b")   'helm-mini)
(global-set-key (kbd "C-c h t")   'helm-cmd-t)
(global-set-key (kbd "C-c h f")   'helm-find)
(global-set-key (kbd "C-c h F")   'helm-find-files)
(global-set-key (kbd "C-c h g g") 'helm-git-grep)
(global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
(global-set-key (kbd "C-c h i  ") 'helm-imenu)
(global-set-key (kbd "C-c h r")   'helm-recentf)
(global-set-key (kbd "C-c h o")   'helm-occur)
(global-set-key (kbd "C-c h M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h x")   'helm-M-x)


;; ====================  COMPANY
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


;; ====================  Yasnippet
(use-package yasnippet
  :config
    (yas-reload-all)
    (add-hook 'prog-mode-hook 'yas-minor-mode)
    (add-hook 'text-mode-hook 'yas-minor-mode))
    (yas-global-mode 1)
  

;; ====================  IDO
(use-package ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)
; Display ido results vertically
;(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))


;; ====================  Smex
(use-package smex)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ; This is your old M-x.
  (global-set-key (kbd "C-c M-c M-x") 'execute-extended-command)  


;; ====================  LSP HOOKS N' THINGS
;(define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol)
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c '")

  :hook (
    (c++-mode              . lsp-deferred)
    (c-mode                . lsp-deferred)
    (cmake-mode            . lsp-deferred)
    (haskell-mode          . lsp-deferred)
    (haskell-literate-mode . lsp-deferred)
    (tuareg-mode           . lsp-deferred)
    (lsp-mode . lsp-enable-which-key-integration))

  :commands
    (lsp lsp-deferred))

  (use-package lsp-haskell)

  ;; extensions
  (use-package lsp-ui :commands lsp-ui-mode)
  (use-package helm-lsp :commands helm-lsp-workspace-symbol)

  
  (use-package lsp-ui
    :commands lsp-ui-mode
    :custom
      ;(setq lsp-ui-peek-always-show t)
      (setq lsp-ui-sideline-show-hover t)
      (setq lsp-ui-headerline-breadcrumb-enable nil)
    :bind
      ("C-c M-c d" . lsp-ui-doc-glance)
      ("C-c M-c f" . lsp-ui-doc-focus-frame))
      ;(lsp-ui-doc-enable t)


;; ====================  which-key
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


;; ====================  MULTIPLE-CURSORS
(use-package multiple-cursors)
(global-set-key (kbd "C-c M-c e")   'mc/edit-lines)
(global-set-key (kbd "C-c M-c n")   'mc/mark-next-like-this)
(global-set-key (kbd "C-c M-c p")   'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-<next>")  'mc/mark-next-like-this)
(global-set-key (kbd "C-M-<prior>") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c M-c a")   'mc/mark-all-like-this)
(global-set-key (kbd "C-c M-c w")   'mc/mark-next-like-this-word)


;; ====================  MACROS/FUNCTIONS
(fset 'copy-line-to-new-line
   (kmacro-lambda-form [?\C-a ?\C-  ?\C-e ?\M-w return ?\C-y] 0 "%d"))
(global-set-key (kbd "C-c C-S-l") 'copy-line-to-new-line)

(defun add-todo-highlighting ()
  "Extra highlighting for keywords in comment lines (\"TODO\", \"FIXME\", etc.)"
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
Does *not* prompt for confirmation. Reports in minibuffer when reverting."
  (interactive) 
  (revert-buffer nil t t)
  (message (concat "Buffer reverted: " (buffer-name))))
(global-set-key (kbd "<f6>") 'revert-current-buffer-no-prompt)


;; ====================  DEFAULT COMPILE COMMANDS
 ;    TODO: Refactor to something less stupid.
 ;          Currently only runs on first load of a given mode.
 ;          Ideally this will be done by polling the active major mode
 ;          upon switching buffers.

(defun set-compile-command-ocaml()
  "Set default compile command for the `dune' build system."
  (setq compile-command "dune build"))
(add-hook 'tuareg-mode-hook 'set-compile-command-ocaml)

(defun set-compile-command-haskell()
  "Set default compile command for the `cabal' build system."
  (setq compile-command "cabal build"))
(add-hook 'haskell-mode-hook 'set-compile-command-haskell)


;; ====================  ONE-LINER LOADS
(use-package magit)
(use-package tuareg)


;; ====================  DELIGHT
(use-package delight)
(delight '(
	   (abbrev-mode " Abv" abbrev)
	   (company-mode)
	   (company-box-mode)
	   (eldoc-mode nil t)
           ;(flymake-mode " Flmk" flymake) ;TODO: Look into redrawing its [x y z] counter
           (lsp-lens-mode nil lsp-mode)
	   (merlin-mode nil)
	   (tuareg-mode " Trg" :major)     ;TODO: Why u no work
	   (utop-minor-mode)
	   (markdown-mode " md")
	   (which-key-mode)
	   (whitespace-mode " ws")
	   (yas-minor-mode nil yasnippet)
	   ))


;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line


(message "thall.")
