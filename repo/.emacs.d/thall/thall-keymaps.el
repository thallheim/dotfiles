;;; thall-keymaps.el --- Custom keymaps -*- lexical-binding: t; -*-

;; Author: thall <thall@thallheim.com>
;; Keywords: library, elisp, emacs

;;; Commentary:
;; Keymap collection, to spare myself having a million lines in my init file.

;;; Code:

;;==========================================================================
;; LSP
;;==========================================================================
(defvar thall-lsp-map (make-sparse-keymap)
  "Custom LSP keymap.")
;(define-prefix-command 'thall-lsp-map)
(define-key thall-lsp-map (kbd "<f1>") 'lsp-ui-doc-glance)
(define-key thall-lsp-map (kbd "l") 'flycheck-list-errors) ; Prefer it to lsp-ui's
(define-key thall-lsp-map (kbd "<f2>") 'lsp-ui-peek-find-definitions)
(define-key thall-lsp-map (kbd "<f26>") 'lsp-ui-peek-find-references)
(define-key thall-lsp-map (kbd "<f27>") 'lsp-ui-peek-find-implementation)
(global-set-key (kbd "C-<f1>") thall-lsp-map)
;;==========================================================================
;; HELM
;;==========================================================================
(defvar thall-helm-map (make-sparse-keymap)
  "Custom Helm keymap.")
(define-key thall-helm-map (kbd "a")   'helm-org-agenda-files-headings)
(define-key thall-helm-map (kbd "b")   'helm-mini)
(define-key thall-helm-map (kbd "t")   'helm-cmd-t)
(define-key thall-helm-map (kbd "f")   'helm-find)
(define-key thall-helm-map (kbd "F")   'helm-find-files)
(define-key thall-helm-map (kbd "g g") 'helm-git-grep)
(define-key thall-helm-map (kbd "g l") 'helm-ls-git-ls)
(define-key thall-helm-map (kbd "i")   'helm-imenu)
(define-key thall-helm-map (kbd "r")   'helm-recentf)
(define-key thall-helm-map (kbd "o")   'helm-occur)
(define-key thall-helm-map (kbd "M-y") 'helm-show-kill-ring)
(define-key thall-helm-map (kbd "x")   'helm-M-x)
(global-set-key (kbd "C-c h") thall-helm-map)


(provide 'thall-keymaps)
;;; thall-keymaps.el ends here
