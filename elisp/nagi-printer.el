;; -*- emacs-lisp -*-

;;-----------------------------------------------------------------------
;; Хэвлэгчийн тохиргоо
;;-----------------------------------------------------------------------

(require 'printing)   ; load printing package
(setq pr-path-alist
 '((unix      "." "/usr/local/bin" ghostview mpage PATH)
   (ghostview "$HOME/bin/gsview-dir")
   (mpage     "$HOME/bin/mpage-dir")
      ))
(setq pr-txt-name      'Ricoh_aficio_mp_C2000)
(setq pr-txt-printer-alist
  '((Ricoh_aficio_mp_C2000 "lpr" nil "Ricoh_aficio_mp_C2000")
    ))
(setq pr-ps-name       'Ricoh_aficio_mp_C2000)
(setq pr-ps-printer-alist
  '((Ricoh_aficio_mp_C2000 "lpr" nil "-P" "Ricoh_aficio_mp_C2000")
    ))
(pr-update-menus t)   ; update now printer and utility menus