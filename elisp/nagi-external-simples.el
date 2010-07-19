;; -*- emacs-lisp -*-

;; external simple files
;; ---------------------

(add-to-list 'exec-path (concat my-basedir "bin"))

;; x-dict.el
;; --------
;; online dictionary
;; wget http://www.xsteve.at/prg/python/x-dict  -> save it to PATH
;; wget http://www.xsteve.at/prg/emacs/x-dict.el
(nrequire 'x-dict)

;; figlet
;; ------
;; текстийг том зураасаар дүрслэгч.
;; ингэж байгааг нь шалгаж байгаад дуудахгүй бол
;; сонин алдаа зааж байв.
(when (load (in-basedir-misc "figlet.el"))
  (nrequire 'figlet))

;; woof.el
;; -------
;; Web Offer One File
(nrequire 'woof)

;; htmlize.el mode
;; ---------------
;; export a buffer to html
(nrequire 'htmlize)


;; anything mode
;; --------------
;; M-x auto-install-batch RET
;; Input "anything"
(nrequire 'anything-config)

;; psvn.el
;; -------
;; CVS эх код зохицуулалт хийхийг амарчилсан эд.
(nrequire 'psvn)

;; pager.el
;; --------
;; for better scrolling
(when (require 'pager nil t)
;;; Bind scrolling functions from pager library.
  (global-set-key  [next]  'pager-page-down)
  (global-set-key  "\C-v"  'pager-page-down)
  (global-set-key  [prior] 'pager-page-up)
  (global-set-key  "\M-v"  'pager-page-up)
  (global-set-key  "\M-p"  'pager-row-up)
  (global-set-key  "\M-n"  'pager-row-down)
  (global-set-key  "\C-n"  'next-line)
  (global-set-key  "\C-p"  'previous-line))

;; tabbar.el
;; --------
(when (require 'tabbar nil t)
  (tabbar-mode 1)
  (global-set-key "\M-[" 'tabbar-backward)
  (global-set-key "\M-]" 'tabbar-forward))


;; color-theme
;; ------------
;; Төрөл бүрийн харуулах маягнууд
(add-to-list 'load-path (concat (expand-file-name *MYBASEDIR*) "ext/color-theme-6.6.0"))
;; (load (in-basedir-misc "zenburn.el"))  --only for me
(when (require 'color-theme nil t)
  ;; default color theme is billw (I liked it :)
  ;;   (color-theme-ramangalahy) ;; also nice
  ;; color-theme-oswald  is also good
  (color-theme-initialize)
  (color-theme-oswald))
;;  (color-theme-zenburn))  --only for me

;; autoinstall mode
;; автоматаар суулгагч
;; жишээ: M-x auto-install-batch RET
;;         input "anything" to install "anything" mode
;; ---------------------------------------------------
;;(add-to-list 'load-path (expand-file-name "~/elisp"))
(nrequire 'auto-install)
(add-to-list 'load-path (concat (expand-file-name *MYBASEDIR*) "automatic/"))
(setq auto-install-directory (concat (expand-file-name *MYBASEDIR*) "automatic/"))

;; tagging.el
;; ----------
;; info : http://www.lisperati.com/tagging.html
(unless (load "tagging.el" t)
  (message "####################> tagging.el is NOT found, so NOT LOADED"))

;; screencast.el
;; ----------
;; info : http://www.emacswiki.org/emacs/ScreencastMode
(unless (load "screencast.el" t)
  (message "####################> screencast.el is NOT found, so NOT LOADED"))


;; yasnippet
;; ---------
;; төрөл бүрийн програмуудад тохирсон товчлолууд
;; xx-bundle.el хувилбар нь анхлан хэрэглэгчийнх шүү!!
(add-to-list 'load-path (in-basedir-ext "yasnippet"))
(when (require 'yasnippet nil t)
  (yas/initialize)
  (yas/load-directory (in-basedir-ext "yasnippet/snippets/"))
  (add-hook 'the-major-mode-hook 'yas/minor-mode-on))

;; nXML mode
;; ---------
(unless (load "rng-auto.el" t)
  (message "####################> rng-auto.el is NOT found, so NOT LOADED!"))

(setq auto-mode-alist
      (cons '("\\.\\(xml\\|\xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))
;; complete </ end tag automatically
(setq nxml-slash-auto-complete-flag 1)
;; sexp element functions on xml elements
(setq nxml-sexp-element-flag 1)

;; graphviz-dot-mode.el
;; --------------------
(unless (load (in-basedir-misc "graphviz-dot-mode.el"))
  (message "####################> graphviz-dot-mode.el is NOT found, so NOT LOADED!"))
