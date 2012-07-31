;;;;;;;;;;cedet����
(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
;; (load-file "~/.emacs.d/cedet-1.1/lisp/cedet/cedet.el")
;; (load-file "~/.emacs.d/packages/ecb-2.40/ecb.elc")

;;(load-file "~/.emacs.d/packages/tramp-2.2.0/tramp-2.2.0/lisp/tramp.el")
;;(require 'tramp)
(require 'cedet)
(require 'ede)
;;(require 'ecb)
;;(require 'ecb-autoloads)
;;(setq ecb-auto-activate t
;;     ecb-tip-of-the-day nil)
;;; ���غ���ʾecb����
;;(define-key global-map [(f11)] 'ecb-hide-ecb-windows)
;;(define-key global-map [(f12)] 'ecb-show-ecb-windows)
 
(global-ede-mode t)

(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
;;(global-semantic-idle-completions-mode 1);;.��->�Զ����ֳ�Ա��ȫ
;;(global-set-key [C-c C-g] 'semantic-ia-fast-jump);;��ת��������
(global-set-key (kbd "C-c g") 'semantic-ia-fast-jump);;��ת��������
(define-key c-mode-base-map (kbd "C-c s") 'semantic-analyze-proto-impl-toggle);;������������������ת
(define-key c-mode-base-map (kbd "M-n") 'semantic-ia-complete-symbol-menu);;����semantic����ȫ
(define-key c-mode-base-map (kbd "C-c m") 'eassist-list-methods);;����semantic����ú����б�
(define-key c-mode-base-map (kbd "C-c o") 'eassist-switch-h-cpp);;����semantic���л�ͷ�ļ��ͳ����ļ�

;;���˺����������ת�ظղŵĵط�
(global-set-key (kbd "C-c b")
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

;;�����۵�
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)
;;���û�ȡ�������۵�
(global-set-key (kbd "C-M-o") 'global-semantic-tag-folding-mode)
;;�����۵���ݼ�
(define-key semantic-tag-folding-mode-map (kbd "\C-c , -") 'semantic-tag-folding-fold-block)
(define-key semantic-tag-folding-mode-map (kbd "\C-c , +") 'semantic-tag-folding-show-block)
;;����buffer�����۵�
(define-key semantic-tag-folding-mode-map (kbd "\C-c -") 'semantic-tag-folding-fold-all)
(define-key semantic-tag-folding-mode-map (kbd "\C-c +") 'semantic-tag-folding-show-all)

(defconst user-include-dirs
  (list "." "../include" "../framework" "FrameWork" "../FrameWork" "../../FrameWork" "src" "include"))
(defconst linux-include-dirs
  (list "/usr/include"
        "/usr/local/gcc4.1.0/include/c++/4.1.0"))
(defconst win32-include-dirs
  (list "C:/MinGW/lib/gcc/mingw32/4.5.2/include/c++"
		"C:/MinGW/lib/gcc/mingw32/4.5.2/include/c++/mingw32"
		"C:/MinGW/include"))
(require 'semantic-c nil 'noerror);;����
(let ((include-dirs user-include-dirs))
  (when (eq system-type 'windows-nt)
    (setq include-dirs (append include-dirs win32-include-dirs)))
  (when (eq system-type 'gnu/linux)
    (setq include-dirs (append include-dirs linux-include-dirs)))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))
;;(semantic-add-system-include d))) 
;;��������һ��semantic��������ļ��Ĵ��Ŀ¼��ע�����Ŀ¼��Ҫ�Լ������ġ�
(setq semanticdb-default-save-directory
(expand-file-name "~/.emacs.d/semanticdb")) 


;;;; C-mode-hooks .
(defun yyc/c-mode-keys ()
  "description"
  ;; Semantic functions.
  (semantic-default-c-setup)
  (local-set-key [(meta return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-cp" 'semantic-ia-show-summary)
  (local-set-key "\C-cl" 'semantic-ia-show-doc)
  ;;(local-set-key "." 'semantic-complete-self-insert)
  ;;(local-set-key ">" 'semantic-complete-self-insert)
  ;; Indent or complete
  ;;(local-set-key  [(tab)] 'indent-or-complete)
  )
(add-hook 'c-mode-common-hook 'yyc/c-mode-keys)


