;; -*- emacs-lisp -*-

;;-----------------------------------------------------------
;; Java Environment
;;-----------------------------------------------------------

;; install-jde.sh may be good alternative for installation
;; wget http://wttools.cvs.sourceforge.net/*checkout*/wttools/wttools/emacs-stuff/install-jde.sh
;; install-jde -h for help, install-jde -v for verbose output

(load-file "~/.emacs.d/site-lisp/cedet/common/cedet.el")
;(global-ede-mode t)
(semantic-load-enable-minimum-features)
(require 'semantic-ia)

(setq defer-loading-jde t)

;; java-mode-indent-annotations.el
;; --------------------
;; wget http://www.emacswiki.org/cgi-bin/wiki/download/java-mode-indent-annotations.el
(require'java-mode-indent-annotations)

(defun my-jde-mode-hook ()
  "Hook for running Java file..."
  (message "Loading my-java-hook")
  (setq c-basic-offset 2)
  (setq jde-java-directory "/usr/share/java")
  (java-mode-indent-annotations-setup) ; need java-mode-indent-annotations.el
  (message "my-jde-mode-hook function executed"))

(add-hook 'jde-mode-hook 'my-jde-mode-hook)


(if defer-loading-jde
    (progn
      (autoload 'jde-mode "jde" "JDE mode." t)
      (setq auto-mode-alist
      (append
       '(("\\.java\\'" . jde-mode))
       auto-mode-alist)))
  (require 'jde))

(require 'jde-maven2)

(global-set-key (kbd "C-c C-v g") 'jde-maven2-set-current-goal)
(defun jc ()
  (interactive)
  "set current goal to compile and run compile"
  (jde-maven2-set-current-goal "compile")
  (jde-build))

(defun jt ()
  (interactive)
  "set current goal to compile and run compile"
  (jde-maven2-set-current-goal "test")
  (jde-build))

