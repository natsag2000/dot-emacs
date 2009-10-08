;; -*- emacs-lisp -*-

;;-----------------------------------------------------------------------
;; Зарим тусгай функцүүд
;;-----------------------------------------------------------------------

;; ispell ийн оронд aspell-г ашиглах
;; АНХААР: aspell-г суулгасан байх хэрэгтэй
;; --------------------------------------------
(setq-default ispell-program-name "aspell")
(setq-default ispell-extra-args '("--sug-mode=ultra"))
;;(setq-default ispell-extra-args '("--reverse"))
(require 'ispell)
(setq ispell-dictionary "mongolian")


;; Maintain a stack of buffer positions, useful when recusively
;; looking up function definitions.
;; байгаа газраа тэмдэглээд дараа нь өөр тийшээ үсэрсэн хойноо
;; уг тэмдэг рүүгээ буцаж ирнэ. Стэк маягийн зохицуулалттай учраас
;; өмнө нь тэмдэглэсэн дарааллаараа буцах болно.
;; функц дуудалтыг дагаж мөрдөхөд зохимжтой
;; -----------------------------------------------

(defvar postack-stack '() "The position stack")

(defun postack-goto (marker)
  "Should be marker-goto."
  (switch-to-buffer (marker-buffer pos))
  (goto-char (marker-position pos)))

(defun postack-push ()
  "Push the current position on the position stack."
  (interactive)
  (let ((pos (point-marker)))
    (setq postack-stack (cons pos postack-stack))
    (message (format "Marked: (%s:%s)" (marker-buffer pos) (marker-position pos))) ))

(defun postack-pop ()
  "Remove the top position from the position stack and make it current."
  (interactive)
  (let ((pos (car postack-stack)))
    (setq postack-stack (cdr postack-stack))
    (cond ((null pos)
           (message "Position stack empty"))
          ((markerp pos)
           (postack-goto pos)
           (message (format "Position: (%s:%s)" (marker-buffer pos) (marker-position pos))))
          (t
           (message "Invalid position in stack")) ) ))

(global-set-key "\C-cm" 'postack-push)
(global-set-key "\C-cp" 'postack-pop)


;;(setq x-select-enable-primary nil)  ; stops killing/yanking interacting with primary X11 selection
