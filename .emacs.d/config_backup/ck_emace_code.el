;;;;;;;;;;cedet
(require 'cedet)
;;(ede-minor-mode t)
(semantic-load-enable-minimum-features)
(setq semanticdb-default-save-directory "~/.emacs.d/semanticdb")
(semantic-load-enable-code-helpers)
(global-set-key [(control tab)] 'semantic-ia-complete-symbol-menu)

;; start gdb
(global-set-key [f5] 'gdb)
;; toggle gdb-many-windows
(add-hook 'gdb-mode-hook
      '(lambda ()
         (local-set-key [(f6)] 'gdb-many-windows)
		 (local-set-key [(f10)] 'gud-next)
		 (local-set-key [(f11)] 'gud-step)
         )
)


(defconst c++-keywords 
  (sort 
   (list "and" "bool" "compl" "do" "export" "goto" "namespace" "or_eq" "return"
		 "struct" "try" "using" "xor" "and_eq" "break" "const" "double" "extern"
		 "if" "new" "private" "short" "switch" "typedef" "virtual" "xor_eq" "asm"
		 "case" "const_cast" "dynamic_cast" "false" "inline" "not" "protected" 
		 "signed" "template" "typeid" "void" "auto" "catch" "continue" "else" 
		 "float" "int" "not_eq" "public" "sizeof" "this" "typename" "volatile"
		 "bitand" "char" "default" "enum" "for" "long" "operator" "register"
		 "static" "throw" "union" "wchar_t" "bitor" "class" "delete" "explicit"
		 "friend" "mutable" "or" "reinterpret_cast" "static_cast" "true" 
		 "unsigned" "while" ) #'(lambda (a b) (> (length a) (length b)))))

(defvar ac-source-c++
  '((candidates
	 . (lambda ()
		 (all-completions ac-target c++-keywords))))
  "Source for c++ keywords.")

;;   (add-hook 'c++-mode-hook
;;             (lambda ()
;;               (make-local-variable 'ac-sources)
;;               (setq ac-sources '(ac-source-c++) '(ac-source-semantic))))


(eval-after-load "semantic-c" ;;e:/emacs/home 是我的 $HOME
'(dolist (d (list "D:/Dev-Cpp/include"
"D:/Dev-Cpp/include/c++/3.4.2"
;; "/usr/include/c++/4.1.0/backward"
;; "/usr/local/include"
;; "/usr/lib64/gcc/x86_64-suse-linux/4.1.0/include"
;; "/usr/lib64/gcc/x86_64-suse-linux/4.1.0/../../../../x86_64-suse-linux/include"
;; "/usr/include"
))
(semantic-add-system-include d))) 
;;下面配置一下semantic分析结果文件的存放目录。注意这个目录是要自己建立的。
;;(setq semanticdb-default-save-directory
;;(expand-file-name "~/.emacs.d/semanticdb")) 
;;头文件的查找目录定义好了，下面对 c-mode 做一些小小的定义：
(add-hook 'c-mode-common-hook
'(lambda()

(c-toggle-auto-hungry-state 1)
(c-set-style "K&R"))) 

(add-hook 'c++-mode-common-hook
(lambda()

(local-set-key "." 'semantic-complete-self-insert)
(local-set-key ">" 'semantic-complete-self-insert)
(c-toggle-auto-hungry-state 1)
(c-set-style "K&R")))


;;speedbar窗口合一版
(require 'sr-speedbar) 
(global-set-key [(f8)] 'sr-speedbar-toggle)
(global-set-key [(f7)] 'compile)

;;(require 'auto-complete)
;;(global-auto-complete-mode t)
;;(setq ac-auto-start 3)
;;(define-key ac-complete-mode-map "\C-n" 'ac-next)
;;(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;;(define-key ac-complete-mode-map "\t" 'ac-complete)
;;(define-key ac-complete-mode-map "\r" nil)
;;(add-hook 'emacs-lisp-mode-hook
;;		  (lambda ()
;;			(make-local-variable 'ac-sources)
;;			(setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))

;;; auto-complete-mode extension Gtags
;;(defun ac-gtags-candidate (prefix)
;;  (if (memq major-mode
;;			'(c-mode c++-mode))
;;	  (let ((option "-c")
;;			all-expansions
;;			expansion)
;;		(with-temp-buffer
;;		  (call-process "global" nil t nil option prefix)
;;		  (goto-char (point-min))
;;		  (while (looking-at gtags-symbol-regexp)
;;			(setq expansion (gtags-match-string 0))
;;			(setq all-expansions (cons expansion all-expansions))
;;			(forward-line)))
;;		all-expansions)))

;;(defvar ac-source-gtags
;;  '((candidates . (lambda () (all-completions ac-target (ac-gtags-candidate ac-target)))))
;;  "Source for gtags.")

;;(defun wl-add-ac-source-gtags ()
;;    (make-local-variable 'ac-sources)
;;    (add-to-list 'ac-sources 'ac-source-gtags))

;;(add-hook 'c++-mode-common-hook 'wl-add-ac-source-gtags)

;;(when (require-maybe 'auto-complete
;;(setq tags-table-list
;;	  '("~/.emacs.d" "/local/ckwork"))
;;(require 'auto-complete)
;;(require 'auto-complete-semantic)
;;(global-auto-complete-mode t)
;;(define-key ac-complete-mode-map "\C-n" 'ac-next)
;;(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;;(setq ac-auto-start 2)
;;(add-hook 'emacs-lisp-mode-hook
;;		  (lambda ()
;;			(make-local-variable 'ac-sources)
;;			;;(setq ac-sources '(ac-source-symbols ac-source-words-in-buffer ac-source-semantic))))
;;			(setq ac-sources '(ac-source-semantic))))
;;  (defvar ac-source-etags
;;    '((candidates
;;       . (lambda () (all-completions ac-target (tags-completion-table))))))
;;  (defun wl-add-ac-source-etags ()
;;    (make-local-variable 'ac-sources)
;;    (add-to-list 'ac-sources 'ac-source-etags))

;;(add-hook 'c-mode-common-hook 'wl-add-ac-source-etags)
;;(add-hook 'c-mode-common-hook)
;;(setq tags-file-name "/local/ckwork/TAGS")

;;(setq tags-table-list
;;	  '("~/.emacs.d" "/local/ckwork"))

(require 'semantic-ia)

(defun ac-semantic-candidate (prefix)
  (if (memq major-mode
            '(c-mode c++-mode))
      (mapcar 'semantic-tag-name
              (ignore-errors
                (or (semantic-ia-get-completions
                     (semantic-analyze-current-context) (point))
                    (senator-find-tag-for-completion (regexp-quote prefix)))))))

(defvar ac-source-semantic
  '((candidates . (lambda () (all-completions ac-prefix (ac-semantic-candidate ac-prefix)))))
  "Source for semantic.")

(provide 'auto-complete-semantic)


(when (require 'auto-complete nil t)
 (global-auto-complete-mode t)
 (require 'auto-complete-semantic)
 (define-key ac-complete-mode-map "\C-n" 'ac-next)
 (define-key ac-complete-mode-map "\C-p" 'ac-previous)	
 (setq ac-auto-start t)
 (setq ac-sources '(ac-source-c++ ac-source-abbrev ac-source-words-in-buffer ac-source-filename ac-source-semantic))
	
(add-hook 'c-mode-common-hook
          '(lambda ()
             (add-to-list 'ac-omni-completion-sources
                          (cons "\\." '(ac-source-semantic)))
             (add-to-list 'ac-omni-completion-sources
                          (cons "->" '(ac-source-semantic)))
;;                         (xgtags-mode 1)
             (add-to-list 'ac-sources )
                         ))
                         )

(add-hook 'c++-mode-hook '(lambda ()
                            (add-to-list 'ac-sources 'ac-c++-sources)))
