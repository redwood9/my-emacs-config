
(when (eq system-type 'windows-nt)


		(require 'color-theme)
		(load-file "~/.emacs.d/packages/blackbored.el")
		(color-theme-blackbored)

;;(color-theme-arjen)
(defun cckk-theme-classic ()
	;;(require 'color-theme)
  (interactive)
  (color-theme-install
   '(cckk
      ((background-color . "#666666")
      (background-mode . light)
      (border-color . "#4d4d4d")
      (cursor-color . "#a1a1a1")
      (foreground-color . "#9c9c9c")
      (mouse-color . "black"))
     (fringe ((t (:background "#4d4d4d"))))
     (mode-line ((t (:foreground "#840594" :background "#ffffff"))))
     (region ((t (:background "#4a4a4a"))))
     (font-lock-builtin-face ((t (:foreground "#7d2b2b"))))
     (font-lock-comment-face ((t (:foreground "#2ab2c0"))))
     (font-lock-function-name-face ((t (:foreground "#cf7d85"))))
     (font-lock-keyword-face ((t (:foreground "#8cdea3"))))
     (font-lock-string-face ((t (:foreground "#8c8831"))))
     (font-lock-type-face ((t (:foreground"#d20fcd"))))
     (font-lock-variable-name-face ((t (:foreground "#cf9120"))))
     (minibuffer-prompt ((t (:foreground "#cf4ac1" :bold t))))
     (font-lock-warning-face ((t (:foreground "Red" :bold t))))
     )))
(provide 'cckk)
(provide 'cckk-theme-classic)
;;(require 'cckk)

;;(cckk)
;;(set-cursor-color "green")
;;ЪѓБъ
;;(set-mouse-color "white")
)
