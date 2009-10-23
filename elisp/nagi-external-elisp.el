;; -*- emacs-lisp -*-

;;;-----------------------------------------------------------------------
;;; Нэмэлт суулгах өргөтгөлүүд:

;;; simples ( mostly one .el file ):
;;;    pager.el
;;;    tabbar.el
;;;    htmlize.el
;;;    anything.el
;;;    anything-config.el
;;;    auto-install.el
;;;    psvn.el
;;;    tagging.el
;;;    nxml
;;;    color-theme
;;;    muse
;;;    yasnippet
;;;
;;; extended ( has own config file ):
;;;    erlang
;;;    distel
;;;    cedet
;;;    jdee
;;;
;;; these are interfaces which require extra installation
;;;    x-dict.el  -> x-dict
;;;    figlet.el  -> figlet
;;;    woof.el    -> woof ~/.woofrc
;;;-----------------------------------------------------------------------

(defun nrequire (mod)
  (unless (require mod nil t)
    (message "####################> %s is NOT found, so NOT LOADED!" mod)))

(message "Loading external nagi-external-simples.el ==============================>")
(ext-load-file "nagi-external-simples.el")

(message "Loading external nagi-external-extended.el ==============================>")
(ext-load-file "nagi-external-extended.el")


