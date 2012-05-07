;����xcscope�������Ķ�Դ��
;;(require 'xcscope)
;; ��Ļ������겻��
(global-set-key (kbd "C-n") (lambda (&optional n) (interactive "p")
(scroll-up (or n 1))))
(global-set-key (kbd "C-p") (lambda (&optional n) (interactive "p")
(scroll-down (or n 1))))

(require 'ido)
(ido-mode t)
 
''����򿪵��ļ�
(require 'recentf)
(recentf-mode t)

;; �Զ�Ϊ C/C++ ��ͷ�ļ���� #define ������
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

;;bm-mode ������ǩ��������ת
(require 'bm)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)
 
;;�Զ�ʶ���ļ�����
(require 'unicad)
(xterm-mouse-mode t)
;;(setq server-use-tcp t)
;;(setq server-host "192.168.0.133")

;;(require 'company)
;;(autoload 'company-mode "company" nil t)


;;google C ��ʽ
;;(require 'google-c-style)
;;(google-set-c-style t)
;;tramp
;;(add-to-list 'load-path "~/.emacs.d/packages/tramp-2.2.0/tramp-2.2.0/lisp")
(require 'tramp)
(setq tramp-default-method "plink")
;;(setq tramp-default-method "pscp")

;;����ҳ��ʱ�Ƚ��������Ҫ��ҳ�Ĺ���
(setq scroll-step 1
;;scroll-margin 3
scroll-conservatively 10000)

;;���е�������y/n��ʽ������yes/no��ʽ���е�����ֻ������һ����ĸ
(fset 'yes-or-no-p 'y-or-n-p)

;;abbrev����ģ��
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
;;(add-to-list load-path  ��~/emacs/site-lisp/color-theme��)
;;(load-file "~/.emacs.d/packages/color-theme-arjen.el")
;;(require 'color-theme)
;(color-theme-gnome2)
;(color-theme-zenburn)
;;(color-theme-arjen)
;;(color-theme-bharadwaj)
;;;; ����tabbar���
;; ����Ĭ������: ����, ������ǰ����ɫ����С
;;(set-face-attribute 'tabbar-default-face nil
;;                    :family "Vera Sans YuanTi Mono"
;;                    :background "gray80"
;;                    :foreground "gray30"
;;                    :height 1.0
;;                    )
;; ������߰�ť��ۣ�����ߴ�С����ɫ
;;(set-face-attribute 'tabbar-button-face nil
 ;;                   :inherit 'tabbar-default
;;                    :box '(:line-width 1 :color "gray30")
;;                    )
;; ���õ�ǰtab��ۣ���ɫ�����壬����С����ɫ
;;(set-face-attribute 'tabbar-selected-face nil
;;                    :inherit 'tabbar-default
;;                   :foreground "DarkGreen"
;;                    :background "LightGoldenrod"
;;                    :box '(:line-width 2 :color "DarkGoldenrod")
;;                    ;; :overline "black"
;;                    ;; :underline "black"
;;                    :weight 'bold
;;                    )
;; ���÷ǵ�ǰtab��ۣ�����С����ɫ
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

;;��ת����
(define-key   global-map   "\C-c\C-g"   'goto-line) 

;;(global-set-key [(f1)] 'eval-current-buffer )
;;pssvn
;;(require 'psvn)

;;�к�
;;(require 'linum+)
;;(global-linum-mode t)




;;ȥ��������
;;(when (eq system-type 'gnu/linux)
(tool-bar-mode nil)
(menu-bar-mode nil)
;;)

;;�������
;;(setq-default cursor-type 'bar)

;;(global-set-key [(control c control v)] 'uncomment-region)
;;(global-set-key [(f11)] 'eval-current-buffer )

;;�ر��Զ�����


;;֧��������
(mouse-wheel-mode t)

;;(setq make-backup-files nil)
(setq backup-directory-alist '(("." . "~/.emacs.d/emacsback"))) 
;;(setq backup-directory-alist (quote (("." . "~/.emacs.d/emacsback")))

;;;;�������;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ȷ��ʹ�õ��ǹ������
(show-paren-mode 1)
;;�������¿���ʹ����궨λ
(xterm-mouse-mode 0)

;;;;;TAB��������;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)
(setq tab-stop-list ())
(setq c-basic-offset 4)


;;;; ��ʾ�кţ�
;;(setq column-number-mode t)
;;(setq line-number-mode t)

;;;; ��ʾʱ��
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

;;�����������Ϊ����daemonģʽ�±�֤����֮�������������
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


;;���ù�����ز���
;;(setq scroll-step 1
;;scroll-margin 3
;;scroll-conservatively 10000)


;; ģ��������
;; TODO: ���������ǰ󶨵�C-m��C-u
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
     



(setq frame-title-format "Lear@%b");�ڱ�������ʾ��Ŀǰ��ʲôλ��.
(setq frame-title-format;���ñ�������ʾ�ļ�������·����
'("%S" (buffer-file-name "%f"
(dired-directory dired-directory "%b"))))


;; ===== Smart copy, if no region active, it simply copy the current whole line =====
;; �������� ����û��ѡ�е�����£�alt+w��Ϊ�������У�alt+kΪ���Ƶ�ǰ��굽��β������
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

;;copy ������ڵ���
(defun copy-word (&optional arg)
"Copy words at point"
(interactive "P")
(let ((beg (progn (if (looking-back "[_a-zA-Z0-9]" 1) (backward-word 1)) (point)))
   (end (progn (forward-word arg) (point))))
(copy-region-as-kill beg end))
)


;;(global-set-key (kbd "M-w") 'copy-word)

;; ======= �������ƽ��� =======================

;;;; �����ڼ��л�
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

;���ļ����������ļ�
(require 'color-moccur)
(global-set-key (kbd "C-c C-f") 'moccur-grep-find)

;;��buffer�����ʾ�к�
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

;���
;(defun my-maximized ()
;  (interactive)
;  (x-send-client-message
;   nil 0 nil "_NET_WM_STATE" 32
;   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;  (x-send-client-message
;   nil 0 nil "_NET_WM_STATE" 32
;   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
;  )
;����ʱ���
;(my-maximized)

;;����0.5����Զ���� ��windows�£�  
(run-with-idle-timer 0.5 nil 'w32-send-sys-command 61488)  

;;;;������ǰ��
;;(require 'hl-line)
;;(global-hl-line-mode t)

;������ #filename# ��ʱ�ļ�
(setq auto-save-default nil)

(setq user-full-name "�ɿ�")
(setq user-mail-address "ck4918@gmail.com")

;�ر���������
(custom-set-variables '(inhibit-startup-screen t))

(setq auto-mode-alist
(append '(("\\.txt\\'" . org-mode)) auto-mode-alist)) 

;;�﷨��ʾ���ļ��������
(setq lazy-lock-defer-on-scrolling t)
;;(setq font-lock-support-mode 'lazy-lock-mode)
(setq font-lock-maximum-decoration t)


;; ���û�м�������򣬾�ע�͡���ע�͵�ǰ�У���������β��ʱ�������β��ע��
;; �����ѡ��������ע����������
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