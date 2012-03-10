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
(c-toggle-auto-hungry-state 1)
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
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(setq ac-auto-start 3)
(setq ac-dwim t)
(set-default 'ac-sources '(ac-source-abbrev ac-source-words-in-buffer))

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
