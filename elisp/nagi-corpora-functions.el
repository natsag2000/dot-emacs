;; -*- emacs-lisp -*-

;;-----------------------------------------------------------------------
;; Корпора бэлдэхэд зориулж бичсэн функцүүд
;;    Бараг хэрэглэгдэхгүй хуучирсан байх.
;;-----------------------------------------------------------------------

(defun seek-and-play-duration ()
  (shell-command (concat "mmpc.sh "
   (extract-seek-pos-and-play-duration (thing-at-point 'line)))))

(defun extract-seek-pos-and-play-duration (timestr)
  (let ((time-part  (first (split-string timestr "----")))
  (seek-pos 0) (end-pos 0))
    (multiple-value-bind
    (seek-pos end-pos)
  (mapcar 'change-time-format (split-string time-part "-"))
      (concat (number-to-string seek-pos) " " (number-to-string (- end-pos seek-pos))))))

(defun change-time-format (time-str)
  (let ((m (string-to-number (first (split-string time-str ":"))))
    (s (string-to-number (second (split-string time-str ":")))))
    (+ (* m 60) s)))

;; need for redeclaring the time stamp
(defun insert-new-timestamp ()
  (let ((rest-sent (second (split-string (thing-at-point 'line) "----"))))
    (insert-time-pos)
    (kill-line)
    (insert rest-sent)))

;; not necessary :(
(defun create-time-var ()
  (setq start-time-pos 0)
  (setq end-time-pos 0))

(defun get-time ()
  (shell-command-to-string "mmpc-get-time.sh" ))

(defun insert-time-pos ()
  (interactive)
  (beginning-of-line)
  (insert (concat (get-end-time-with-start) "----")))

(defun get-start-time ()
  (setq start-time-pos (get-time)))

(defun get-end-time-with-start ()
  (setq end-time-pos (get-time))
  (concat start-time-pos "-" end-time-pos))

;; F5
(defun pause-toggle ()
  (interactive)
  (shell-command "mpc toggle"))
;; F6
(defun mark-start-time ()
  (interactive)
  (get-start-time))
;; F7
(defun mark-end-time ()
  (interactive)
  (insert-time-pos))

;; F3
(defun seek-minus-small ()
  (interactive)
  (shell-command "mpc seek -2"))

;; F4
(defun seek-plus-small ()
  (interactive)
  (shell-command "mpc seek +2"))

;; F8
(defun play-time-duration ()
  (interactive)
  (seek-and-play-duration))

;; F9
(defun seek-minus-big ()
  (interactive)
  (shell-command "mpc seek -7"))

;; F10
(defun seek-plus-big ()
  (interactive)
  (shell-command "mpc seek +7"))

;; F11
(defun load-file-to-player ()
  (interactive)
  (shell-command
   (concat "mmpc-load-file.sh "
           (replace-regexp-in-string "-I.txt" ".wav" (buffer-name)))))

;; insert <FL> tag
(defun insert-fl-tag ()
  (interactive)
  (insert "<FL>"))

;; insert <NI> tag
(defun insert-ni-tag ()
  (interactive)
  (insert "<NI>"))

;; some usefull replaces for corpora
(defun replace-this-abbr (from-str to-str)
  (goto-char (point-min))
  (setq case-fold-search nil)
  (while (search-forward from-str nil t)
         (replace-match to-str t t))
  (setq case-fold-search t))

;; convert numbers to string transliteration
;; ---------------------------------------------------------

(setq *number-to-string*
      '((1 "нэг" "нэгэн" "арав" "арван")
        (2 "хоёр" "хоёрон" "хорь" "хорин")
        (3 "гурав" "гурван" "гуч" "гучин")
        (4 "дөрөв" "дөрвөн" "дөч" "дөчин")
        (5 "тав" "таван" "тавь" "тавин")
        (6 "зургаа" "зургаан" "жар" "жаран")
        (7 "долоо" "долоон" "дал" "далан")
        (8 "найм" "найман" "ная" "наян")
        (9 "ес" "есөн" "ер" "ерэн")))

(defun replace-numbers-to-string ()
  (goto-char (point-min))
  (while (re-search-forward "[0-9]+" nil t)
    (replace-match (number-to-literal-string (match-string 0) ) nil nil)))

(defun get-hundred-thousand (number)
   (cond ((= number 1) "")
         ((= number 2) (second (assoc number *number-to-string*)))
         (t (third (assoc number *number-to-string*)))))

(defun get-string-from-number (number position)
  (nth position (assoc number *number-to-string*)))

(defun inverse-number-string (number-str)
  (apply 'string (reverse (string-to-list number-str))))

(defun split-per-one-char (string num)
  (substring string num (+ 1 num)))

(defun get-number-relative-position (whole-number number pos)
  (cond ((= number 0) "")
        ((= pos 0) (third (assoc number *number-to-string*)))
        ((= pos 1) (cond ((is-this-zero whole-number 0) (fifth (assoc number *number-to-string*)))
                         (t (fifth (assoc number *number-to-string*)))))
        ((= pos 2) (concat
                    (cond ((is-this-zero whole-number 1) (get-hundred-thousand number))
                          (t (get-hundred-thousand number))) " " "зуун"))
        ((= pos 3) (concat (get-hundred-thousand number) " " "мянга"))
        (t "")))

(defun is-this-zero (number-str pos)
  (= 0 (string-to-number (split-per-one-char number-str pos))))

(defun number-to-literal-string (string-number)
  (let ((value "") (mystring (inverse-number-string string-number)))
    (dotimes (counter  (length string-number) value)
      (setq value
            (concat
             (get-number-relative-position mystring
              (string-to-number (split-per-one-char mystring counter)) counter) " " value)))))

;; ---------------------------------------------------------

(defun replace-some-abbr ()
  (interactive)
  (replace-this-abbr "Д.Медведев" "Дмитрий Медведев")
  (replace-this-abbr "АНУ-ын" "Америкийн Нэгдсэн Улсын")
  (replace-this-abbr "АНУ" "Америкийн Нэгдсэн Улс")
  (replace-this-abbr "БНСУ" "Бүгд Найрамдах Солонгос Улс")
  (replace-this-abbr "хямарл" "хямрал")
  (replace-this-abbr "хямарал" "хямрал")
  (replace-this-abbr "НҮБ-ын" "Нэгдсэн Үндэсний Байгууллагын")
  (replace-this-abbr "НҮБ-д" "Нэгдсэн Үндэсний Байгууллагад")
  (replace-this-abbr "ЗХУ-д" "Зөвлөлт холбоот улсад")
  (replace-this-abbr "ЗХУ-н" "Зөвлөлт холбоот улсын")
  (replace-this-abbr "ЗХУ" "Зөвлөлт холбоот улс")
  (replace-this-abbr "ОХУ-ын" "Оросын Холбооны Улсын")
  (replace-this-abbr "ОХУ-д" "Оросын Холбооны Улсад")
  (replace-this-abbr "ОХУ" "Оросын Холбооны Улс")
  (replace-this-abbr "БНХАУ-ын" "Бүгд найрамдах хятад ард улсын")
  (replace-this-abbr "БНХАУ-д" "Бүгд найрамдах хятад ард улсад")
  (replace-this-abbr "БНХАУ" "Бүгд найрамдах хятад ард улс")
  (replace-numbers-to-string)
  (goto-char (point-min)))

;; keyboard shortcuts for corpora tools!
;(global-set-key "\M-p" 'pause-toggle)
;(global-set-key [f6] 'mark-start-time)
;(global-set-key [f7] 'mark-end-time)
;(global-set-key "\M-n" 'seek-minus-small)
(global-set-key [f4] 'seek-plus-small)
;(global-set-key [f8] 'play-time-duration)
(global-set-key [f6] 'replace-some-abbr)
(global-set-key [f7] 'insert-ni-tag)
(global-set-key [f8] 'insert-fl-tag)
(global-set-key [f9] 'seek-minus-big)
(global-set-key [f10] 'seek-plus-big)
(global-set-key [f2] 'load-file-to-player)