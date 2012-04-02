(require 'org-install)
(require 'org-publish)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook 
		  (lambda () (setq truncate-lines nil)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-publish-project-alist
      '(("note-org"
         :base-directory "X:/OrgMode/org"
         :publishing-directory "X:/OrgMode/publish"
         :base-extension "org"
         :recursive t
         :publishing-function org-publish-org-to-html
         :auto-index nil
         :index-filename "index.org"
         :index-title "index"
         :link-home "index.html"
         :section-numbers nil
         :style "<link rel=\"stylesheet\"
    href=\"./style/emacs.css\"
    type=\"text/css\"/>")
        ("note-static"
         :base-directory "X:/OrgMode/org"
         :publishing-directory "X:/OrgMode/publish"
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
         :publishing-function org-publish-attachment)
        ("note" 
         :components ("note-org" "note-static")
         :author "ck4918@gmail.com"
         )))

(global-set-key (kbd "<f12> p") 'org-publish)

;(setq ac-modes
;      (append ac-modes '(org-mode objc-mode jde-mode sql-mode
;                                  change-log-mode text-mode
;                                  makefile-gmake-mode makefile-bsdmake-mo
;                                  autoconf-mode makefile-automake-mode)))
