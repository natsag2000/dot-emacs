(provide 'nagi-slime-config)

;; SLIME for Common Lisp
;; ---------------------

;;(add-to-list 'load-path "/home/nagi/slime/")
(setq load-path (cons (in-basedir-ext "slime") load-path))
(setq load-path (cons (in-basedir-ext "slime/contrib") load-path))
(setq slime-backend (in-basedir-ext "slime/swank-loader.lisp"))
(require 'slime)
(setq inferior-lisp-program (shell-command-to-string "which sbcl"))
(slime-setup '(slime-fancy slime-asdf))
;; next 2 lines can be commented out
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;; ---


;; MORE MORE

;; (push "/home/athas/code/cvsrepos/slime/" load-path)
;; (push "/home/athas/code/cvsrepos/slime/contrib/" load-path)
;; (with-features
;;  (slime paredit)
;;  ;;(setq inferior-lisp-program "/usr/bin/lisp")
;;  (setq inferior-lisp-program "~/bin/cvsbcl"
;;        slime-multiprocessing t
;;        slime-startup-animation nil
;;        slime-backend "/home/athas/code/cvsrepos/slime/swank-loader.lisp")
;;  (slime-setup '(slime-fancy slime-asdf))
;;  (define-key paredit-mode-map (kbd "RET") nil)
;;  (define-key lisp-mode-shared-map (kbd "RET") 'paredit-newline)
;;  (define-key slime-repl-mode-map (kbd "C-M-d") 'down-list)
;;  (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
;;  (add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
;;  (add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;;  (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;;  (add-to-list 'auto-mode-alist '("\\.cl$" . lisp-mode))
;;  (add-to-list 'auto-mode-alist '("\\.cmucl-init$" . lisp-mode))
;;  (add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))

;;  (setq slime-complete-symbol-function 'slime-complete-symbol*)

;;  ;; I have a local copy of the Common Lisp HyperSpec
;;  (setq common-lisp-hyperspec-root "file:/home/athas/docs/HyperSpec/")

;;  (defvar hyperspec-browser-function 'w3m-browse-url
;;    "Function to display the relevant entry of the HyperSpec in a WWW browser.
;; This is used by the command `trh-hyperspec-lookup'.")

;;  (define-key slime-mode-map "\C-c\C-dh"
;;    (lambda ()
;;      (interactive)
;;      (let ((browse-url-browser-function hyperspec-browser-function))
;;        (call-interactively 'slime-hyperspec-lookup))))

;;  (global-set-key "\C-c\C-dh"
;;                  '(lambda ()
;;                     (interactive)
;;                     (let ((browse-url-browser-function hyperspec-browser-function))
;;                       (call-interactively 'slime-hyperspec-lookup))))

;;  (setq lisp-simple-loop-indentation 1
;;        lisp-loop-keyword-indentation 6
;;        lisp-loop-forms-indentation 6)

;;  )
