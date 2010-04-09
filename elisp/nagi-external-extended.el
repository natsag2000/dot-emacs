;; -*- emacs-lisp -*-

;; extended external files
;; -----------------------

;; load erlang configuration
;; -------------------------
(nrequire 'nagi-erlang-config)

;; load CEDET configuration
;; Collection of Emacs Development Environment Tools
;; -------------------------------------------------
(when (file-accessible-directory-p (in-basedir-ext "cedet-1.0pre6"))
  (nrequire 'nagi-cedet-config))

;; load ECB configuration
;; Emacs Code Browser (requires CEDET!)
;; -----------------------------------
(when (file-accessible-directory-p (in-basedir-ext "ecb-2.40"))
  (nrequire 'nagi-ecb-config))

;; load JDEE configuration
;; java development environment
;; -----------------------------------
(when (file-accessible-directory-p (in-basedir-ext "jde-2.3.5.1"))
  (nrequire 'nagi-jdee-config))

;; load SLIME configuration
;; common lisp development environment
;; -----------------------------------
(when (file-accessible-directory-p (in-basedir-ext "slime"))
  (nrequire 'nagi-slime-config))