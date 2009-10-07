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


;; code browsing
;; --------------
;; source from http://ecb.sourceforge.net
;;(add-to-list 'load-path "~/elisp/ecb-2.32")
;;(require 'ecb)

;; w3m mode
;; ---------------
;; wget http://emacs-w3m.namazu.org/emacs-w3m-1.4.4.tar.gz
;; or download development version ( recommended )
;; ./configure
;; make && make install && make install-icons
(require 'w3m-load)

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
