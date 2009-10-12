;; -*- emacs-lisp -*-

;;-----------------------------------------------------------------------
;; Зарим горимтой холбоотой функцүүд
;;   nXML
;;   Flymake-PHP
;;   C/C++
;;-----------------------------------------------------------------------

;; nXML mode
;; ---------
;; pretty print xml code snippet
;; хмл файл засварлах үед хэлбэршлийг нь засах хэсгээ сонгож
;; байгаад энэ функцийг дуудаж хэрэглэнэ үү.
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


;; Flymake settings
;; ----------------
(defun my-flymake-show-next-error()
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line))

;(add-hook 'find-file-hook 'flymake-find-file-hook)
(setq flymake-start-syntax-check-on-newline nil)

;(global-set-key [f3] 'flymake-display-err-menu-for-current-line)
;(global-set-key [f4] 'flymake-goto-next-error)
(global-set-key [f5] 'flymake-compile)

;'(flymake-errline ((((class color)) (:underline "OrangeRed"))))
;'(flymake-warnline ((((class color)) (:underline "yellow"))))



;; Flymake PHP extension
;; ---------------------
;; uses flymake-php.el file
(autoload 'php-mode "php-mode" "Mode for editing PHP source files")
(add-to-list 'auto-mode-alist '("\\.\\(inc\\|php[s34]?\\)" . php-mode))

(unless (fboundp 'flymake-php-init)
  (defun flymake-php-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "php" (list "-f" local-file "-l")))))

(let ((php-ext-re "\\.php[345]?\\'")
      (php-error-re
       "\\(?:Parse\\|Fatal\\) error: \\(.*\\) in \\(.*\\) on line \\([0-9]+\\)"))
  (unless (assoc php-ext-re flymake-allowed-file-name-masks)
    (add-to-list 'flymake-allowed-file-name-masks
                 (list php-ext-re
                       'flymake-php-init
                       'flymake-simple-cleanup
                       'flymake-get-real-file-name))
    (add-to-list 'compilation-error-regexp-alist-alist
                 (list 'compilation-php
                       php-error-re  2 3 nil nil))
    (add-to-list 'compilation-error-regexp-alist 'compilation-php)
    (add-to-list 'flymake-err-line-patterns
                 (list php-error-re 2 3 nil 1))))

(add-hook 'php-mode-hook (lambda () (flymake-mode t)))

;; flymake-python
;; --------------
(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "~/elisp/ext/pyflakes/bin/pyflakes" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init))

(add-hook 'find-file-hook 'flymake-find-file-hook)

;; C / C++
;; --------
(add-hook 'c-mode-common-hook
          (function (lambda ()
                      ;; more stuff here
                      (flymake-mode t)
                      ;;(global-set-key "\C-c\C-v" 'my-flymake-show-next-error)
                      (global-set-key [f6] 'my-flymake-show-next-error))))

(setq compilation-window-height 8)

(setq compilation-finish-function
      (lambda (buf str)
        (if (string-match "exited abnormally" str)
            ;;there were errors
            (message "compilation errors, press C-x ` to visit")
          ;;no errors, make the compilation window go away in 0.5 seconds
          (run-at-time 0.5 nil 'delete-windows-on buf)
          (message "NO COMPILATION ERRORS!"))))

;(c-toggle-hungry-state 1)

; mouse scrolling (works on XEmacs as well)
(autoload 'mwheel-install "mwheel" "Enable wheely mouse")
(mwheel-install)

;; Here's a sample .emacs file that might help you along the way.  Just
;; copy this region and paste it into your .emacs file.  You may want to
;; change some of the actual values.

(defconst my-c-style
  '((c-tab-always-indent           . t)
    (c-comment-only-line-offset    . 0)
    ;;(c-comment-only-line-offset    . 4)
    (c-hanging-braces-alist        . ((substatement-open after)
                                      (brace-list-open)))
    (c-hanging-colons-alist        . ((member-init-intro before)
                                      (inher-intro)
                                      (case-label after)
                                      (label after)
                                      (access-label after)))
    (c-cleanup-list                . (scope-operator
                                      empty-defun-braces
                                      defun-close-semi))
    (c-offsets-alist               . ((arglist-close     . c-lineup-arglist)
                                      (substatement-open . 0)
                                      (case-label        . 4)
                                      (block-open        . 0)
                                      (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t)
    )
  "My C Programming Style")

;; Customizations for all of c-mode, c++-mode, and objc-mode
(defun my-c-mode-common-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" my-c-style t)
  ;; offset customizations not in my-c-style
  (c-set-offset 'member-init-intro '++)
  ;; other customizations
  ;;  (setq tab-width 8
  ;; this will make sure spaces are used instead of tabs
  ;;        indent-tabs-mode nil)
  (setq-default c-basic-offset 4
                tab-width 4
                indent-tabs-mode t)
  ;; we like hungry-delete
  (c-toggle-hungry-state 1)
  ;; keybindings for C, C++, and Objective-C.  We can put these in
  ;; c-mode-map because c++-mode-map and objc-mode-map inherit it
  (define-key c-mode-map "\C-m" 'newline-and-indent))

;; The important part here is the C-m binding, which ensures that the
;; automatically go to the correct horizontal position when you press
;; enter.
;;
;; Some of the others are bindings from older versions of c-mode or from
;; other major modes that I've gotten used to.
(defun des-programming-keys ()
  (interactive)
  (local-set-key "\M-s" 'search-forward-regexp)
  (local-set-key "\M-r" 'search-backward-regexp)
  (local-set-key "\M-o" 'join-line)
  (local-set-key "\C-m" 'newline-and-indent)
  (local-set-key "\C-j" 'self-insert-command)
  (local-set-key "\C-c\C-c" 'compile)
  (local-set-key "\C-c\C-m" 'next-error))

;; style(9)-compliant indentation.  There is one edge case I'm unsure
;; about (nested arglists), but the rest is correct, to the best of my
;; knowledge.
(defun des-knf ()
  (interactive)
  (c-set-style "bsd")

  ;; Basic indent is 8 spaces
  (setq c-basic-offset 8)
  (setq tab-width 8)

  ;; Continuation lines are indented 4 spaces
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-cont 4)
  (c-set-offset 'arglist-cont-nonempty 4)
  (c-set-offset 'statement-cont 4)
  (c-set-offset 'cpp-macro-cont 8)

  ;; Labels are flush to the left
  (c-set-offset 'label [0])

  ;; Fill column
  (setq fill-column 74))

;; Context-sensitive help
(defvar des-man-sections nil
  "Colon-separated list of manual sections to search")
(defun des-context-help ()
  "Bring up the man page for the word closest to the current point"
  (interactive)
  (if des-man-sections
      (man (format "-S%s %s" des-man-sections (current-word)))
    (man (current-word))))
(global-set-key [f1] 'des-context-help)

;; Glue it all together.
;; The man page search order ensures that you don't get e.g. realpath(1)
;; instead of realpath(3), which is usually what you want when
;; programming in C.
(defun des-c-mode-hook ()
  ;; BSD-style indentation
  (des-knf)

  ;; Use make if a makefile is available; otherwise,
  ;; just compile the visited file
  (make-local-variable 'compile-command)
  (setq compile-command
        (if
            (or
             (file-exists-p (concat default-directory "Makefile"))
             (file-exists-p (concat default-directory "makefile")))
            "make"
          (concat "cc -Wall -Wextra -std=c99 -c " buffer-file-name)))

  ;; Set the man page search order
  (make-local-variable 'des-man-sections)
  (setq des-man-sections "3:2:9:4:5:1:8:7:6")

  ;; Key bindings
  (des-programming-keys))

;; the following only works in Emacs 19
;; Emacs 18ers can use (setq c-mode-common-hook 'my-c-mode-common-hook)
;;(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c-mode-common-hook 'des-c-mode-hook)

