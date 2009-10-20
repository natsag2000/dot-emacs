(provide 'nagi-erlang-config)

;; Erlang emacs mode
;; -----------------
;; erlang-mode
;; distel
;; flymake
;(add-to-list 'load-path "~/elisp/erlware-mode-0.1.11")
(add-to-list 'exec-path "/usr/local/bin")
(setq erlang-root-dir "/usr/local/lib")
(setq erlang-man-root-dir "/usr/local/lib/erlang/man")
(nrequire 'erlang-start)

;; this is needed for Distel setup
(let ((distel-dir (expand-file-name "~/elisp/ext/distel/elisp")))
  (unless (member distel-dir load-path)
    ;; Add distel-dir to the end of load-path
    (setq load-path (append load-path (list distel-dir)))))
(nrequire 'distel)
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

;; flymake for erlang
;; ------------------
(require 'flymake)

(defun flymake-erlang-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "~/elisp/bin/eflymake" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
	     '("\\.erl\\'" flymake-erlang-init))

(add-hook 'find-file-hook 'flymake-find-file-hook)
