;; insert-char-with-length-of-previous-line
(defun ii (mChar)
  "inserts a character at the current line \n
  with the same length of previous line"
  (interactive
   (list (read-char "Char? (default is =)")))
  (let (endPos)
    (save-excursion
      (previous-line)
      (move-end-of-line nil)
      (setq endPos (current-column)))
    (if (eq mChar ?\r)
        (setq mChar (string-to-char "=")))
    (insert-char mChar endPos)
    (newline)))