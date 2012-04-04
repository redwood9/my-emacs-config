(require 'server)
(when (and (= emacs-major-version 23)
           (= emacs-minor-version 3)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
                                                 ; ~/.emacs.d/server is unsafe"
                                                 ; on windows.

(server-start)
(load "~/.emacs.d/packages/subdirs.el") 
(mapc 'load (directory-files "~/.emacs.d/config" t "\.el$"))

(put 'scroll-left 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "Chinese-GB")
 '(default-input-method "chinese-py-punct")
 '(delete-selection-mode nil nil (delsel))
 '(display-time-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(tabbar-selected-face ((t (:inherit tabbar-default-face :background "black" :foreground "gray" :box (:line-width 2 :color "white" :style released-button)))))
 '(tabbar-unselected-face ((t (:inherit tabbar-default-face :foreground "red" :box (:line-width 2 :color "white" :style pressed-button))))))


(prefer-coding-system 'gbk-dos) 

