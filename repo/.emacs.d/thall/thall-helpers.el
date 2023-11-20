;;; package --- Helper functions.

;;; Commentary:
; TODO: Add some

;;; Code:

(defun thall-load-if-exists (file)
  "Load FILE if it exists."
  (when (file-exists-p file)
    (load file)))

(defun load-externals ()
  "Load LIST of files, reporting any missing files.
Uses `mapc' and `file-exists-p'."
  (mapc #'thall-load-if-exists thall-loadlist))

(provide 'thall-helpers)
;;; thall-helpers.el ends here
