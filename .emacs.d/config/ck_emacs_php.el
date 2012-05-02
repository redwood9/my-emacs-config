(require 'php-mode)

;(add-hook 'php-mode-hook
;		  (lambda()
;			(menu-bar-mode t)
;			(imenu-add-menubar-index)
;			)
;		  )
;;xdebug emacs 调试支持
;
;(autoload 'geben "geben" "PHP Debugger on Emacs" t)


;   ;; Load the php-imenu index function
;   (autoload 'php-imenu-create-index "php-imenu" nil t)
;   ;; Add the index creation function to the php-mode-hook 
;   ;; In php-mode 1.2, it's php-mode-user-hook.  In 1.4, it's php-mode-hook.
;   (add-hook 'php-mode-user-hook 'php-imenu-setup)
;   (defun php-imenu-setup ()
;     (setq imenu-create-index-function (function php-imenu-create-index))
;     ;; uncomment if you prefer speedbar:
;     ;(setq php-imenu-alist-postprocessor (function reverse))
;     (imenu-add-menubar-index)
;   )



(add-hook 'php-mode-hook 'my-php-mode-stuff)

(defun my-php-mode-stuff ()
  (local-set-key (kbd "<f1>") 'my-php-function-lookup)
  (local-set-key (kbd "C-<f1>") 'my-php-symbol-lookup))


(defun my-php-symbol-lookup ()
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if (not symbol)
        (message "No symbol at point.")

      (browse-url (concat "http://php.net/manual-lookup.php?pattern="
                          (symbol-name symbol))))))


(defun my-php-function-lookup ()
  (interactive)
  (let* ((function (symbol-name (or (symbol-at-point)
                                    (error "No function at point."))))
         (buf (url-retrieve-synchronously (concat "http://php.net/manual-lookup.php?pattern=" function))))
    (with-current-buffer buf
      (goto-char (point-min))
	  (let (desc)
		(when (re-search-forward "<div class=\"methodsynopsis dc-description\">\\(\\(.\\|\n\\)*?\\)</div>" nil t)
		  (setq desc
				(replace-regexp-in-string
				 " +" " "
				 (replace-regexp-in-string
                  "\n" ""
                  (replace-regexp-in-string "<.*?>" "" (match-string-no-properties 1)))))
		  
		  (when (re-search-forward "<p class=\"para rdfs-comment\">\\(\\(.\\|\n\\)*?\\)</p>" nil t)
			(setq desc
				  (concat desc "\n\n"
						  (replace-regexp-in-string
						   " +" " "
						   (replace-regexp-in-string
							"\n" ""
							(replace-regexp-in-string "<.*?>" "" (match-string-no-properties 1))))))))
		(if desc
			(message desc)
		  (message "Could not extract function info. Press C-F1 to go the description."))))
    (kill-buffer buf)))




 ;;(add-hook 'php-mode-hook
 ;;          (lambda ()
 ;;            (require 'php-completion)
 ;;            (php-completion-mode t)
 ;;            (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)))
;; ---------------------------------------------------

;; Cooperation with auto-complete.el:
;;
;; add these lines to your .emacs file:
 (add-hook  'php-mode-hook
            (lambda ()
              (when (require 'auto-complete nil t)
                (make-variable-buffer-local 'ac-sources)
                ;;(add-to-list 'ac-sources 'ac-source-php-completion)
                ;; if you like patial match,
;;                ;; use `ac-source-php-completion-patial' instead of `ac-source-php-completion'.
;;                ;; (add-to-list 'ac-sources 'ac-source-php-completion-patial)
                (auto-complete-mode t))))


;; php文件加入speedbar
;;(eval-after-load "speedbar" '(speedbar-add-supported-extension ".php"))
'(php-mode-speedbar-open t)
'(php-speedbar-config nil)
'(speedbar-load-hook nil)
'(speedbar-show-unknown-files t)
'(speedbar-supported-extension-expressions (quote (".php" ".pac"
												   ".js" "\\.\\(inc\\|php[s34]?\\)" ".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\
\)?" ".tex\\(i\\(nfo\\)?\\)?" ".el" ".emacs" ".l" ".lsp" ".p" ".java"
".f\\(90\\|77\\|or\\)?" ".ada" ".p[lm]" ".tcl" ".m" ".scm" ".pm" ".py"
".g" ".s?html" ".ma?k" "[Mm]akefile\\(\\.in\\)?")))
'(speedbar-track-mouse-flag t)
'(speedbar-use-imenu-flag t)
'(speedbar-verbosity-level 10)