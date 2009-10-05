;; -*- emacs-lisp -*-

;;-----------------------------------------------------------------------
;; Нэмэлт суулгах өргөтгөлүүд
;;-----------------------------------------------------------------------

;; nXML mode
;; ---------
(load "rng-auto.el")
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|\xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))
;; complete </ end tag automatically
(setq nxml-slash-auto-complete-flag 1)
;; sexp element functions on xml elements
(setq nxml-sexp-element-flag 1)
;; pretty print xml code snippet
(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[ \\t]*\<" nil t)
        (backward-char) (insert "\n"))
      (indent-region begin end)
      (delete-trailing-whitespace))
    (message "Ah, much better!"))
;; OR you can use xmllint command for pretty printing!
;; e.g C-x h M-| xmllint --format -


;; Haskell mode
;; -----------------
;; cvs -d :pserver:anoncvs@cvs.haskell.org:/cvs login # password 'cvs'
;; cvs -d :pserver:anoncvs@cvs.haskell.org:/cvs co fptools/CONTRIB/haskell-modes/emacs
;;(load "~/elisp/haskell-mode/haskell-site-file")
(load "haskell-site-file")
(defun unicode-symbol (name)
   "Translate a symbolic name for a Unicode character -- e.g., LEFT-ARROW
 or GREATER-THAN into an actual Unicode character code. "
   (decode-char 'ucs (case name
      ('left-arrow 8592)
                       ('up-arrow 8593)
                       ('right-arrow 8594)
                       ('down-arrow 8595)
      ('double-vertical-bar #X2551)
                       ('equal #X003d)
                       ('not-equal #X2260)
                       ('identical #X2261)
                       ('not-identical #X2262)
                       ('less-than #X003c)
                       ('greater-than #X003e)
              ('less-than-or-equal-to #X2264)
                ('greater-than-or-equal-to #X2265)
                       ('logical-and #X2227)
                       ('logical-or #X2228)
                       ('logical-neg #X00AC)
                       ('nil #X2205)
                       ('horizontal-ellipsis #X2026)
                       ('double-exclamation #X203C)
                       ('prime #X2032)
                       ('double-prime #X2033)
                       ('for-all #X2200)
                       ('there-exists #X2203)
                       ('element-of #X2208)
                       ('square-root #X221A)
                       ('squared #X00B2)
                       ('cubed #X00B3)
                       ('lambda #X03BB)
                       ('alpha #X03B1)
                       ('beta #X03B2)
                       ('gamma #X03B3)
                       ('delta #X03B4))))

(defun substitute-pattern-with-unicode (pattern symbol)
    "Add a font lock hook to replace the matched part of PATTERN with the
     Unicode symbol SYMBOL looked up with UNICODE-SYMBOL."
    (interactive)
    (font-lock-add-keywords
    nil `((,pattern
           (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                     ,(unicode-symbol symbol)
                                     'decompose-region)
                             nil))))))

(defun substitute-patterns-with-unicode (patterns)
   "Call SUBSTITUTE-PATTERN-WITH-UNICODE repeatedly."
   (mapcar #'(lambda (x)
               (substitute-pattern-with-unicode (car x)
                                                (cdr x)))
           patterns))

(defun haskell-unicode ()
 (interactive)
 (substitute-patterns-with-unicode
  (list (cons "\\(<-\\)" 'left-arrow)
        (cons "\\(->\\)" 'right-arrow)
        (cons "\\(==\\)" 'identical)
        (cons "\\(/=\\)" 'not-identical)
        (cons "\\(()\\)" 'nil)
        (cons "\\<\\(sqrt\\)\\>" 'square-root)
        (cons "\\(&&\\)" 'logical-and)
        (cons "\\(||\\)" 'logical-or)
        (cons "\\<\\(not\\)\\>" 'logical-neg)
        (cons "\\(>\\)\\[^=\\]" 'greater-than)
        (cons "\\(<\\)\\[^=\\]" 'less-than)
        (cons "\\(>=\\)" 'greater-than-or-equal-to)
        (cons "\\(<=\\)" 'less-than-or-equal-to)
        (cons "\\<\\(alpha\\)\\>" 'alpha)
        (cons "\\<\\(beta\\)\\>" 'beta)
        (cons "\\<\\(gamma\\)\\>" 'gamma)
        (cons "\\<\\(delta\\)\\>" 'delta)
        (cons "\\(''\\)" 'double-prime)
        (cons "\\('\\)" 'prime)
        (cons "\\(!!\\)" 'double-exclamation)
        (cons "\\(\\.\\.\\)" 'horizontal-ellipsis))))

(add-hook 'haskell-mode-hook 'haskell-unicode)

;; Erlang emacs mode
;; -----------------
;; ~/elisp/erlware-mode-0.1.7
(add-to-list 'load-path "~/elisp/erlware-mode-0.1.11")
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/local/bin" exec-path))
(require 'erlang-start)
(setq erlang-man-root-dir "/usr/lib/erlang/man")

;; this is needed for Distel setup
;; svn checkout http://distel.googlecode.com/svn/trunk/ distel
(let ((distel-dir "/usr/local/share/distel/elisp"))
  (unless (member distel-dir load-path)
    ;; Add distel-dir to the end of load-path
    (setq load-path (append load-path (list distel-dir)))))
(require 'distel)
(distel-setup)

;; Some Erlang customizations
(add-hook 'erlang-mode-hook
          (lambda ()
            ;; when starting an Erlang shell in Emacs, default in the mode name
            (setq inferior-erlang-machine-options '("-sname" "emacs"))
            ;; add Erlang functions to an imenu menu
            (imenu-add-to-menubar "imenu")))
;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"  erl-complete)
    ("\M-?"     erl-complete)
    ("\M-."     erl-find-source-under-point)
    ("\M-,"     erl-find-source-unwind)
    ("\M-*"     erl-find-source-unwind)
    )
  "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
          (lambda ()
            ;; add some Distel bindings to the Erlang shell
            (dolist (spec distel-shell-keys)
              (define-key erlang-shell-mode-map (car spec) (cadr spec)))))


;; Bongo player
;; --------------------
;; бас дуу хөгжим тоглуулагч
;; (add-to-list 'load-path "~/elisp/bongo")
;; (require 'bongo)
;; (require 'bongo-mplayer)

;; ;; EMMS emac multimedia
;; ;; --------------------
;; ;; Дуу хөгжим кино сонсож үзэгч
;; ;; /usr/ports/audio/emms
;; (require 'emms-setup)
;; (emms-standard)
;; (emms-default-players)
;; (global-set-key "\C-c\C-l" 'bongo-seek)

;; muse
;; ----
;; текст засварлагч, экспортлогч
;; /usr/ports/textproc/muse --old way
;; git clone git://repo.or.cz/muse-el.git muse
(add-to-list 'load-path "~/elisp/muse")
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

;; psvn
;; ----
;; subversion програмын хувилбар зохицуулагч
;; /usr/ports/devel/psvn
(require 'psvn)

;; color-themes
;; ------------
;; Төрөл бүрийн харуулах маягууд
;; /usr/ports/misc/color-theme.el -old way!
;; wget http://download.gna.org/color-theme/color-theme-6.6.0.tar.gz
(add-to-list 'load-path "~/elisp/color-theme-6.6.0")
(require 'color-theme)
;; default color theme is billw (I liked it :)
(color-theme-initialize)
(color-theme-oswald)

;; flymake with python
;; -------------------
;; flymake-г могойтой хэрэглэхэд хэрэглэгдэх тохиргоо
;; epylint файлыг /usr/local/bin дотор хуулна
;; /usr/ports/devel/pylint
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
       (local-file (file-relative-name
                    temp-file
                    (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
           '("\\.py\\'" flymake-pylint-init)))

;; figlet
;; ------
;; текстийг том зураасаар дүрслэгч
;; ~/elisp/figlet.el
(require 'figlet)

;; yasnippet
;; ---------
;; төрөл бүрийн програмуудад тохирсон товчлолууд
;; xx-bundle.el хувилбар нь анхлан хэрэглэгчийнх шүү!!
;; svn checkout http://yasnippet.googlecode.com/svn/trunk/ yasnippet
(add-to-list 'load-path "~/elisp/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/elisp/yasnippet/snippets")

;; ido
;; ---
;; буфер сэлгэх үйлдлийг амарчлагч
;; ~/elisp/ido.el
(require 'ido)
(ido-mode t)
;;(ido-mode 'buffer)
(setq ido-enable-flex-matching t)

;; Python
;; ------
;; Могойд зориулсан тохиргоо
;; ~/elisp/python.el
;;(require 'python)

;; Python indentation mode
;; Могойд зориулсан зай авалт
;; тухайн мөрөн дээр ТАБ дарахад тохирсон зайг авдаг
(defun my-python-indent-setup ()
  (setq indent-tabs-mode nil)
  (setq py-indent-offset 4))
(add-hook 'python-mode-hook 'my-python-indent-setup)

;; pymacs
;; могойд зориулсан туслах горим
;; ~/elisp/rope
;; ~/elisp/ropemacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; ;; ROPE - for refactoring and auto-completion
;; (load "~/elisp/pymacs.el")
;; (pymacs-load "ropemacs" "rope-")
;; ;; enabling autoimport
;; (setq ropemacs-enable-autoimport 't)
;; ;; telling ropemacs which modules to cache
;; ;;(setq ropemacs-autoimport-modules '("django"))

;; ;; python electric pair
;; ;; төрөл бүрийн хаалт нээнгүүт хаах тохиргоо
;; (add-hook 'python-hook
;;    (lambda ()
;;      (define-key python-map "\"" 'electric-pair)
;;      (define-key python-map "\'" 'electric-pair)
;;      (define-key python-map "(" 'electric-pair)
;;      (define-key python-map "[" 'electric-pair)
;;      (define-key python-map "{" 'electric-pair)))
;; (defun electric-pair ()
;;   "Insert character pair without sournding spaces"
;;   (interactive)
;;   (let (parens-require-spaces)
;;     (insert-pair)))

;; predictive
;; ----------
;; Урьдчилан нөхөж бичигч
;; ~/elisp/predictive
(add-to-list 'load-path "~/elisp/predictive")
(autoload 'predictive-mode "predictive" "predictive" t)

;; linum
;; -----
;; Мөрийн дугаар харуулагч
;; ~/elisp/linum.el
(require 'linum)
(global-linum-mode t)


;; SLIME
;; -----
;; Лисп програмыг хөгжүүлэхэд хэрэглэгдэх хамгийн хүчтэй горим
;; ~/sources/slime   cvs эх кодоор нь суулгана:
;; cvs -d :pserver:anonymous@common-lisp.net:/project/slime/cvsroot login
;; # Password is "anonymous"
;; cvs -d :pserver:anonymous@common-lisp.net:/project/slime/cvsroot checkout slime

(add-to-list 'load-path "~/usr/share/emacs22/site-lisp/slime")
(require 'slime)

(slime-setup '(slime-fancy slime-asdf))

(setq inferior-lisp-program "/usr/bin/sbcl"
      lisp-indent-function 'common-lisp-indent-function
      slime-complete-symbol-function 'slime-fuzzy-complete-symbol
      slime-startup-animation t
      slime-highlight-compiler-notes t
      slime-fuzzy-completion-in-place nil)

;; for short time - nagi
;;(global-set-key [f9] 'slime-selector)

;; paredit minor mode (lisp)
;; wget http://www.bloodandcoffee.net/campbell/paredit.el or
;; wget http://mumble.net/~campbell/emacs/paredit.el
(add-to-list 'load-path "~/elisp/paredit/")
(require 'paredit)

;; custom keybindings to SLIME LISP mode
(define-key slime-mode-map (kbd "(") 'paredit-open-parenthesis)
(define-key slime-mode-map (kbd ")") 'paredit-close-parenthesis)

(define-key slime-mode-map (kbd "\"") 'paredit-doublequote)
(define-key slime-mode-map (kbd "\\") 'paredit-backslash)

(define-key slime-mode-map (kbd "RET") 'newline)
(define-key slime-mode-map (kbd "<return>") 'newline)
(define-key slime-mode-map (kbd "C-j") 'paredit-newline)

(define-key slime-mode-map (kbd "C-h") 'backward-sexp)
(define-key slime-mode-map (kbd "C-t") 'transpose-sexps)
(define-key slime-mode-map (kbd "C-M-t") 'transpose-chars)
;;(define-key slime-mode-map (kbd "C-n") 'forward-sexp)
(define-key slime-mode-map (kbd "C-k") 'kill-sexp)
(define-key slime-mode-map (kbd "C-M-k") 'paredit-kill)
(define-key slime-mode-map (kbd "C-'") 'paredit-splice-sexp)
(define-key slime-mode-map (kbd "C-M-l") 'paredit-recentre-on-sexp)
(define-key slime-mode-map (kbd "C-,") 'paredit-backward-slurp-sexp)
(define-key slime-mode-map (kbd "C-.") 'paredit-forward-slurp-sexp)
(define-key slime-mode-map (kbd "C-<") 'paredit-backward-barf-sexp)
(define-key slime-mode-map (kbd "C->") 'paredit-forward-barf-sexp)
;; bound C-M-u to 'backward-up-list (default)
;;(define-key slime-mode-map (kbd "C-/") 'backward-up-list)
(define-key slime-mode-map (kbd "C-=") 'down-list)
(define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
(define-key slime-mode-map (kbd "C-c TAB") 'slime-complete-form)
;; ;;;; this may seem strange, but i often use the C-<whatever> motion
;; ;;;; commands in sequence to reformat code and having to take a finger off of control
;; ;;;; to add a return is a pain
(define-key slime-mode-map (kbd "C-<return>") 'paredit-newline)
;; ;;;; i hate having to take my key off of ctrl for this and i don't use complete-form anyway...
(define-key slime-mode-map (kbd "C-c C-i") 'slime-inspect)


;; htmlize.el mode
;; wget http://www.emacswiki.org/emacs/download/htmlize.el
(require 'htmlize)

;; code browsing
;; --------------
;; source from http://ecb.sourceforge.net
;;(add-to-list 'load-path "~/elisp/ecb-2.32")
;;(require 'ecb)

;; woof.el
;; -------
;; Web Offer One File
;; wget http://www.xsteve.at/prg/emacs/woof.el
;;(require 'woof)

;; ==========================
;; tagging.el
;; wget http://lisperati.com/tagging.el
;; ==========================
(load "tagging.el")

;; tabbar.el
;; --------
(require 'tabbar)
(tabbar-mode 1)
(global-set-key "\M-[" 'tabbar-backward)
(global-set-key "\M-]" 'tabbar-forward)

;; x-dict.el
;; --------
;; online dictionary
;; wget http://www.xsteve.at/prg/python/x-dict  -> save it to PATH
;; wget http://www.xsteve.at/prg/emacs/x-dict.el
(require 'x-dict)

;; pager.el
;; for better scrolling
;; wget http://user.it.uu.se/~mic/pager.el
(require 'pager)
;;; Bind scrolling functions from pager library.
(global-set-key [next]     'pager-page-down)
(global-set-key "\C-v"     'pager-page-down)
(global-set-key [prior]    'pager-page-up)
(global-set-key "\M-v"     'pager-page-up)
(global-set-key "\M-p"    'pager-row-up)
(global-set-key "\M-n"  'pager-row-down)
(global-set-key "\C-n"  'next-line)
(global-set-key "\C-p"  'previous-line)

;; w3m mode
;; ---------------
;; wget http://emacs-w3m.namazu.org/emacs-w3m-1.4.4.tar.gz
;; or download development version ( recommended )
;; ./configure
;; make && make install && make install-icons
(require 'w3m-load)

;; autoinstall mode
;; ----------------
;; wget http://www.emacswiki.org/emacs/auto-install.el
;;(add-to-list 'load-path (expand-file-name "~/elisp"))
(require 'auto-install)
(setq auto-install-directory "~/elisp/")

;; anything mode
;; --------------
;; M-x auto-install-batch RET
;; Input "anything"
(require 'anything-config)

;; --------------------------------------------------------------------
;; because of speedbar 0.14beta, emacs-rails cannot be installed!
;; --------------------------------------------------------------------\/
;; find-recursive.el
;; wget http://www.webweavertech.com/ovidiu/emacs/find-recursive.txt
;; find files recursively into a directory
;; -----------------
;; (require 'find-recursive)
;;
;; snippet.el
;; ----------
;; wget http://www.kazmier.com/computer/snippet.el
;; rails requires!
;;(require 'snippet)

;; emacs-rails
;; -----------
;; http://rubyforge.org/projects/emacs-rails
;; (setq load-path (cons "~/elisp/emacs-rails" load-path))
;; (require 'rails)
;; --------------------------------------------------------------------/\
