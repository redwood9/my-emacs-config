;; ����Ӣ������
(set-face-attribute
  'default nil :font "Consolas 10")
;; ������������
(dolist (charset '(kana han symbol cjk-misc bopomofo))
	(set-fontset-font (frame-parameter nil 'font)
					  charset
					  (font-spec :family "YaHei Consolas Hybrid" :size 12)
	)
)
;;ctrl+�����ֿ�����������
;; For Linux
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
;; For Windows
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
