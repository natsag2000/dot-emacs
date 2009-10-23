(provide 'nagi-cedet-config)

;; look at http://xtalk.msk.su/~ott/en/writings/emacs-devenv/EmacsCedet.html

(load-file (in-basedir-ext "cedet-1.0pre6/common/cedet.el"))

;; Semantic
;; --------
;; ЗӨВХӨН НЭГИЙГ НЬ СОНГО
;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)


;; names completion, and displaying of information for tags & classes
;; ------------------------------------------------------------------
(require 'semantic-ia)

;; This enables the display of a menu with a list of functions,
;; variables, and other tags. To enable this feature you can either
;; use semantic-load-enable-code-helpers, or, you need
;; to add following code into your initialization file
;; ---------------------------------------------------
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;; some keyboard customizations
;; ----------------------------
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
(add-hook 'c-mode-common-hook 'my-cedet-hook)


