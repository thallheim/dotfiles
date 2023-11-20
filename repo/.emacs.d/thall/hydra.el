;; ######################### >> HYDRA
(use-package hydra)
(defhydra hydra-jump-to-directory
  (:color amaranth)
  "Jump to directory"
  ("h" (find-file "~/") "Home")
  ("c" (find-file "~/code") "CODE")
  ("o" (find-file "~/orgfiles") "Org-files")
  ("w" (find-file "~/code/haskell") "Haskell")
  ("q" nil "Quit" :color blue)
  )
(global-set-key (kbd "C-c 1") 'hydra-jump-to-directory/body)

;; YASnippets
(defhydra hydra-yasnippet (:color blue :hint nil)
  "
              ^YASnippets^
#########################-------------------
  Modes:    Load/Visit:    Actions:

 _g_lobal  _d_irectory    _i_nsert
 _m_inor   _f_ile         _t_ryout
 _e_xtra   _l_ist         _n_ew
         _a_ll
"
  ("d" yas-load-directory)
  ("e" yas-activate-extra-mode)
  ("i" yas-insert-snippet)
  ("f" yas-visit-snippet-file :color blue)
  ("n" yas-new-snippet)
  ("t" yas-tryout-snippet)
  ("l" yas-describe-tables)
  ("g" yas/global-mode)
  ("m" yas/minor-mode)
  ("a" yas-reload-all)
  ("q" nil "Quit" :color blue))
(global-set-key (kbd "C-c 9") 'hydra-yasnippet/body)

;;  TABS
(defhydra hydra-tabs (:color amaranth)
  "Less stretchy tab handling"
  ("1" tab-previous "Previous tab")
  ("2" tab-new "New tab")
  ("3" tab-next "Next tab")
  ("0" tab-close "Kill tab")
  ("q" nil "Quit" :color blue))
(global-set-key (kbd "C-c 3") 'hydra-tabs/body)

;; TEXT SCALING
(defhydra hydra-text-scale (global-map "<f5>")
  "Text-scale adjustment."
  ("+" text-scale-increase "in")
  ("-" text-scale-decrease "out"))
(global-set-key (kbd "C-c M-h +") 'hydra-text-scale/body)

;;  WINDOW HANDLING
; Sizing
(defhydra hydra-window (:color amaranth)
  "Window size handling"
  ("1" shrink-window "Shrink window")
  ("2" enlarge-window "Enlarge window")
  ("3" balance-windows "Balance windows")
  ("4" shrink-window-horizontally "Shrink window horizontally")
  ("5" enlarge-window-horizontally "Enlarge window horizontally")
  ("q" nil "Quit" :color blue))
(global-set-key (kbd "C-c 2") 'hydra-window/body)

;; SYSTEM & MISC
(defhydra hydra-system (:color blue)
  "
            SYSTEM & MISC.
#########################---------------
_o_rg file dir    _._emacs
_h_ome dir        _t_heme file

_q_uit

"
  ("o" (find-file "~/orgfiles/") "Org dir")
  ("h" (find-file "~/") "Home dir")
  ("." (find-file "~/.emacs") ".emacs file")
  ("t" (find-file "~/.emacs.d/thall/hydra.el") "darker-gruber-thall file")
  ("q" nil "Quit" :color blue))
(global-set-key (kbd "C-c M-h s") 'hydra-system/body)
