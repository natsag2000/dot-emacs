;; -*- emacs-lisp -*-

;;;-----------------------------------------------------------------------
;;; Нэмэлт суулгах өргөтгөлүүд:
;;;    pager.el
;;;    tabbar.el
;;;    figlet.el
;;;    htmlize.el
;;;    woof.el
;;;    anything.el
;;;    anything-config.el
;;;    auto-install.el
;;;    psvn.el
;;;    tagging.el
;;;    flymake-php.el
;;;    color-theme
;;;    muse
;;;    yasnippet
;;;    nxml
;;;
;;;-----------------------------------------------------------------------

(defun nrequire (mod)
  (unless (require mod nil t)
    (message "####################> %s is NOT found, so NOT LOADED!" mod)))

;; htmlize.el mode
;; ---------------
;; export a buffer to html
(nrequire 'htmlize)

;; woof.el
;; -------
;; Web Offer One File
(nrequire 'woof)

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

;; figlet
;; ------
;; текстийг том зураасаар дүрслэгч
(when (file-exists-p "~/elisp/misc/figlet.el")
  (require 'figlet))

;; color-theme
;; ------------
;; Төрөл бүрийн харуулах маягнууд
;;(add-to-list 'load-path "~/elisp/color-theme-6.6.0")
(when (require 'color-theme nil t)
  ;; default color theme is billw (I liked it :)
  (color-theme-initialize)
  (color-theme-hober))

;; autoinstall mode
;; автоматаар суулгагч
;; жишээ: M-x auto-install-batch RET
;;         input "anything" to install "anything" mode
;; ---------------------------------------------------
;;(add-to-list 'load-path (expand-file-name "~/elisp"))
(nrequire 'auto-install)
(add-to-list 'load-path (expand-file-name "~/elisp/automatic/"))
(setq auto-install-directory "~/elisp/automatic/")

;; tagging.el
;; ----------
;; info : http://www.lisperati.com/tagging.html
(unless (load "tagging.el" t)
  (message "####################> tagging.el is NOT found, so NOT LOADED"))

;; muse
;; ----
;; текст засварлагч, экспортлогч
;; git clone git://repo.or.cz/muse-el.git muse or with use web URL
;;(add-to-list 'load-path "~/elisp/muse")
(when (require 'muse-mode nil t)
  (require 'muse-html)  ; load publishing styles
  (require 'muse-latex)
  (require 'muse-texinfo)
  (require 'muse-docbook)
  (require 'muse-project) ; publish files in project
  ; my muse project folder
  (setq muse-project-alist
      '(("howto-pages" ("~/mymuses" :default "index")
         (:base "html" :path "~/mymuse-outputs/html")
         (:base "pdf" :path "~/mymuse-outputs/pdf")))))

;; yasnippet
;; ---------
;; төрөл бүрийн програмуудад тохирсон товчлолууд
;; xx-bundle.el хувилбар нь анхлан хэрэглэгчийнх шүү!!
;(add-to-list 'load-path "~/elisp/ext/yasnippet")
(when (require 'yasnippet nil t)
  (yas/initialize)
  (yas/load-directory "~/elisp/ext/yasnippet/snippets/"))

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

;; flymake.el
;; ----------
(nrequire 'flymake)

;; flymake-php.el
;; --------------
;; see flymake-php section in nagi-mode-specific-functions.el file
;;
;;(unless (load "flymake-php.el" t)
;;  (message "####################> flymake-php.el is NOT found, so NOT LOADED!"))


;; cc-mode
;; ========
(nrequire 'cc-mode)
