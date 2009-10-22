(provide 'nagi-ecb-config)

;; If you want to load the complete ECB at (X)Emacs-loadtime (Advantage:
;; All ECB-options available after loading ECB. Disadvantage: Increasing
;; loadtime(2)):

;;     (require 'ecb)

;; If you want to load the ECB first after starting it by `ecb-activate'
;; (Advantage: Fast loading(3).  Disadvantage: ECB- and semantic-options
;; first available after starting ECB):

(require 'ecb-autoloads)

;; This loads all available autoloads of ECB, e.g. `ecb-activate',
;; `ecb-minor-mode', `ecb-byte-compile' and `ecb-show-help'.
