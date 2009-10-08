;; -*- emacs-lisp -*-

;;-----------------------------------------------------------------------
;; Эмакс дээр нэмж өргөтгөл суулгах шаардлагаггүй анхдагч тохиргоо
;;    - эхэн хэсэгт нь өөрчлөлт хийгдэж болох тохиргоог бичив.
;;-----------------------------------------------------------------------

;; tab width
;; зай авалтын урт
;; ------------------
(setq default-tab-width 2)

;; show more info in taskbar/icon than just "Emacs"
;; гарчигийн талбарт файлын нэр мөн бүтэн замыг харуулах
;; -------------------------------------------------------------
(setq-default frame-title-format (list "%65b %f"))
(setq-default icon-title-format (list "%b"))

;; for menus and toolbars
;; зарим цэснээс харуулахгүй болгох
;; -----------------------------------
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; for global options for unicode
;; Ерөнхийдөө бүгд юникод
;; -------------------------
(setq locale-coding-system 'utf-8)
   (set-terminal-coding-system 'utf-8)
   (set-keyboard-coding-system 'utf-8)
   (set-selection-coding-system 'utf-8)
   (prefer-coding-system 'utf-8)

;; using ido for switch buffer
;; буфер сэлгэх үйлдлийг амарчлагч
(ido-mode t)
;;(ido-mode 'buffer)
(setq ido-enable-flex-matching t)

;; цонх тохируулга
;; ----------------
;; анхдагч текст горимд оруулах
(setq default-major-mode 'text-mode)
(setq-default default-fill-column 79)

;; linum
;; -----
;; Мөрийн дугаар харуулагч
(global-linum-mode t)

;; uniquify
;; --------
;; If you work with multiple projects having similarly named files,
;; use uniquify and set the name style for reverse.
;; That way the buffer name will be filename/path
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;; find file at point
;; ------------------
(require 'ffap)
;; rebind C-x C-f and others to the ffap bindings (see variable ffap-bindings)
(ffap-bindings)
;; C-u C-x C-f finds the file at point
(setq ffap-require-prefix t)
;; browse urls at point via w3m
(setq ffap-url-fetcher 'w3m-browse-url)

;; dired jump
;; ----------
;; C-x C-j opens a dired buffer with point at the actual file name.
(load "dired-x")

;; Save Desktop
;; ------------
;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
(setq desktop-save 'if-exists)
(desktop-save-mode 1)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))

;; Use F12 to invoke ibuffer
;; -------------------------
(setq ibuffer-shrink-to-minimum-size t)
(setq ibuffer-always-show-last-buffer nil)
(setq ibuffer-sorting-mode 'recency)
(setq ibuffer-use-header-line t)
(global-set-key [(f12)] 'ibuffer)

;; Эмаксад сануулсныг бусад цонхноос буулгаж болдог болгох (мөн эсрэгээр)
;; ----------------------------------------------------------------------------
(setq x-select-enable-clipboard t)

;; Эмаксийг сервер болгож ажиллуулах
;; -------------------------------------
(server-start)

;; Эхлэл тэмдэг зургийг нь хорих
;; --------------------------------
(setq inhibit-splash-screen t)

;; Setup Emacs to run csh as its primary shell.
;; --------------------------------------------
(setq shell-file-name "tcsh")
(setq shell-command-switch "-c")
(setq explicit-shell-file-name shell-file-name)
(setenv "SHELL" shell-file-name)
(setq explicit-sh-args '("-login" "-i"))

;; setting default font
;; --------------------
;; WARNING!! АНХААР
(set-default-font "-misc-fixed-medium-r-*-*-14-130-75-75-*-*-iso10646-*")

;; recentf-open-files
;; сүүлд нээгдсэн файлуудыг нээх
;; --------------------------------
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 200)
(setq recentf-max-menu-items 60)
;;(global-set-key [?\C-c ?r ?f] 'recentf-open-files)
(global-set-key [(meta f12)] 'recentf-open-files)

;; set wrapping line on the every buffer
;; буфер болгонд мөрийг нугална
;; --------------------------------
(setq truncate-partial-width-windows nil)

;; tabs replaced with spaces
;; зай авалтыг хоосон зайгаар нөхнө
;; ------------------------------------
(setq-default indent-tabs-mode nil)

;; мөрийн төгсгөлд байгаа хоосон зайг харуулах
;; -----------------------------------------------
(setq-default show-trailing-whitespace t)

;; highlight selection
;; Сонголтыг гэрэлтүүлж харуулах
;; ---------------------------------
(setq-default transient-mark-mode t)

;; show time
;; цаг харуулалт
;; ---------------
(display-time)

;; make the y or n suffice for a yes or no question
;; тийм үгүй гэсэн асуултанд нэг үсгээр хариулна
;; -------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p)

;; show column number in status bar
;; төлвийн самбарт баганы дугаарыг харуул
;; --------------------------------------------
(column-number-mode t)

;; show paren, brace, and curly brace "partners" at all times
;; хаасан юмуу нээсэн хаалтанд очингуут нөгөө талыг нь гэрэлтүүл
;; ---------------------------------------------------------------------
(show-paren-mode t)

;; бүс хэсгийг том үсгээр, бага үсгээр, мөн тусад нь бүслэх
;; -------------------------------------------------------------
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
