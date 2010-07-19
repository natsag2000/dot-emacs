;; -*- emacs-lisp -*-

;;-----------------------------------------------------------------------
;; зарим гараар хийх нарийн тохиргоонууд
;;
;;-----------------------------------------------------------------------

;; MEW email
;; ---------
;;(autoload 'mew "mew" nil t)
;;(autoload 'mew-send "mew" nil t)

;; bitlbee irc proxy
;; ------------------
;; (defvar bitlbee-password "PASSWORD!!")
;; (add-hook 'erc-join-hook 'bitlbee-identify)
;; (defun bitlbee-identify ()
;;   "If we're on the bitlbee server, send the identify command to the
;;  &bitlbee channel."
;;   (when (and (string= "localhost" erc-session-server)
;;              (string= "&bitlbee" (buffer-name)))
;;     (erc-message "PRIVMSG" (format "%s identify %s"
;;                                    (erc-default-target)
;;                                    bitlbee-password))))
