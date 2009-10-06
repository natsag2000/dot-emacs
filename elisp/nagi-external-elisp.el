;; -*- emacs-lisp -*-

;;;-----------------------------------------------------------------------
;;; Нэмэлт суулгах өргөтгөлүүд:
;;;    x-dict.el
;;;    pager.el
;;;    tabbar.el
;;;    figlet.el
;;;    htmlize.el
;;;    woof.el
;;;    color-theme
;;;    muse
;;;-----------------------------------------------------------------------

;; x-dict.el
;; --------
;; online dictionary
;; wget http://www.xsteve.at/prg/python/x-dict  -> save it to PATH
;; wget http://www.xsteve.at/prg/emacs/x-dict.el
(require 'x-dict)

;; pager.el
;; --------
;; for better scrolling
(require 'pager)
;;; Bind scrolling functions from pager library.
(global-set-key  [next]  'pager-page-down)
(global-set-key  "\C-v"  'pager-page-down)
(global-set-key  [prior] 'pager-page-up)
(global-set-key  "\M-v"  'pager-page-up)
(global-set-key  "\M-p"  'pager-row-up)
(global-set-key  "\M-n"  'pager-row-down)
(global-set-key  "\C-n"  'next-line)
(global-set-key  "\C-p"  'previous-line)

;; tabbar.el
;; --------
(require 'tabbar)
(tabbar-mode 1)
(global-set-key "\M-[" 'tabbar-backward)
(global-set-key "\M-]" 'tabbar-forward)

;; figlet
;; ------
;; текстийг том зураасаар дүрслэгч
(require 'figlet)

;; color-theme
;; ------------
;; Төрөл бүрийн харуулах маягнууд
;;(add-to-list 'load-path "~/elisp/color-theme-6.6.0")
(require 'color-theme)
;; default color theme is billw (I liked it :)
(color-theme-initialize)
(color-theme-oswald)

;; htmlize.el mode
;; ---------------
;; export a buffer to html
(require 'htmlize)

;; woof.el
;; -------
;; Web Offer One File
(require 'woof)

;; muse
;; ----
;; текст засварлагч, экспортлогч
;; git clone git://repo.or.cz/muse-el.git muse or with use web URL
;;(add-to-list 'load-path "~/elisp/muse")
(require 'muse-mode)
(require 'muse-html)  ; load publishing styles
(require 'muse-latex)
(require 'muse-texinfo)
(require 'muse-docbook)
(require 'muse-project) ; publish files in project
; my muse project folder
(setq muse-project-alist
      '(("howto-pages" ("~/mymuses" :default "index")
         (:base "html" :path "~/mymuse-outputs/html")
         (:base "pdf" :path "~/mymuse-outputs/pdf"))))
