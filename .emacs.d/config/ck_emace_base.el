;加载xcscope，方便阅读源码
;;(require 'xcscope)
;; 屏幕滚动光标不动
(global-set-key (kbd "C-n") (lambda (&optional n) (interactive "p")
(scroll-up (or n 1))))
(global-set-key (kbd "C-p") (lambda (&optional n) (interactive "p")
(scroll-down (or n 1))))

(require 'ido)
(ido-mode t)
 
''最近打开的文件
(require 'recentf)
(recentf-mode t)

;; 自动为 C/C++ 的头文件添加 #define 保护。
(auto-insert-mode) ;;; Adds hook to find-files-hook
(setq auto-insert-directory "~/.emacs.d/mytemplates/") ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query nil)
;;(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-alist
      (append '((f90-mode . "Template.f90")
            (python-mode . "Template.py")
            (c-mode . "Template.c")
		(c-mode . "Template.h")
            )
           auto-insert-alist))
 
;;(require 'layout-restore)
;;(global-set-key (kbd "C-c l") 'layout-save-current)
;;(global-set-key (kbd "C-c C-l C-l") 'layout-restore)
;;(global-set-key (kbd "C-c C-l C-c") 'layout-delete-current)

;;bm-mode 定义书签并来回跳转
(require 'bm)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)
 
;;自动识别文件编码
(require 'unicad)
(xterm-mouse-mode t)
;;(setq server-use-tcp t)
;;(setq server-host "192.168.0.133")

;;(require 'company)
;;(autoload 'company-mode "company" nil t)


;;google C 样式
;;(require 'google-c-style)
;;(google-set-c-style t)
;;tramp
;;(add-to-list 'load-path "~/.emacs.d/packages/tramp-2.2.0/tramp-2.2.0/lisp")
(require 'tramp)
(setq tramp-default-method "plink")
;;(setq tramp-default-method "pscp")

;;滚动页面时比较舒服，不要整页的滚动
(setq scroll-step 1
;;scroll-margin 3
scroll-conservatively 10000)

;;所有的问题用y/n方式，不用yes/no方式。有点懒，只想输入一个字母
(fset 'yes-or-no-p 'y-or-n-p)

;;abbrev代码模板
(setq-default abbrev-mode t)
;; do not bug me about saving my abbreviations
(setq save-abbrevs nil)
;; load up abbrevs for these modes
(require 'shell)
(require 'cc-mode)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key [(f9)] 'ibuffer )
(autoload 'ibuffer "ibuffer" "List buffers." t)


(require 'msf-abbrev)
(setq msf-abbrev-root "~/.emacs.d/mode-abbrevs")
(msf-abbrev-load)

;; use C-c a to define a new abbrev for this mode
(global-set-key (kbd "C-c a") 'msf-abbrev-define-new-abbrev-this-mode)



;;tabbar
(if window-system
(progn 
  (add-to-list 'load-path "~/.emacs.d/packages/tabbar")
  (require 'tabbar)
  (require 'tabbar-ruler)
  (tabbar-mode t))
(progn
  
  )

)

;;choose the color theme
;;(add-to-list load-path  “~/emacs/site-lisp/color-theme”)
;;(load-file "~/.emacs.d/packages/color-theme-arjen.el")
;;(require 'color-theme)
;(color-theme-gnome2)
;(color-theme-zenburn)
;;(color-theme-arjen)
;;(color-theme-bharadwaj)
;;;; 设置tabbar外观
;; 设置默认主题: 字体, 背景和前景颜色，大小
;;(set-face-attribute 'tabbar-default-face nil
;;                    :family "Vera Sans YuanTi Mono"
;;                    :background "gray80"
;;                    :foreground "gray30"
;;                    :height 1.0
;;                    )
;; 设置左边按钮外观：外框框边大小和颜色
;;(set-face-attribute 'tabbar-button-face nil
 ;;                   :inherit 'tabbar-default
;;                    :box '(:line-width 1 :color "gray30")
;;                    )
;; 设置当前tab外观：颜色，字体，外框大小和颜色
;;(set-face-attribute 'tabbar-selected-face nil
;;                    :inherit 'tabbar-default
;;                   :foreground "DarkGreen"
;;                    :background "LightGoldenrod"
;;                    :box '(:line-width 2 :color "DarkGoldenrod")
;;                    ;; :overline "black"
;;                    ;; :underline "black"
;;                    :weight 'bold
;;                    )
;; 设置非当前tab外观：外框大小和颜色
;;(set-face-attribute 'tabbar-unselected-face nil
;;                    :inherit 'tabbar-default
;;                    :box '(:line-width 2 :color "gray70")
;;                    )
;;(setq x-select-enable-clipboard t)



;;recent-jump
(setq recent-jump-threshold 4)
(setq recent-jump-ring-length 10)
;;(global-set-key [(f11)] 'recent-jump-jump-backward)
;;(global-set-key [(f12)] 'recent-jump-jump-forward)
(require 'recent-jump)

;;跳转行数
(define-key   global-map   "\C-c\C-g"   'goto-line) 

;;(global-set-key [(f1)] 'eval-current-buffer )
;;pssvn
;;(require 'psvn)

;;行号
;;(require 'linum+)
;;(global-linum-mode t)




;;去掉工具栏
;;(when (eq system-type 'gnu/linux)
(tool-bar-mode nil)
(menu-bar-mode nil)
;;)

;;光标设置
;;(setq-default cursor-type 'bar)

;;(global-set-key [(control c control v)] 'uncomment-region)
;;(global-set-key [(f11)] 'eval-current-buffer )

;;关闭自动备份


;;支持鼠标滚动
(mouse-wheel-mode t)

;;(setq make-backup-files nil)
(setq backup-directory-alist '(("." . "~/.emacs.d/emacsback"))) 
;;(setq backup-directory-alist (quote (("." . "~/.emacs.d/emacsback")))

;;;;鼠标配置;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;确定使用的是滚轮鼠标
(show-paren-mode 1)
;;命令行下可以使用鼠标定位
(xterm-mouse-mode 0)

;;;;;TAB缩进配置;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)
(setq tab-stop-list ())
(setq c-basic-offset 4)


;;;; 显示行号：
;;(setq column-number-mode t)
;;(setq line-number-mode t)

;;;; 显示时间
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)



;;(set-default-font "Monospace-12")

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(case-fold-search t)
 '(current-language-environment "Chinese-GB")
 '(default-input-method "chinese-py-punct")
 '(delete-selection-mode nil nil (delsel))
 '(global-font-lock-mode t nil (font-lock))
 '(scroll-bar-mode (quote right))
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

;;(set-fontset-font "fontset-default"  'gb18030 '("Microsoft YaHei" . "unicode-bmp"))

;;这里的设置是为了在daemon模式下保证字体之类的设置起作用
;;(setq window-system-default-frame-alist
;;      '(
;;        ;; if frame created on x display
;;        (x
;;		 (Menu-bar-lines . nil)
;;		 (tool-bar-lines . 1)
;;		 (init-toolbar)
		 ;; mouse
;;		 (mouse-wheel-mode . 1)
;;		 (mouse-wheel-follow-mouse . t)
;;		 (mouse-avoidance-mode . 'exile)
		 ;; face
;;		 (font . "YaHei Consolas Hybrid 10")
;;		 )
        ;; if on term
;;        (nil
;;		 (menu-bar-lines . 0) (tool-bar-lines . 0)
		 ;; (background-color . "black")
		 ;; (foreground-color . "white")
;;		 )
;;		)
 ;;     )


;;(defun my-default-font()
;;(interactive)
;;(set-default-font "YaHei Consolas Hybrid:pixelsize=12:antialias=subpixel")
;;(set-default-font "simsun:pixelsize=12:antialias=subpixel")
;;(set-fontset-font "fontset-default" 'unicode '("YaHei Consolas Hybrid" . "unicode-bmp"))
;;)

;;(my-default-font)




;;(add-to-list 'after-make-frame-functions
;;(lambda (new-frame)
;;(select-frame new-frame)
;;(tool-bar-mode  0)
;;(my-default-font))) 

;;tabbar color
;;(custom-set-faces ;; custom-set-faces was added by Custom. 
;; If you edit it by hand, you could mess it up, so be careful. 
;; Your init file should contain only one such instance. 
;; If there is more than one, they won''t work right. 
;;'(tabbar-selected-face ((t (:inherit tabbar-default-face :background "black" :foreground "gray" :box (:line-width 2 :color "white" :style released-button))))) '(tabbar-unselected-face ((t (:inherit tabbar-default-face :foreground "red" :box (:line-width 2 :color "white" :style pressed-button))))))

(global-set-key [?\S- ] 'set-mark-command) 


;;设置滚屏相关参数
;;(setq scroll-step 1
;;scroll-margin 3
;;scroll-conservatively 10000)


;; 模拟鼠标滚轮
;; TODO: 怎样把他们绑定到C-m和C-u
;;(define-key   global-map   "\C-h" 'roll-down)
(defun roll-down (&optional n)
  "simulate roll down"
  (interactive "P")
  (if (null n) (setq n 7))
  (next-line n))
;;(define-key   global-map   "\C-u"  'roll-up)
(defun roll-up (&optional n)
  "simulate roll up"
  (interactive "P")
  (if (null n) (setq n 7))
  (previous-line n))
(when (eq system-type 'windows-nt)
        (prefer-coding-system 'gbk-dos))
(when (eq system-type 'gnu/linux)
        (prefer-coding-system 'utf-8-unix))
(setq default-buffer-file-coding-system 'utf-8-unix)



 (defun tabbar-buffer-groups (buffer)
   "Define tabbar groups depending on major mode and buffer name"
   (with-current-buffer (get-buffer buffer)
     (cond
      ((or (get-buffer-process (current-buffer))
           (memq major-mode
                 '(comint-mode compilation-mode)))
       '("Misc")
       )
      ((eq major-mode 'org-mode)
       '("org")
       )
      ((eq major-mode 'muse-mode)
       '("muse")
       )
      ((memq major-mode
             '(fundamental-mode help-mode apropos-mode Info-mode Man-mode))
       '("Misc")
       )
      ((memq major-mode
             '(c-mode c++-mode))
       '("Cpp")
       )
      ((eq major-mode 'emacs-lisp-mode)
       '("Emacs-lisp")
       )
      ((memq major-mode
             '(php-mode nxml-mode nxhtml-mode))
       '("WebDev")
       )
      ((memq major-mode
             '(tex-mode latex-mode text-mode snippet-mode))
       '("Text")
       )
      ((memq major-mode
             '(rmail-mode
               rmail-edit-mode vm-summary-mode vm-mode mail-mode
               mh-letter-mode mh-show-mode mh-folder-mode
               gnus-summary-mode message-mode gnus-group-mode
               gnus-article-mode score-mode gnus-browse-killed-mode))
       '("Mail")
       )
      ((string-equal "*" (substring (buffer-name) 0 1))
       '("Emacs Buffer")
       )
      (t
       '("Main")
       )
      )))
     



(setq frame-title-format "Lear@%b");在标题栏提示你目前在什么位置.
(setq frame-title-format;设置标题栏显示文件的完整路径名
'("%S" (buffer-file-name "%f"
(dired-directory dired-directory "%b"))))


;; ===== Smart copy, if no region active, it simply copy the current whole line =====
;; 超级复制 ，在没有选中的情况下，alt+w则为复制整行，alt+k为复制当前光标到句尾的内容
(defadvice kill-line (before check-position activate)
  (if (member major-mode
			  '(emacs-lisp-mode scheme-mode lisp-mode
								c-mode c++-mode objc-mode js-mode
								latex-mode plain-tex-mode))
	  (if (and (eolp) (not (bolp)))
		  (progn (forward-char 1)
				 (just-one-space 0)
				 (backward-char 1)))))
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
				 (message "Copied line")
				 (list (line-beginning-position)
					   (line-beginning-position 2)))))
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
	 (list (line-beginning-position)
		   (line-beginning-position 2)))))
;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
				  (line-end-position))
				  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
(global-set-key (kbd "M-k") 'qiang-copy-line)

;;copy 光标所在单词
(defun copy-word (&optional arg)
"Copy words at point"
(interactive "P")
(let ((beg (progn (if (looking-back "[_a-zA-Z0-9]" 1) (backward-word 1)) (point)))
   (end (progn (forward-word arg) (point))))
(copy-region-as-kill beg end))
)


;;(global-set-key (kbd "M-w") 'copy-word)

;; ======= 超级复制结束 =======================

;;;; 各窗口间切换
;;(global-map   "\M-b" 'windmove-left)
;;(global-set-key (kbd "<\M-b>") 'windmove-left)
;;(global-set-key [M-b] 'windmove-left)
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)
;;(global-set-key [M-f] 'windmove-right)
;;(global-set-key [M-p] 'windmove-up)
;;(global-set-key [M-n] 'windmove-down)
(global-set-key [f3] 'other-window)

;;linum+
;;(require 'linum+)

;在文件夹中搜索文件
(require 'color-moccur)
(global-set-key (kbd "C-c C-f") 'moccur-grep-find)

;;在buffer左侧显示行号
;;(dolist (hook (list
;;			   'c-mode-hook
	;;		   'c++-mode-hook
;;			   'emacs-lisp-mode-hook
;;										;'lisp-interaction-mode-hook
;;			   'lisp-mode-hook
;;			   'emms-playlist-mode-hook
;;			   'java-mode-hook
;;			   'asm-mode-hook
;;			   'haskell-mode-hook
;;			   'rcirc-mode-hook
;;			   'sh-mode-hook
;;			   'makefile-gmake-mode-hook
;;			   ))
;;  (add-hook hook (lambda () (linum-mode 1))))

;最大化
;(defun my-maximized ()
;  (interactive)
;  (x-send-client-message
;   nil 0 nil "_NET_WM_STATE" 32
;   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;  (x-send-client-message
;   nil 0 nil "_NET_WM_STATE" 32
;   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
;  )
;启动时最大化
;(my-maximized)

;;启动0.5秒后自动最大化 （windows下）  
(run-with-idle-timer 0.5 nil 'w32-send-sys-command 61488)  

;;;;高亮当前行
;;(require 'hl-line)
;;(global-hl-line-mode t)

;不生成 #filename# 临时文件
(setq auto-save-default nil)

(setq user-full-name "成奎")
(setq user-mail-address "ck4918@gmail.com")

;关闭启动画面
(custom-set-variables '(inhibit-startup-screen t))

(setq auto-mode-alist
(append '(("\\.txt\\'" . org-mode)) auto-mode-alist)) 

;;语法显示打文件慢，解决
(setq lazy-lock-defer-on-scrolling t)
;;(setq font-lock-support-mode 'lazy-lock-mode)
(setq font-lock-maximum-decoration t)


;; 如果没有激活的区域，就注释、反注释当前行，仅当在行尾的时候才在行尾加注释
;; 如果有选择区域，则注释整个区域
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and
we are not at the end of the line, then comment current line.
Replaces default behaviour of comment-dwim,
when it inserts comment at the end of the line. "
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)