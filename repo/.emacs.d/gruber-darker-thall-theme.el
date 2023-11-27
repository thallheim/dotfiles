;;; gruber-darker-thall.el --- thallheim's version of gruber-darker -*- lexical-binding: t; -*-

;; Author: thall <thall@thallheim.com>
;; URL: https://github.com/thallheim/dotfiles
;; Keywords: theme, thall

;;; Commentary:

;;; Code:

(deftheme gruber-darker-thall
  "Created 2023-04-25. Updated 2023-11-27.

   Colours tweaked from Tsoding's 'gruber-darker' theme and adapted for my
own setup.  See also Tsoding's source at:
   github.com/rexim/gruber-darker-theme/blob/master/gruber-darker-theme.el


   thall.")

(let ()
;;; -------------------------------------------- Main colours
  (defvar thall-black0 "#080808")
  (defvar thall-blue0 "#738ABF")
  (defvar thall-blue1 "#5772B2")
  (defvar thall-gold "#FFD60A")
  (defvar thall-green-1 "#5CA12B")
  (defvar thall-green0 "#00ff5f")
  (defvar thall-green1 "#73c936")
  (defvar thall-green2 "#8FD45E")
  (defvar thall-grey-2 "#303030")
  (defvar thall-grey-1 "#383838")
  (defvar thall-grey0 "#584B52")
  (defvar thall-grey2 "#8F9B95")
  (defvar thall-orange0 "#AE5100")
  (defvar thall-orange1 "#CC5F00")
  (defvar thall-red0 "#c73c3f")
  (defvar thall-teal "#005980")
  (defvar thall-violet1 "#B886BB")
  (defvar thall-white0 "#d4d4d4")
  (defvar thall-yellow0 "#FFFF00")
  (defvar thall-yellow1 "#FFDD33")
;;; -------------------------------------------- Background colours
  (defvar thall-background-2 "#080808")
  (defvar thall-background-1 "#1B1B1B")
  (defvar thall-background0 "#181818")
  (defvar thall-background1 "#282828")
  (defvar thall-background2 "#383838")
;;; -------------------------------------------- Inheriting colours
  (defvar thall-comment thall-orange0)
  (defvar thall-directory thall-blue0)
  (defvar thall-link thall-blue1)
  (defvar thall-link-visited thall-violet1)

  (custom-theme-set-variables
   'gruber-darker-thall
   '(child-frame-border)
   '(indent-tabs-mode nil)
   '(tab-width 4)
   '(fancy-compilation-override-colors nil)
   '(frame-background-mode 'dark)
   '(lsp-ui-doc-border "#FFFFFF")
   '(org-M-RET-may-split-line '((default . nil))) ; move to org-conf
   '(org-fontify-quote-and-verse-blocks t) ; move to org-conf
   '(text-scale-mode-step 1.1) ; move to .emacs
   '(fill-column 80) ; move to .emacs
   '(whitespace-line-column nil)
   '(whitespace-style
     '(face trailing tabs spaces lines-tail newline missing-newline-at-eof
	        empty indentation space-after-tab space-before-tab space-mark tab-mark )) ; removed newline-mark
   ) ;; END (custom-theme-set-variables)

  (custom-theme-set-faces
   'gruber-darker-thall
;;==========================================================================
;; General/misc. faces
;;==========================================================================
   `(default ((t (:family "Iosevka SS05" :height 102 :foreground ,thall-white0 :background ,thall-background0))))
   ;; '(default ((t (:family "Roboto Mono for Powerline" :height 100 :foreground ,thall-white0 :background ,thall-background0))))
   `(italic ((t (:slant italic))))
   `(fixed-pitch ((t (:inherit default :family "Iosevka SS05" :weight normal))))

                                        ;`(child-frame-border ((t (:foreground ,thall-grey0 :background ,thall-grey0))))
   `(border ((t (:background ,thall-background-2 :foreground "#453d41"))))
   `(cursor ((t (:background ,thall-gold))))
   `(error ((t (:foreground ,thall-red0))))
   `(fringe ((t (:background unspecified :foreground "#453d41"))))
   `(vertical-border ((t (:foreground ,thall-black0))))
   `(link ((t (:foreground ,thall-blue1 :underline t))))
   `(link-visited ((t (:foreground ,thall-violet1 :underline t))))
   `(match ((t (:background ,thall-grey0))))
   `(shadow ((t (:foreground "#584B52"))))
   `(minibuffer-prompt ((t (:foreground ,thall-blue0))))
   `(region ((t (:background "#484848" :foreground unspecified))))
   `(secondary-selection ((t (:background "#484848" :foreground unspecified))))
   `(trailing-whitespace ((t (:foreground ,thall-black0 :background ,thall-red0))))
   `(tooltip ((t (:background "#52494e" :foreground ,thall-white0))))
   `(highlight ((t (:foreground ,thall-white0 :background ,thall-teal))))
   `(highlight-current-line-face ((t (:background ,thall-background0 :foreground unspecified))))
   `(line-number ((t (:inherit default :foreground "#52494e"))))
   `(line-number-current-line ((t (:inherit line-number :foreground ,thall-gold))))
   `(info-xref ((t (:foreground ,thall-blue0))))
   `(info-visited ((t (:foreground ,thall-link-visited))))
   `(isearch ((t (:foreground ,thall-black0 :background ,thall-blue0))))
   `(isearch-fail ((t (:foreground ,thall-black0 :background ,thall-red0))))
   `(isearch-lazy-highlight-face ((t (:foreground ,thall-white0 :background ,thall-blue1))))
   `(lazy-highlight-face ((t (:foreground ,thall-white0 :background ,thall-blue1))))
   `(sh-quoted-exec ((t (:foreground ,thall-red0))))
   `(which-func ((t (:foreground ,thall-violet1))))
   `(message-header-name ((t (:foreground ,thall-green1))))
;;==========================================================================
;; Company faces
;;==========================================================================
   `(company-tooltip ((t (:foreground ,thall-grey0 :background ,thall-background1))))
   `(company-tooltip-annotation ((t (:foreground "#cc8c3c" :background ,thall-background-1))))
   `(company-tooltip-annotation-selection ((t (:foreground "#cc8c3c" :background ,thall-background-1))))
   `(company-tooltip-selection ((t (:foreground ,thall-grey-2 :background ,thall-background-1))))
   `(company-tooltip-mouse ((t (:background ,thall-background-1))))
   `(company-tooltip-common ((t (:foreground ,thall-green0))))
   `(company-tooltip-common-selection ((t (:foreground ,thall-green0))))
   `(company-tooltip-scrollbar-thumb ((t (:background ,thall-background-1))))
   `(company-tooltip-scrollbar-track ((t (:background ,thall-grey0))))
   `(company-preview ((t (:background ,thall-green0))))
   `(company-preview-common ((t (:foreground ,thall-green0 :background ,thall-background-1))))
;;==========================================================================
;; Compilation/Fancy compilation faces
;;==========================================================================
   `(compilation-info ((t (:foreground ,thall-green1))))
   `(compilation-warning ((t (:foreground ,thall-orange1 :bold t))))
   `(compilation-error ((t (:foreground ,thall-red0))))
   `(compilation-mode-line-fail ((t (:foreground ,thall-red0 :weight bold))))
   `(compilation-mode-line-exit ((t (:foreground ,thall-green1 :weight bold))))
   `(custom-state ((t (:foreground ,thall-green1))))
   `(diff-removed ((t (:foreground ,thall-red0 :background unspecified))))
   `(diff-added ((t (:foreground ,thall-green1 :background unspecified))))
   `(fancy-compilation-default-face ((t (:background ,thall-background-1))))
;;==========================================================================
;; Dired faces
;;==========================================================================
   `(dired-directory ((t (:foreground ,thall-directory :weight normal))))
   `(dired-header ((t (:foreground ,thall-link :weight normal))))
   `(dired-ignored ((t (:foreground ,thall-grey0))))
;;==========================================================================
;; Eshell faces
;;==========================================================================
   '(eshell-ls-backup ((t (:foreground "#95a99f"))))
   `(eshell-ls-directory ((t (:foreground ,thall-blue0))))
   `(eshell-ls-executable ((t (:foreground ,thall-green1))))
   `(eshell-ls-symlink ((t (:foreground ,thall-gold))))
;;==========================================================================
;; Font-lock faces
;;==========================================================================
   `(font-lock-builtin-face ((t (:foreground ,thall-gold))))
   `(font-lock-comment-face ((t (:inherit fixed-pitch :foreground ,thall-comment))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,thall-orange0))))
   `(font-lock-constant-face ((t (:foreground ,thall-grey2))))
   `(font-lock-doc-face ((t (:foreground ,thall-green2))))
   `(font-lock-doc-string-face ((t (:foreground ,thall-green1))))
   `(font-lock-function-name-face ((t (:foreground ,thall-blue0))))
   `(font-lock-keyword-face ((t (:inherit fixed-pitch :foreground ,thall-gold :bold t))))
   `(font-lock-preprocessor-face ((t (:inherit fixed-pitch :foreground ,thall-grey2))))
   `(font-lock-reference-face ((t (:foreground ,thall-grey-1))))
   `(font-lock-string-face ((t (:inherit fixed-pitch :foreground ,thall-green1))))
   `(font-lock-type-face ((t (:inherit fixed-pitch :foreground ,thall-blue1))))
   `(font-lock-variable-name-face ((t (:foreground ,thall-red0))))
   `(font-lock-warning-face ((t (:foreground ,thall-red0))))
;;==========================================================================
;; Flymake/Flycheck faces
;;==========================================================================
   `(flymake-errline
     ((((supports :underline (:style wave))) (:underline (:style wave :color ,thall-red0) :foreground unspecified :background unspecified :inherit unspecified))
      (t (:foreground ,thall-red0 :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave))) (:underline (:style wave :color ,thall-gold) :foreground unspecified :background unspecified :inherit unspecified))
      (t (:forground ,thall-gold :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave))) (:underline (:style wave :color ,thall-green1) :foreground unspecified :background unspecified :inherit unspecified))
      (t (:forground ,thall-green1 :weight bold :underline t))))
   `(flyspell-incorrect ((((supports :underline (:style wave))) (:underline (:style wave :color ,thall-red0) :inherit unspecified)) (t (:foreground ,thall-red0 :weight bold :underline t))))
   `(flyspell-duplicate ((((supports :underline (:style wave))) (:underline (:style wave :color ,thall-gold) :inherit unspecified)) (t (:foreground ,thall-gold :weight bold :underline t))))
;;==========================================================================
;; Header-line faces
;;==========================================================================
   `(header-line ((t (:background ,thall-background-1))))
;;==========================================================================
;; Helm faces
;;==========================================================================
   `(helm-candidate-number ((t (:background "#453d41" :foreground ,thall-gold :bold t))))
   `(helm-ff-directory ((t (:foreground ,thall-blue1 :background ,thall-background0 :bold t))))
   `(helm-ff-executable ((t (:foreground ,thall-green1))))
   `(helm-ff-dirs ((t (:foreground ,thall-directory :background ,thall-background0 :bold t))))
   `(helm-ff-dotted-directory ((t (:foreground unspecified :background ,thall-background0 :bold t))))
   `(helm-ff-file ((t (:foreground ,thall-white0))))
   `(helm-ff-invalid-symlink ((t (:foreground ,thall-grey-2 :background ,thall-red0))))
   `(helm-ff-symlink ((t (:foreground ,thall-gold :bold t))))
   `(helm-selection-line ((t (:background ,thall-background1))))
   `(helm-selection ((t (:background ,thall-background1 :underline nil :bold t))))
   `(helm-source-header ((t (:foreground ,thall-gold :background ,thall-background0 :box (:line-width -1 :style released-button)))))
;;==========================================================================
;; Ido faces
;;==========================================================================
   `(ido-first-match ((t (:foreground ,thall-yellow1 :bold nil))))
   `(ido-only-match ((t (:foreground ,thall-gold :weight bold))))
   `(ido-subdir ((t (:foreground ,thall-directory :weight bold))))
;;==========================================================================
;; LSP faces
;;==========================================================================
   `(lsp-headerline-breadcrumb-path-face ((t :background ,thall-background1)))
   `(lsp-face-highlight-textual ((t (:inherit highlight :foreground ,thall-white0))))
   `(lsp-ui-doc-background ((t (:background ,thall-background1))))
   `(lsp-ui-peek-filename ((t (:foreground ,thall-white0))))
   `(lsp-ui-peek-highlight ((t (:foreground "#453d41":background ,thall-green1))))
   `(lsp-ui-peek-peek ((t (:inherit lsp-ui-doc-background))))
   `(lsp-ui-peek-selection ((t (:foreground ,thall-gold :background "#606060"))))
;;==========================================================================
;; Magit faces
;;==========================================================================
   `(magit-branch ((t (:foreground ,thall-blue0))))
   `(magit-diff-hunk-header ((t (:background "#453d41"))))
   `(magit-diff-file-header ((t (:background "#52494e"))))
   `(magit-log-sha1 ((t (:foreground ,thall-red0))))
   `(magit-log-author ((t (:foreground ,thall-orange1))))
   `(magit-log-head-label-remote ((t (:foreground ,thall-green1 :background ,thall-background1))))
   `(magit-log-head-label-local ((t (:foreground ,thall-blue0 :background ,thall-background1))))
   `(magit-log-head-label-tags ((t (:foreground ,thall-gold :background ,thall-background1))))
   `(magit-log-head-label-head ((t (:foreground thall-white0 :background ,thall-background1))))
   `(magit-item-highlight ((t (:background ,thall-background1))))
   `(magit-tag ((t (:foreground ,thall-gold :background ,thall-background0))))
   `(magit-blame-heading ((t (:background ,thall-background1 :foreground ,thall-white0))))
;;==========================================================================
;; Mode-line faces
;;==========================================================================
   `(mode-line ((t (:background ,thall-background2 :foreground ,thall-white0))))
   `(mode-line-buffer-id ((t (:background ,thall-background2 :foreground ,thall-yellow0))))
   `(mode-line-inactive ((t (:background ,thall-background2 :foreground ,thall-grey0))))
;;==========================================================================
;; Org faces
;;==========================================================================
   `(org-agenda-structure ((t (:foreground ,thall-blue0))))
   `(org-block-begin-line ((t (:inherit org-meta-line :foreground ,thall-grey-2 :background ,thall-background-1 :extend t))))
   `(org-block ((t (:foreground ,thall-white0 :background ,thall-background0 :extend t))))
   `(org-code ((t (:box (:line-width (1 . 1) :color "light slate gray" :weight bold) :inherit fixed-pitch :foreground ,thall-gold :background ,thall-background1 :extend t))))
   `(org-column ((t (:background ,thall-background-2))))
   `(org-column-title ((t (:background ,thall-background-2 :underline t :weight bold))))
   `(org-document-info ((t (:inherit org-meta-line :foreground ,thall-grey2 ))))
   `(org-document-info-keyword ((t (:inherit org-meta-line))))
   `(org-document-title ((t (:foreground ,thall-green0 :height 1.8 :weight bold :underline t))))
   `(org-done ((t (:foreground ,thall-green1))))
   `(org-level-1 ((t (:foreground ,thall-violet1 :height 1.35 :bold t))))
   '(org-level-2 ((t (:inherit org-level-1 :height 0.875 :bold t))))
   '(org-level-3 ((t (:inherit org-level-2 :height 0.875 :bold t))))
   '(org-level-4 ((t (:inherit org-level-3 :height 0.875 :bold t))))
   '(org-level-5 ((t (:inherit org-level-4 :height 0.875 :bold t))))
   `(org-link ((t (:inherit variable-pitch :foreground ,thall-link :underline t))))
   `(org-meta-line ((t (:foreground ,thall-grey0 :height 0.9))))
   `(org-todo ((t (:foreground ,thall-red0))))
   '(org-tag ((t (:inherit org-meta-line))))
   `(org-upcoming-deadline ((t (:foreground ,thall-gold))))
   `(org-quote ((t (:background ,thall-background1 :slant italic :extend t))))
;;==========================================================================
;; Parentheses faces
;;==========================================================================
   `(show-paren-match ((t (:foreground ,thall-grey0 :background ,thall-blue0 :weight bold))))
   `(show-paren-mismatch-face ((t (:background ,thall-red0))))
;;==========================================================================
;; Speedbar faces
;;==========================================================================
   `(speedbar-directory-face ((t (:foreground ,thall-blue0 :weight bold))))
   `(speedbar-file-face ((t (:foreground ,thall-white0))))
   `(speedbar-highlight-face ((t (:background ,thall-background0))))
   `(speedbar-selected-face ((t (:foreground ,thall-red0))))
   `(speedbar-tag-face ((t (:foreground ,thall-gold))))
;;==========================================================================
;; Tab bar faces
;;==========================================================================
   `(tab-bar ((t (:background ,thall-background2 :foreground ,thall-grey-2))))
   `(tab-bar-tab ((t (:background ,thall-background1 :foreground ,thall-green2 :weight heavy))))
   `(tab-bar-tab-inactive ((t (:background unspecified :foreground "#567A3C" :weight normal :italic t))))
;;==========================================================================
;; Whitespace faces
;;==========================================================================
   `(whitespace-space ((t (:background ,thall-background0 :foreground ,thall-grey-1))))
   `(whitespace-tab ((t (:background ,thall-background0 :foreground ,thall-grey-1))))
   `(whitespace-hspace ((t (:background ,thall-background0 :foreground ,thall-grey0))))
   `(whitespace-line ((t (:background ,thall-background0 :foreground ,thall-red0))))
   `(whitespace-newline ((t (:background ,thall-background0 :foreground ,thall-grey-1))))
   `(whitespace-trailing ((t (:background ,thall-red0 :foreground ,thall-red0))))
   `(whitespace-empty ((t (:background ,thall-gold :foreground ,thall-gold))))
   `(whitespace-indentation ((t (:background ,thall-gold :foreground ,thall-red0))))
   `(whitespace-space-after-tab ((t (:background ,thall-gold :foreground ,thall-gold))))
   `(whitespace-space-before-tab ((t (:background ,thall-orange0 :foreground ,thall-orange0))))
 
   )) ;; END (custom-theme-set-faces)

(provide-theme 'gruber-darker-thall)
;;; gruber-darker-thall-theme.el ends here
