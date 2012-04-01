;;; ck_emacs_scim_brige.el --- 

;; Copyright (C) 2010  ck

;; Author: ck <ck4918@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 
(when (eq system-type 'gnu/linux)
	(add-to-list 'load-path (expand-file-name "~/.emacs.d/packages/scim-brige"))
	
	;; 加载.
	(require 'scim-bridge-zh-si)
	 ;;; 如果你使用繁体中文, 用 (require 'scim-bridge-zh-tr) 替换.
	;; 加载 ~/.emacs 后自动开启 scim-mode.
	(add-hook 'after-init-hook 'scim-mode-on)
	;; 设置输入法切换键
	(scim-define-common-key (kbd "s-SPC") t)
	;;(scim-define-common-key (kbd "s-SPC") t)
	;; 使用 C-SPC 用作标记命令.
	(scim-define-common-key (kbd "C-SPC") nil)
	;; 使用 C-/ 用作撤销命令.
	(scim-define-common-key (kbd "C-\\") nil)
	;; 设置不同输入状态下光标颜色.
	(setq scim-cursor-color '("red" "blue" "limegreen"))
)
;;; Code:




;;; ck_emacs_scim_brige.el ends here
