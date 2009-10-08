;; -*- emacs-lisp -*-

;;-----------------------------------------------------------------------
;; Зарим горимтой холбоотой функцүүд
;;-----------------------------------------------------------------------

;; nXML mode
;; ---------
;; pretty print xml code snippet
;; хмл файл засварлах үед хэлбэршлийг нь засах хэсгээ сонгож
;; байгаад энэ функцийг дуудаж хэрэглэнэ үү.
(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t)
      (backward-char) (insert "\n"))
    (indent-region begin end)
    (delete-trailing-whitespace))
  (message "Ah, much better!"))

