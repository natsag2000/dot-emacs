;; -*- emacs-lisp -*-

;;-----------------------------------------------------------------------
;; Ерөнхий функцүүд
;;    АНХААР гэсэн хэсгүүдэд анхаарлаа хандуулна уу.
;;-----------------------------------------------------------------------

;; redefining the make-backup-file-name function in order to get
;; backup files in ~/.backups/ rather than scattered around all over
;; the filesystem. Note that you must have a directory ~/.backups/
;; made.  This function looks first to see if that folder exists.  If
;; it does not the standard backup copy is made.
;; Автоматаар үүсгэгддэг түр зуурын файлуудыг төвлөрсөн
;; нэг санд хуулах функц.
;; АНХААР: ~/backups санг үүсгэх шаардлагатай!!
;; ----------------------------------------------------------------
(defun make-backup-file-name (file-name)
  "Create the non-numeric backup file name for `file-name'."
  (require 'dired)
  (if (file-exists-p "~/.backups")
      (concat (expand-file-name "~/.backups/")
              (replace-regexp-in-string "/" "!" file-name))
    (concat file-name "~")))

;; redefining the make-auto-save-file-name function in order to get
;; autosave files sent to a single directory.  Note that this function
;; looks first to determine if you have a ~/.autosaves/ directory.  If
;; you do not it proceeds with the standard auto-save procedure.
;; Байнга автоматаар хадгалаад байдаг файлуудыг төвлөрсөн
;; газар хуулах.
;; АНХААР: ~/autosaves санг үүсгэх шаардлагатай!!
;; --------------------------------------------------------
(defun make-auto-save-file-name ()
  "Return file name to use for auto-saves of current buffer.."
  (if buffer-file-name
      (if (file-exists-p "~/.autosaves/")
          (concat (expand-file-name "~/.autosaves/") "#"
                  (replace-regexp-in-string "/" "!" buffer-file-name)
                  "#")
         (concat
          (file-name-directory buffer-file-name)
          "#"
          (file-name-nondirectory buffer-file-name)
          "#"))
    (expand-file-name
     (concat "#%" (buffer-name) "#"))))




;; insert date into buffer
;; Заагч байгаа газар огноо орлуулах
;; ------------------------------------
(defun insert-date ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%a %b %e, %Y %l:%M %p")))
;;  (insert (format-time-string "%Y-%m-%d-%R")))

;; энүүнээс өөр бэлэн тушаал байдаг шиг санагдаж байна
;; бүндөүсийн мөр хугалалтыг юникс мөр хугалалтаар засах
;; convert a buffer from dos ^M end of lines to unix end of lines
;; --------------------------------------------------------------
(defun dos2unix ()
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\r" nil t) (replace-match "")))

;; vice versa
;; мөн эсрэгээр
(defun unix2dos ()
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\n" nil t) (replace-match "\r\n")))

;; delete leading and trailing whitespace from string
;; Мөрний урд хойно байгаа сул зайг устга
;; ------------------------------------------
(defun trim-ws-in-string (string)
  "This function removes the leading and trailing whitespace from
   a string"
  (replace-regexp-in-string "\\(^[ \t]*\\|[ \t]*$\\)" "" string))

;; delete leading white spaces in whole buffer C-x C-h
;; Бүсэлсэн хэсгийн урд нь байгаа сул зайг устгах
;; -------------------------------------------------
(defun my-delete-leading-whitespace (start end)
  "Delete whitespace at the beginning of each line in region."
  (interactive "*r")
  (save-excursion
    (if (not (bolp))
        (forward-line 1))
    (delete-whitespace-rectangle (point) end nil)))
