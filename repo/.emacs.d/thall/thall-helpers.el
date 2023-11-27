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
\'some-package \"C-c a\" \'some-command some-keymap)"
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

(defun list-active-modes (&optional return-list)
  "Display all active modes in new scratch buffer \'*modelist-scratch*'.
Optionally, if RETURN-LIST is non-nil, return the list of modes instead."
  (interactive)
  (let ((modes (mapcar 'symbol-name minor-mode-list)))
    (if return-list
      modes)
    (with-current-buffer (get-buffer-create "*modelist-scratch*")
	(erase-buffer)
	(insert "ACTIVE MODES:\n")
	(dolist (mode (sort modes 'string<))
	  (insert (format "%s\n" mode)))
	(pop-to-buffer "*modelist-scratch*") (goto-char (point-min)))))

(defun reload-emacs-config ()
  "Check if theme buffer has changed and save it; then reload `.emacs'."
  (interactive)
  ;; Check if theme has unsaved changes
  (let ((theme-buffer (cl-find-if (lambda (buf)
                                     (and (buffer-file-name buf)
                                          (string-suffix-p "-theme.el" (buffer-file-name buf))))
                                   (buffer-list))))
    (if theme-buffer
        ;; Found buffer; check if modified
        (if (buffer-modified-p theme-buffer)
            (progn
              (save-buffer theme-buffer)
              (message "Saved modified theme file: %s" (buffer-file-name theme-buffer))))

      ;; Reload .emacs
      (load-file "~/.emacs")
      (message "Reloaded .emacs"))))

(provide 'thall-helpers)
;;; thall-helpers.el ends here
