;;; package --- Helper functions. -*- lexical-binding: t; -*-

;; Author: thall <thall@thallheim.com>
;; Keywords: library, elisp, emacs

;;; Commentary:
; TODO: Add some

;;; Code:

(defun thall-load-if-exists (file)
  "Load FILE if it exists."
  (when (file-exists-p file)
    (load file)))

(defun insert-current-date()
  "Insert current date in active buffer."
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun conditionally-define-key (package key-binding command keymap)
  "Conditionally define KEY-BINDING for COMMAND in KEYMAP if PACKAGE is installed.
Usage: (conditionally-define-key
\='some-package \"C-c a\" \='some-command some-keymap)"
  (if (require package nil 'noerror)
      (define-key keymap (kbd key-binding) command)
    (message "%s not installed - skipped definition" package)))

(defun set-compile-command (mode command)
  "Set buffer-local `compile' command to COMMAND for MODE buffers.
Only acts on newly-visited files; will not touch the compile command if
changed by the user in an open buffer."
  (add-hook (intern (concat (symbol-name mode) "-hook"))
            (lambda ()
              (unless (local-variable-p 'compile-command)
                (setq-local compile-command command)))))


(provide 'thall-helpers)
;;; thall-helpers.el ends here
