(provide 'nagi-jdee-config)
(require 'jde)

;; java flymake option
;; -------------------
(require 'jde-eclipse-compiler-server)

(push '(".+\\.java$" jde-ecj-flymake-init  jde-ecj-flymake-cleanup) flymake-allowed-file-name-masks)

(custom-set-variables
    '(flymake-no-changes-timeout 2.0)
    '(flymake-log-level 3)
    '(flymake-start-syntax-check-on-newline nil)
    '(jde-ecj-command-line-args (quote ("-d" "none" "-1.5" "-warn:unused,semicolon" "-maxProblems" "50" "-g")))
  )

;; (custom-set-variables
;;    '(flymake-allowed-file-name-masks
;;         (cons '("\\.java\\'"  . (jde-ecj-server-flymake-init jde-ecj-flymake-cleanup))
;;               flymake-allowed-file-name-masks  ))
;;     '(flymake-no-changes-timeout 2.0)
;;     '(flymake-log-level 3)
;;     '(flymake-start-syntax-check-on-newline nil)
;;     '(jde-compiler '(("eclipse java compiler server" "~/emacs/ecj-3.3M6.jar")))
;;     '(jde-ecj-command-line-args (quote ("-d" "none" "-1.5" "-warn:unused,semicolon" "-maxProblems" "50" "-g")))
;;   )

;; set jde-compiler (DONE in makefile.in!)
;; ---------------
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(jde-compiler (quote (("eclipse java compiler server" "/home/nagi/opt/eclipse/plugins/org.eclipse.jdt.core_3.4.4.v_894_R34x.jar")))))


;; ;;--flymake without jde configuration
;;(push '(".+\\.java$" flymake-java-ecj-init flymake-java-ecj-cleanup) flymake-allowed-file-name-masks)
;; (defvar flymake-java-version "1.6")
;; (defconst ecj-jar-path "/home/nagi/elisp/jdtcore.jar")
;; (defvar flymake-java-classpath "/home/nagi")

;; (defun flymake-java-ecj-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-ecj-create-temp-file))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "java" (list "-jar" ecj-jar-path "-Xemacs" "-d" "none"
;;                        ;; "-warn:none"
;;                        ;;"-source" flymake-java-version "-target" flymake-java-version "-proceedOnError"
;;                        ;;"-classpath" flymake-java-classpath
;;                        ;; "-log" "/tmp/flymake-java_log.xml"
;;                        local-file))))

;; (defun flymake-java-ecj-cleanup ()
;;   "Cleanup after `flymake-java-ecj-init' -- delete temp file and dirs."
;;   (flymake-safe-delete-file flymake-temp-source-file-name)
;;   (when flymake-temp-source-file-name
;;     (flymake-safe-delete-directory (file-name-directory flymake-temp-source-file-name))))

;; (defun flymake-ecj-create-temp-file (file-name prefix)
;;   "Create the file FILE-NAME in a unique directory in the temp directory."
;;   (file-truename (expand-file-name (file-name-nondirectory file-name)
;;                                    (expand-file-name  (int-to-string (abs (random))) (flymake-get-temp-dir)))))

;; (defun credmp/flymake-display-err-minibuf ()
;;   "Displays the error/warning for the current line in the minibuffer"
;;   (interactive)
;;   (let* ((line-no             (flymake-current-line-no))
;;          (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;          (count               (length line-err-info-list)))
;;     (while (> count 0)
;;       (when line-err-info-list
;;         (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
;;                (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;;                (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;;                (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;;           (message "[%s] %s" line text)))
;;       (setq count (1- count)))))
