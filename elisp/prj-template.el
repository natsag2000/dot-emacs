(jde-project-file-version "1.0")

;; (jde-set-variables
;;  '(jde-global-classpath (quote ("./lib" "./target/classes" "./src")))
;;  '(jde-sourcepath (quote ("./srca" )))
;; )

;; --- with jde-mvn ---
(jde-set-variables
 '(jde-build-function (quote (jde-mvn-build)))
 '(jde-compile-option-command-line-args
   (quote ("-Xlint:all" "-Xlint:-serial"))))

(with-pom ()
          (pom-set-jde-variables :include-dependency-sources))

;; Map C-c C-v C-t to run current test
(define-key jde-mode-map [remap jde-jdb-menu-debug-applet]
  'jde-mvn-build-run-test)
;; --- end of jde-mvn ---


;; --- with pom-parser --------
;; (jde-set-variables
;;  '(jde-compile-option-command-line-args
;;    (quote ("-Xlint:all" "-Xlint:-serial"))))

;; (require 'pom-parser)
;; (with-pom ()
;;           (pom-set-jde-variables *pom-node*))
;; --- end of pom-parser -------


;; --- ??? --
;; Set default goal to GOAL
;;(jde-maven2-set-current-goal "test-compile")

;; Set default profile to PROFILE
;        (jde-maven2-set-current-profile
;        (if (jde-maven2-get-profile) (jde-maven2-get-profile) "PROFILE"))

;; Set default arguments to ARGUMENTS
;        (jde-maven2-set-current-arguments
;        (if (jde-maven2-get-arguments) (jde-maven2-get-arguments) "ARGUMENTS"))