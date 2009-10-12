;; -*- emacs-lisp -*-

;;-----------------------------------------------------------------------
;; Миний гарын товчлолууд
;;-----------------------------------------------------------------------

;; switch to buffers directional
;; Чиглэлээр нь цонх руу шилжих
;; -----------------------------
(defalias 'wwu 'windmove-up)
(defalias 'wwd 'windmove-down)
(defalias 'wwl 'windmove-left)
(defalias 'wwr 'windmove-right)

;; other nice shortcuts
;; хайлтуудын хялбарчилсан товчлол
;; -----------------------------------
(defalias 'ifs 'isearch-forward-regexp)
(defalias 'ibs 'isearch-backward-regexp)
(global-set-key "\M-s" 'isearch-forward-regexp)
(global-set-key "\M-a" 'isearch-backward-regexp)

;; М-х ийг C-x C-m юмуу C-c C-m аар мөн хэрэглэж болно
;; --------------------------------------------------------
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; for backward-kill-word over backspace
;; үгийг араас нь устгах
;; -----------------------
(global-set-key "\C-w" 'backward-kill-word)

;; font scaling
;; үсгийн хэмжээг өөрчлөх
;; ------------------------
(global-set-key [(control mouse-4)] (lambda () (interactive)
                                      (text-scale-increase 1)))
(global-set-key [(control mouse-5)] (lambda () (interactive)
                                      (text-scale-decrease 1)))
;; (global-set-key [(control ?+)] (lambda () (interactive)
;;                                  (text-scale-increase 1)))
;; (global-set-key [(control ?-)] (lambda () (interactive)
;;                                  (text-scale-decrease 1)))
;; (global-set-key [(control ?0)] (lambda () (interactive)
;;                                  (text-scale-increase 0)))



;; kill region alternatives
;; Бүсэлсэн хэсгийг устгах
;; -------------------------
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; comments
;; тайлбар тавих
;; ----------------
(defalias 'cr 'comment-region)
(defalias 'ucr 'uncomment-region)

;; change C-h with delete backward function
;; C-h дарахад араас нь устгадагаар тохируулах
;; -----------------------------------------------
(global-set-key [f1] 'help-command)
(global-set-key "\C-h" 'delete-backward-char)

;; some more basic keybinding
;; бас бус гарын товчлолууд
;; --------------------------
;;(global-set-key [f1] 'man-follow)
(global-set-key [f4] 'speedbar-get-focus)
(global-set-key [f6] 'buffer-menu)
(global-set-key [M-return] 'expand-abbrev)
;; next and previous buffer selection
(global-set-key '[C-tab] 'bs-cycle-next)
(global-set-key [S-tab] 'bs-cycle-previous)