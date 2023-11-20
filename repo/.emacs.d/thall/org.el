;; ==================== ORG-MODE

;; Keybinds
(global-set-key (kbd "C-c l") #'org-insert-heading-respect-content)
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

; TODO keywords
(setq org-todo-keywords
    '((sequence "TODO" "|" "DONE")
      (sequence "STARTED" "HALTED" "|" "DEFERRED")
      (sequence "|" "CANCELLED")))

;; Prettify
(setq org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-image-actual-width '(300))

;; Bulletification
(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package org-bullets
  :config
  (setq org-bullets-bullet-list
	'(
	  ; Large
	  "▶"
	  "►"
	  "◉"
	  "○"
	  "✸"
	  ; ♥ ● ◇ ✚ ✜  ◆ ♠ ♣ ♦ ◆ ◖ ▶
          ;; Small
	  ; ► • ★ ▸
))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
  (add-hook 'org-mode-hook 'variable-pitch-mode)

;; MISC

; Show hidden emphasis markers under point
; TODO: Disabled as of 2023-11-09 -
;	Something's wonky. Neeed to check if it's related to
;	v29, my compilation, my config, or a bug or combo.
;  (use-package org-appear
;    :hook (org-mode . org-appear-mode))
