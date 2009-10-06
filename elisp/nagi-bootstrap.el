;; -*- emacs-lisp -*-
;;-----------------------------------------------------------------------
;; Анхдагч тохиргоо
;;-----------------------------------------------------------------------

;; Алдаа гарангуут автоматаар хорхойгүйжүүлэх
;; горимд оруулах
;; ----------------
(setq debug-on-error t)

;; make common lisp function avaliable
;; энгийн лиспийн функцуудийг ашиглаж болно
;; ---------------------------------------------
(require 'cl)

;; set custome-file
;; эмаксад хийсэн өөрчлөлтүүдийг
;; автоматаар хадгалах файл
;; -----------------------------
(setq custom-file (concat custom-basedir "nagi-emacs-custom-file.el"))

;; add recursive path
;; custom-basedir дотор байгаа бүх сангуудыг нэмэх
;; --------------------------------------------------
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/elisp/")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))
