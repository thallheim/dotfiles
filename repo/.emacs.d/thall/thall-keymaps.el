;;; thall-keymaps.el --- Custom keymaps -*- lexical-binding: t; -*-

;; Author: thall <thall@thallheim.com>
;; Keywords: library, elisp, emacs

;;; Commentary:
;; Keymap collection, to spare myself having a million lines in my init file.

;;; Code:

(defalias 'cdk 'conditionally-define-key "Keep line lengths semi-reasonable.")

;;==========================================================================
;; MULTIPLE-CURSORS
;;==========================================================================
(defvar thall-mc-map (make-sparse-keymap)
  "Custom multiple-cursors keymap.")
(set-keymap-parent thall-mc-map mc/keymap)
(if (fboundp 'multiple-cursors-mode)
    (progn (which-key-add-key-based-replacements "C-c M-c" "thall-mc-prefix")
	   (global-set-key (kbd "C-c M-c") thall-mc-map)))

(cdk 'multiple-cursors "a" 'mc/mark-all-like-this	    thall-mc-map)
(cdk 'multiple-cursors "e" 'mc/edit-lines		    thall-mc-map)
(cdk 'multiple-cursors "n" 'mc/mark-next-like-this	    thall-mc-map)
(cdk 'multiple-cursors "p" 'mc/mark-previous-like-this	    thall-mc-map)
(cdk 'multiple-cursors "w" 'mc/mark-next-like-this-word     thall-mc-map)
(cdk 'multiple-cursors "W" 'mc/mark-previous-like-this-word thall-mc-map)

;;==========================================================================
;; LSP
;;==========================================================================
(defvar thall-lsp-map (make-sparse-keymap)
  "Custom LSP keymap.")
(if (fboundp 'which-key-mode)
    (progn (which-key-add-key-based-replacements "C-<f1>" "thall-lsp-prefix")
	   (global-set-key (kbd "C-<f1>") thall-lsp-map)))
;;; -------------------------------------------- General
(cdk 'lsp-ui "<f1>"	'lsp-ui-doc-glance		  thall-lsp-map)
(cdk 'lsp-ui "C-d"	'lsp-ui-peek-find-definitions	  thall-lsp-map)
(cdk 'lsp-ui "D"	'lsp-ui-doc-toggle		  thall-lsp-map)
(cdk 'lsp-ui "d"	'lsp-describe-thing-at-point	  thall-lsp-map)
(cdk 'lsp-ui "f"	'lsp-ui-doc-focus-frame		  thall-lsp-map)
(cdk 'lsp-ui "r"	'lsp-ui-peek-find-references	  thall-lsp-map)
(cdk 'lsp-ui "i"	'lsp-ui-peek-find-implementation  thall-lsp-map)
(cdk 'flycheck "l"	'flycheck-list-errors		  thall-lsp-map)
;;; -------------------------------------------- rust-analyzer
(with-eval-after-load 'rust-mode
  (cdk 'rust-mode "C-c M-j" 'lsp-rust-analyzer-join-lines	rust-mode-map))
;;==========================================================================
;; HELM
;;==========================================================================
(defvar thall-helm-map (make-sparse-keymap)
  "Custom Helm keymap.")
(if (fboundp 'helm-mode)
    (progn (which-key-add-key-based-replacements "C-c h" "thall-helm-prefix")
  (global-set-key (kbd "C-c h") thall-helm-map)))

(cdk 'helm "a"   'helm-lsp-code-actions	 thall-helm-map)
(cdk 'helm "A"   'helm-apropos			 thall-helm-map)
(cdk 'helm "b"   'helm-mini			 thall-helm-map)
(cdk 'helm "d"   'helm-descbinds		 thall-helm-map)
(cdk 'helm "f"   'helm-find			 thall-helm-map)
(cdk 'helm "F"   'helm-find-files		 thall-helm-map)
(cdk 'helm "g g" 'helm-git-grep		 thall-helm-map)
(cdk 'helm "g l" 'helm-ls-git-ls		 thall-helm-map)
(cdk 'helm "i"   'helm-imenu			 thall-helm-map)
(cdk 'helm "o"   'helm-occur			 thall-helm-map)
(cdk 'helm "M-y" 'helm-show-kill-ring		 thall-helm-map)
(cdk 'helm "O a" 'helm-org-agenda-files-headings thall-helm-map)
(cdk 'helm "p"   'helm-ls-git			 thall-helm-map)
(cdk 'helm "r"   'helm-recentf			 thall-helm-map)
(cdk 'helm "t"   'helm-cmd-t			 thall-helm-map)
(cdk 'helm "x"   'helm-M-x			 thall-helm-map)
;;==========================================================================
;; Commenting
;;==========================================================================
(defvar thall-comment-map (make-sparse-keymap)
  "Keymap for faster commenting.")
(global-set-key (kbd "C-c C-SPC") thall-comment-map)

(define-key thall-comment-map (kbd "C-SPC") 'comment-line)
(define-key thall-comment-map (kbd "SPC")   'uncomment-current-line-or-region)
(define-key thall-comment-map (kbd "r")     'comment-region)

(provide 'thall-keymaps)
;;; thall-keymaps.el ends here
