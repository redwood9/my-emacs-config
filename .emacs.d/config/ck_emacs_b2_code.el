;;(require 'company-clang)
;;(autoload 'company-mode "company" nil t)
;;(setq company-idle-delay nil)
;;(define-key company-mode-map [(backtab)] 'company-complete-common)


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



;;头文件的查找目录定义好了，下面对 c-mode 做一些小小的定义：
(add-hook 'c-mode-common-hook
'(lambda()
;;(c-toggle-auto-hungry-state 1)
(c-set-style "K&R"))) 

(add-hook 'c++-mode-common-hook
(lambda()
;;(c-toggle-auto-hungry-state 1)
(c-set-style "K&R"))) 



;;(add-to-list 'load-path "/usr/share/emacs/21.3/speedbar")
;;(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
;;(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
;;(global-set-key [(f6)] 'speedbar-get-focus)
;;speedbar窗口合一版
(require 'sr-speedbar) 
(global-set-key [(f8)] 'sr-speedbar-toggle)
(global-set-key [(f7)] 'compile)

;;auto-complete模式配置
;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; (global-auto-complete-mode t)
(add-to-list 'load-path "~/.emacs.d/packages/autocomplete/") ;This may not be appeared if you have already added.
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/packages/autocomplete/ac-dict")
(ac-config-default)
(setq ac-auto-start t)
(setq ac-delay 0.2)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(add-to-list 'ac-sources '(ac-source-semantic-raw))
;;(set-default 'ac-sources '(ac-source-semantic-raw))
;;(setq ac-auto-start 2)
;;(setq ac-dwim t)
;;(set-default 'ac-sources '(ac-source-abbrev ac-source-words-in-buffer))

;;auto-complete C++模式配置
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
		 "friend" "mutable" "or" "reinterpret_cast" "static_cast" "true" "printf" 
		 "iostream" "sprintf" "snprintf"
		 "unsigned" "while" "isalnum" "isalpha" "isascii" "iscntrl" "isdigit" "isgraphis" 
		 "islower" "isprint" "isspace" "ispunct" "isupper" "isxdigit" "atof" "atoi" "atol" 
		 "gcvt" "strtod" "strtol" "strtoul"  "toascii" "tolower" "toupper" "calloc" "free" 
		 "getpagesize"  "malloc" "mmap" "munmap"  "asctime" "ctime" "gettimeofday" "gmtime" 
		 "localtime" "mktime" "settimeofday"  "time" "bcmp" "bcopy" "bzero" "index" "memccpy"
		 "memchr" "memcmp" "memcpy" "memmove" "memset"  "rindex" "strcasecmp" "strcat" "strchr" 
		 "strcmp" "strcoll" "strcpy" "strcspn" "strdup" "strlen" "strncasecmp" "strncat" "strncpy" "strpbrk" "strrchr" "strspn" "strstr" "strtok" "abs" "acos" "asin" "atan" "atan2" "ceil" "cos" "cosh" "exp" "frexp" "ldexp" "log" "log10" "pow" "sin" "sinh" "sqrt" "tan" "tanh" "endgrent" "endpwent" "endutent" "fgetgrent" "fgetpwent" "getegid" "geteuid" "getgid" "getgrent" "getgrgid" "getgrnam" "getgroups" "getpw" "getpwent" "getpwnam" "getpwuid" "getuid" "getutent" "getutid" "getutline" "initgroups" "pututline" "seteuid" "setfsgid" "setfsuid" "setgid" "setgrent" "setgroups" "setpwent" "setregid" "setreuid" "setuid" "setutent" "utmpname" "crypt" "bsearch" "lfind" "lsearch" "qsort" "rand" "srand" "close" "creat" "dup" "dup2" "fcntl" "flock" "fsync" "lseek" "mkstemp" "open" "read" "sync" "write" "clearerr" "fclose" "fdopen" "feof" "fflush" "fgetc" "fgets" "fileno" "fopen" "fputc" "fputs" "fread" "freopen" "fseek" "ftell" "fwrite" "getc" "getchar" "gets" "mktemp" "putc" "putchar" "rewind" "setbuf" "setbuffer" "setlinebuf" "setvbuf" "ungetc" "atexit" "execl" "execlp" "execv" "execve" "execvp" "exit" "_exit" "vfork" "getpgid" "getpgrp" "getpid"  "getppid" "getpriority" "nice" "on_exit" "setpgid"  "setpgrp" "setpriority" "system"  "wait" "waitpid" "fprintf"  "fscanf" "printf" "sacnf" "sprintf" "sscanf"  "vfprintf" "vfscanf" "vprintf" "vscanf"  "vsprintf" "vsscanf" "access"  "alphasort" "chdir" "chmod" "chown" "chroot"  "closedir" "fchdir" "fchmod" "fchown" "fstat" "ftruncate" "getcwd" "link" "lstat" "opendir" "readdir" "readlink" "remove" "rename" "rewinddir" "seekdir" "stat" "symlink" "telldir" "truncate" "umask" "unlink" "utime" "utimes" "alarm" "kill" "pause" "sigaction" "sigaddset" "sigdelset" "sigemptyset" "sigfillset" "sigismember" "signal" "sigpending" "sigprocmask" "sleep" "ferror" "perror" "strerror" "mkfifo" "pclose" "pipe" "popen" "accept" "bind" "connect" "endprotoent" "endservent" "getsockopt" "htonl" "htons" "inet_addr" "inet_aton" "inet_ntoa" "listen" "ntohl" "ntohs" "recv" "recvfrom" "recvmsg" "send" "sendmsg" "sendto" "setprotoent"  "setservent" "setsockopt" "shutdown" "socket" "getenv" "putenv" "setenv" "getopt" "isatty" "select" "ttyname") #'(lambda (a b) (> (length a) (length b)))))

(defvar ac-source-c++
  '((candidates
	 . (lambda ()
		 (all-completions ac-target c++-keywords))))
  "Source for c++ keywords.")
(add-hook 'c++-mode-hook
		  (lambda ()
		  ;;(menu-bar-mode nil)
			(make-local-variable 'ac-sources)
			;;(setq ac-sources '(ac-source-semantic ac-source-c++ ac-source-abbrev ac-source-words-in-buffer ))
			(setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer ))
			))

(add-hook 'emacs-lisp-mode-hook
		  (lambda ()
			(make-local-variable 'ac-sources)
			(setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))


;;(setq tags-file-name "/local/ckwork/TAGS")

;;(setq tags-table-list
;;	  '("~/.emacs.d" "/local/ckwork"))

;;(add-hook 'c-mode-hook '(lambda () 
;;        (company-mode)
;;        ))
;;(add-hook 'c++-mode-hook '(lambda () 
;;        (company-mode)
;;        ))

(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(global-set-key [(backtab)] 'company-complete-common)

(setq imenu-auto-rescan t)

;;(load-library "clang-completion-mode")


;;====拷贝代码自动格式化=======
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
	  (and (not current-prefix-arg)
		   (member major-mode
				   '(emacs-lisp-mode
					 lisp-mode
					 clojure-mode
					 scheme-mode
					 haskell-mode
					 ruby-mode
					 rspec-mode
					 python-mode
					 c-mode
					 c++-mode
					 objc-mode
					 latex-mode
					 js-mode
					 plain-tex-mode))
		   (let ((mark-even-if-inactive transient-mark-mode))
			 (indent-region (region-beginning) (region-end) nil)))))
)
;;====拷贝代码自动格式化=====

;;====自动补全括号=====
;;(defun mode-auto-pair ()
;;(interactive)
;;(make-local-variable 'skeleton-pair-alist)
;;(setq skeleton-pair-alist '(
;;(?\" ? _ " \"")
;;(?\' ? _ " '")
;;(?\( ? _ " )")
;;(?\[ ? _ " ]")
;;(?\{ ? _ " } ")
;;))

;;(setq skeleton-pair t)
;;(local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
;;(local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
;;(local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
;;(local-set-key (kbd "'") 'skeleton-pair-insert-maybe)
;;(local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
;;(add-hook 'c++-mode-hook 'mode-auto-pair) 
;;====自动补全括号=====


;; 对这些模式重新配置 enter 键, 使得按 enter 换行时可以自动缩进
(add-hook 'c-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'c-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'c++-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'c++-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'java-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'java-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'scheme-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'scheme-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'perl-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'perl-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'javascript-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'javascript-mode-hook (lambda () (setq comment-column 48) ))

(add-hook 'idlwave-mode-hook
          (lambda ()
            (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'f90-mode-hook
            (lambda ()
                (local-set-key [(return)] 'newline-and-indent)))

;;(add-to-list 'load-path "~/.emacs.d/packages/jquery-doc")
(require 'jquery-doc)
;; adds ac-source-jquery to the ac-sources list
(add-hook 'js2-mode-hook 'jquery-doc-setup)

;;nxhtml
;;(load "~/.emacs.d/packages/nxhtml/autostart.el")

;;javascript配置
;;speedbar
(speedbar-add-supported-extension ".js")

;;加载js2-mode

;;(autoload 'espresso-mode "espresso")
(autoload 'espresso-mode "espresso" nil t)
(setq espresso-indent-level 4
	  indent-tabs-mode nil
	  c-basic-offset 4)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;(require 'js2-highlight-vars)
;;解决js2缩进问题
(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           node)

      (save-excursion

        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        (if (looking-at "case\\s-")
            (setq indentation (+ indentation (/ espresso-indent-level 2))))

        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))

      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))
;;范围格式化
(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))

(defun my-js2-mode-hook ()
  (require 'espresso)
  (setq espresso-indent-level 4
        indent-tabs-mode nil
        c-basic-offset 4)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
  (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js2-mode-map [(meta control \;)] 
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map [(control meta q)] 'my-indent-sexp)
  ;;(if (featurep 'js2-highlight-vars)
;;	  (js2-highlight-vars-mode))
  (message "My JS2 hook"))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)
;;js2-mode配置完成


(global-set-key [f5] 'slime-js-reload)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))

(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))


(require 'ace-jump-mode)
(define-key global-map (kbd "C-c C-c") 'ace-jump-mode)

;;slime
(require 'slime)
(require 'slime-repl)
(slime-setup '(slime-repl))
(slime-setup '(slime-js))

;;load zencoding mode
(require 'zencoding-mode)

;;auto load hs-minor 代码折叠
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'javascript-mode-hook       'hs-minor-mode 'linum-mode)
(add-hook 'php-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(add-hook 'html-mode-hook         'hs-minor-mode 'zencoding-mode 'multi-web-mode)
(global-set-key [f1] 'hs-toggle-hiding)

;;config mutil-web-mode
;;可以在一个buffer中使用多个mode
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
;;指定在哪些标签包围的时候使用指定mode
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)


;;在html和css文件修改后，让firefox中的文件自动加载
(defun auto-reload-firefox-on-after-save-hook ()         
          (add-hook 'after-save-hook
                       '(lambda ()
                          (interactive)
                          (comint-send-string (inferior-moz-process)
                                              "setTimeout(BrowserReload(), \"100\");"))
                       'append 'local)) ; buffer-local

;; Example - you may want to add hooks for your own modes.
;; I also add this to python-mode when doing django development.
(add-hook 'html-mode-hook 'auto-reload-firefox-on-after-save-hook)
(add-hook 'css-mode-hook 'auto-reload-firefox-on-after-save-hook)


;;利用rainbow对css中的颜色自动染色
;; CSS and Rainbow modes 
(require 'rainbow-mode)
(defun all-css-modes() (css-mode) (rainbow-mode)) 
;; Load both major and minor modes in one call based on file type 
(add-to-list 'auto-mode-alist '("\\.css$" . all-css-modes)) 

;;load ecb
(add-to-list 'load-path
                     "~/.emacs.d/packages/ecb")
(require 'ecb)
(setq stack-trace-on-error t)
;;(require 'ecb-autoloads)
