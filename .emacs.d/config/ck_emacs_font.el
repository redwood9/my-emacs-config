;; 设置英文字体
(set-face-attribute
  'default nil :font "Consolas 10")
;; 设置中文字体
(dolist (charset '(kana han symbol cjk-misc bopomofo))
	(set-fontset-font (frame-parameter nil 'font)
					  charset
					  (font-spec :family "YaHei Consolas Hybrid" :size 12)
	)
)
;;ctrl+鼠标滚轮控制字体缩放
;; For Linux
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
;; For Windows
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
