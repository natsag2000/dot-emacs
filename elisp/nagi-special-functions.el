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


;; get current line
;; ----------------
(defmacro get-current-line()
  "Current line string"
  (buffer-substring (save-excursion (beginning-of-line) (point))
            (save-excursion (end-of-line) (point))))

;; duplicated lines removed and print duplicated numbers at the end
;; --------------------------------
(defun nagi-remove-duplicate-lines()
  "Remove duplicate lines in a buffer"
  (interactive)
  (save-excursion
    (let
        ((lines_hash (make-hash-table :test #'equal))
         (number_hash (make-hash-table :test #'equal))
         (numlines (count-lines 1 (progn (end-of-buffer)(point)))))

      ;; Make a hash table with key=line
      ;;     and value=the smallest line number that contains a line.
      (loop for i from numlines downto 1 do
            (let ((line nil))
              (goto-line i)
              (setf line (get-current-line))
              ;; Want to store the smallest line number for
              ;;     a particular line.
              (setf (gethash line lines_hash) i)))
      ;; If a line has a line number not equal to the smallest line, kill it.
      (loop for i from numlines downto 1 do
            (let ((line nil))
              (goto-line i)
              (setf line (get-current-line))
              (beginning-of-line)
              (if (not (equal line ""))
                  (if (not (= 
                            (let ((min-line (gethash line lines_hash)))
                              (if (null min-line)
                                  -1
                                min-line))
                            i))
                      (let ((min-line (gethash line lines_hash))
                            (ccount nil))
                        (kill-line 1)
                        (setq ccount (gethash min-line number_hash))
                        (if (null ccount)
                            (setf (gethash min-line number_hash) 1)
                          (setf (gethash min-line number_hash) (+ ccount 1))))
                    (let ((lcount (gethash i number_hash)))
                      (if (not (null lcount))
                          (progn
                            (end-of-line)
                            (insert " " (int-to-string (+ lcount 1))))))
                    )))))))