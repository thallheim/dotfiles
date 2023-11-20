;;; thall-keymaps.el --- Custom keymaps -*- lexical-binding: t; -*-

;; Author: thall <thall@thallheim.com>
;; Keywords: library, elisp, emacs

;;; Commentary:
;; Keymap collection, to spare myself having a million lines in my init file.

;;; Code:

;;==========================================================================
;; MULTIPLE-CURSORS
;;==========================================================================
(defvar thall-mc-map (make-sparse-keymap)
  "Custom multiple-cursors keymap.")
(set-keymap-parent thall-mc-map mc/keymap)
(if (fboundp 'multiple-cursors-mode)
    (progn (which-key-add-key-based-replacements "C-c M-c" "thall-mc-prefix")
	   (global-set-key (kbd "C-c M-c") thall-mc-map)))

(conditionally-define-key 'multiple-cursors "e" 'mc/edit-lines thall-mc-map)
(conditionally-define-key 'multiple-cursors "n" 'mc/mark-next-like-this thall-mc-map)
(conditionally-define-key 'multiple-cursors "p" 'mc/mark-previous-like-this thall-mc-map)
(conditionally-define-key 'multiple-cursors "a" 'mc/mark-all-like-this thall-mc-map)
(conditionally-define-key 'multiple-cursors "w" 'mc/mark-next-like-this-word thall-mc-map)
(conditionally-define-key 'multiple-cursors "W" 'mc/mark-previous-like-this-word thall-mc-map)

;;==========================================================================
;; LSP
;;==========================================================================
(defvar thall-lsp-map (make-sparse-keymap)
  "Custom LSP keymap.")
(if (fboundp 'which-key-mode)
    (progn (which-key-add-key-based-replacements "C-<f1>" "thall-lsp-prefix")
	   (global-set-key (kbd "C-<f1>") thall-lsp-map)))

(conditionally-define-key 'lsp-ui "<f1>" 'lsp-ui-doc-glance thall-lsp-map)
(conditionally-define-key 'lsp-ui "<f2>" 'lsp-ui-peek-find-definitions thall-lsp-map)
(conditionally-define-key 'lsp-ui "<f26>" 'lsp-ui-peek-find-references thall-lsp-map)
(conditionally-define-key 'lsp-ui "<f27>" 'lsp-ui-peek-find-implementation thall-lsp-map)
(conditionally-define-key 'flycheck "l"   'flycheck-list-errors thall-lsp-map)
;;==========================================================================
;; HELM
;;==========================================================================
(defvar thall-helm-map (make-sparse-keymap)
  "Custom Helm keymap.")
(if (fboundp 'helm-mode)
    (progn (which-key-add-key-based-replacements "C-c h" "thall-helm-prefix")
  (global-set-key (kbd "C-c h") thall-helm-map)))

(conditionally-define-key 'helm "a"   'helm-org-agenda-files-headings thall-helm-map)
(conditionally-define-key 'helm "b"   'helm-mini thall-helm-map)
(conditionally-define-key 'helm "t"   'helm-cmd-t thall-helm-map)
(conditionally-define-key 'helm "f"   'helm-find thall-helm-map)
(conditionally-define-key 'helm "F"   'helm-find-files thall-helm-map)
(conditionally-define-key 'helm "g g" 'helm-git-grep thall-helm-map)
(conditionally-define-key 'helm "g l" 'helm-ls-git-ls thall-helm-map)
(conditionally-define-key 'helm "i"   'helm-imenu thall-helm-map)
(conditionally-define-key 'helm "r"   'helm-recentf thall-helm-map)
(conditionally-define-key 'helm "o"   'helm-occur thall-helm-map)
(conditionally-define-key 'helm "M-y" 'helm-show-kill-ring thall-helm-map)
(conditionally-define-key 'helm "x"   'helm-M-x thall-helm-map)
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
