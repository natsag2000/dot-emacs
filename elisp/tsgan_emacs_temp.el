
(load "~/.emacs.d/flymake-java.el")

(require 'cc-mode)
;(require 'php-mode)
;(require 'python-mode)

(autoload 'python-mode "python-mode" "Mode for editing Python source files")
(add-to-list 'auto-mode-alist '("\\.py" . python-mode))


;(add-hook 'php-mode-user-hook 'flymake-php-load)

;flymake python

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


 (defun my-java-mode-hook ()
   (define-key (current-local-map) "\C-c\C-f" 'flymake-mode))
 (add-hook 'java-mode-hook 'my-java-mode-hook)
 (require 'flymake-java)
 (add-hook 'flymake-mode-hook 'my-flymake-mode-hook)
 (defun my-flymake-mode-hook ()
  (define-key (current-local-map) "\C-c\C-d" 'flymake-display-err-menu-for-current-line)
  (define-key (current-local-map) "\C-c\C-n" 'flymake-goto-next-error)
  (define-key (current-local-map) "\C-c\C-D" 'credmp/flymake-display-err-minibuf))



