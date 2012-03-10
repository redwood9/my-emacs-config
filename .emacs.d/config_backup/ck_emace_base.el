;;(require 'php-mode)

(require 'tramp)
(setq tramp-default-method "plink")

;;加载xcscope，方便阅读源码
;;(require 'xcscope)

;;行号
;;(set-scroll-bar-mode nil)
;;(require 'wb-line-number)
;;(wb-line-number-toggle)


(xterm-mouse-mode t)
;;(setq server-use-tcp t)
;;(setq server-host "192.168.0.183")

(setq-default abbrev-mode t)
;; do not bug me about saving my abbreviations
(setq save-abbrevs nil)
;; load up abbrevs for these modes
(require 'shell)
(require 'cc-mode)

(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key [(f9)] 'ibuffer )
(autoload 'ibuffer "ibuffer" "List buffers." t)


(require 'msf-abbrev)
(setq msf-abbrev-root "~/.emacs.d/mode-abbrevs")
(msf-abbrev-load)

;; use C-c a to define a new abbrev for this mode
(global-set-key (kbd "C-c a") 'msf-abbrev-define-new-abbrev-this-mode)




;;tabbar
(require 'tabbar)
(tabbar-mode t)

(setq x-select-enable-clipboard t)

;;前景色
;;(set-foreground-color "magenta")

(require 'color-theme)
;;(color-theme-blue-mood)
(color-theme-arjen)

;;跳转行数
(define-key   global-map   "\C-c\C-g"   'goto-line) 

;;(global-set-key [(f1)] 'eval-current-buffer )
;;pssvn
;;(require 'psvn)

;;行号
(global-linum-mode t)

;;去掉工具栏
(tool-bar-mode nil)
(menu-bar-mode nil)

;;光标设置
(setq-default cursor-type 'bar)

;;(global-set-key [(control c control v)] 'uncomment-region)
(global-set-key [(f11)] 'eval-current-buffer )

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
(xterm-mouse-mode 1)

;;;;;TAB缩进配置;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)
(setq tab-stop-list ())
(setq c-basic-offset 4)


;;;; 显示行号：
(setq column-number-mode t)
(setq line-number-mode t)

;;;; 显示时间
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

(prefer-coding-system 'gbk) 

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


(set-fontset-font "fontset-default"  'gb18030 '("Microsoft YaHei" . "unicode-bmp"))

(defun my-default-font()
(interactive)
(set-default-font "Comic Sans MS:pixelsize=13:antialias=subpixel")
(set-fontset-font "fontset-default"
'unicode '("Microsoft YaHei" . "unicode-bmp"))
)

(my-default-font)
(add-to-list 'after-make-frame-functions
(lambda (new-frame)
(select-frame new-frame)
(tool-bar-mode  0)
(my-default-font))) 

;;tabbar color
(custom-set-faces ;; custom-set-faces was added by Custom. 
;; If you edit it by hand, you could mess it up, so be careful. 
;; Your init file should contain only one such instance. 
;; If there is more than one, they won''t work right. 
'(tabbar-selected-face ((t (:inherit tabbar-default-face :background "black" :foreground "green" :box (:line-width 2 :color "#102e4e" :style released-button))))) 
'(tabbar-unselected-face ((t (:inherit tabbar-default-face :background "black" :foreground "white" :box (:line-width 2 :color "white" :style pressed-button))))))

;;(global-set-key [?\S- ] 'set-mark-command) 


;;设置滚屏相关参数
;;(setq scroll-step 1
;;scroll-margin 3
;;scroll-conservatively 10000)


;; 模拟鼠标滚轮
;; TODO: 怎样把他们绑定到C-m和C-u
(define-key   global-map   "\C-h" 'roll-down)
(defun roll-down (&optional n)
  "simulate roll down"
  (interactive "P")
  (if (null n) (setq n 7))
  (next-line n))
(define-key   global-map   "\C-u"  'roll-up)
(defun roll-up (&optional n)
  "simulate roll up"
  (interactive "P")
  (if (null n) (setq n 7))
  (previous-line n))
