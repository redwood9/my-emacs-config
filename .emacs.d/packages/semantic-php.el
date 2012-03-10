;;; semantic-php.el --- Semantic details for PHP files

;;; Copyright (C) 2008 Sacha Chua

;; Author: Sacha Chua <sacha@sachachua.com>
;; X-RCS: $Id: semantic-texi.el,v 1.35 2007/05/20 16:06:35 zappo Exp $

;; This file is not part of GNU Emacs.

;; This is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This software is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Parse PHP using regular expressions.  The core parser
;; engine is the function `semantic-php-parse-file'.  The
;; parser plug-in is the function `semantic-php-parse-region' that
;; overrides `semantic-parse-region'.

(require 'semantic)
(require 'semantic-format)

(eval-when-compile
  (require 'semanticdb)
  (require 'semanticdb-find)
  (require 'semantic-ctxt)
  (require 'semantic-imenu)
  (require 'semantic-doc)
  (require 'senator))

(defvar semantic-php-super-regex
  "^[ \t]*function"
  "Regular expression used to find special sections in a PHP file.")

(defvar semantic-php-name-field-list
  '( ("defvar" . 1)
     ("defvarx" . 1)
     ("defun" . 1)
     ("defunx" . 1)
     ("defopt" . 1)
     ("deffn" . 2)
     ("deffnx" . 2)
     )
  "List of definition commands, and the field position.
The field position is the field number (based at 1) where the
name of this section is.")

;;; Code:
(defun semantic-php-parse-region (&rest ignore)
  "Parse the current phpnfo buffer for semantic tags.
IGNORE any arguments, always parse the whole buffer.
Each tag returned is of the form:
 (\"NAME\" section (:members CHILDREN))
or
 (\"NAME\" def)

It is an override of 'parse-region and must be installed by the
function `semantic-install-function-overrides'."
  (mapcar 'semantic-php-expand-tag
          (semantic-php-parse-file)))

(defun semantic-php-parse-changes ()
  "Parse changes in the current PHP buffer."
  ;; NOTE: For now, just schedule a full reparse.
  ;;       To be implemented later.
  (semantic-parse-tree-set-needs-rebuild))

(defun semantic-php-expand-tag (tag)
  "Expand the PHP tag TAG."
  (let ((chil (semantic-tag-components tag)))
    (if chil
        (semantic-tag-put-attribute
         tag :members (mapcar 'semantic-php-expand-tag chil)))
    (car (semantic--tag-expand tag))))

(defun semantic-php-parse-file ()
  "Parse the current PHP buffer for all semantic tags now."
  (let ((pass1 nil))
    ;; First search and snarf.
    (save-excursion
      (goto-char (point-min))
      (working-status-forms (file-name-nondirectory buffer-file-name) "done"
	(while (re-search-forward "^[ \t]*function[ \t]+\\([^ (]+\\)[ \t]( nil t)"
	  (setq pass1 (cons (match-beginning 0) pass1))
	  (working-status)
	  )
	(working-status t)))
    (setq pass1 (nreverse pass1))
    ;; Now, make some tags while creating a set of children.
    (car (semantic-php-recursive-combobulate-list pass1 0))
    )))

(defsubst semantic-php-new-section-tag (name members start end)
  "Create a semantic tag of class section.
NAME is the name of this section.
MEMBERS is a list of semantic tags representing the elements that make
up this section.
START and END define the location of data described by the tag."
  (append (semantic-tag name 'section :members members)
          (list start end)))

(defsubst semantic-php-new-def-tag (name start end)
  "Create a semantic tag of class def.
NAME is the name of this definition.
START and END define the location of data described by the tag."
  (append (semantic-tag name 'def)
          (list start end)))

(defun semantic-php-set-endpoint (metataglist pnt)
  "Set the end point of the first section tag in METATAGLIST to PNT.
METATAGLIST is a list of tags in the intermediate tag format used by the
php parser.  PNT is the new point to set."
  (let ((metatag nil))
    (while (and metataglist
		(not (eq (semantic-tag-class (car metataglist)) 'section)))
      (setq metataglist (cdr metataglist)))
    (setq metatag (car metataglist))
    (when metatag
      (setcar (nthcdr (1- (length metatag)) metatag) pnt)
      metatag)))

(defun semantic-php-forward-deffn ()
  "Move forward over one deffn type definition.
The cursor should be on the @ sign."
  (when (looking-at "@\\(\\w+\\)")
    (let* ((type (match-string 1))
	   (seek (concat "^@end\\s-+" (regexp-quote type))))
      (re-search-forward seek nil t))))

(define-mode-local-override semantic-tag-components
  php-mode (tag)
  "Return components belonging to TAG."
  (semantic-tag-get-attribute tag :members))

(define-mode-local-override semantic-insert-foreign-tag
  php-mode (foreign-tag)
  "Insert TAG from a foreign buffer in TAGFILE.
Assume TAGFILE is a source buffer, and create a documentation
thingy from it using the `document' tool."
  ;; This makes sure that TAG will be in an active buffer.
  (let ((b (semantic-tag-buffer foreign-tag)))
    ;; Now call the document insert thingy.
    (require 'document)
    (document-insert-php foreign-tag b)))


(define-mode-local-override semantic-ctxt-current-class-list
  php-mode (&optional point)
  "Determine the class of tags that can be used at POINT.
For php, there two possibilities returned.
1) 'function - for a call to a php function
2) 'word     - indicates an english word.
It would be nice to know function arguments too, but not today."
  (let ((sym (semantic-ctxt-current-symbol)))
    (if (and sym (= (aref (car sym) 0) ?@))
	'(function)
      '(word))))

(define-mode-local-override semantic-format-tag-abbreviate
  php-mode  (tag &optional parent color)
  "Php tags abbreviation."
  (let ((class (semantic-tag-class tag))
	(name (semantic-format-tag-name tag parent color))
	)
    (cond ((eq class 'function)
	   (concat name "{ }"))
	  (t (semantic-format-tag-abbreviate-default tag parent color)))
    ))

(define-mode-local-override semantic-format-tag-prototype
  php-mode  (tag &optional parent color)
  "Php tags abbreviation."
  (semantic-format-tag-abbreviate tag parent color))

(eval-when-compile
  (require 'semantic-analyze))

(define-mode-local-override semantic-analyze-current-context
  php-mode (point)
  "Analysis context makes no sense for php.  Return nil."
  (let* ((prefixandbounds (semantic-analyze-calculate-bounds))
	 (prefix (car prefixandbounds))
	 (endsym (nth 1 prefixandbounds))
	 (bounds (nth 2 prefixandbounds))
	 (prefixclass (semantic-ctxt-current-class-list))
	 )
    (when prefix
      (require 'semantic-analyze)
      (semantic-analyze-context
       "Context-for-php"
       :buffer (current-buffer)
       :scope nil
       :scopetypes nil
       :localvariables nil
       :bounds bounds
       :prefix prefix
       :prefixtypes nil
       :prefixclass prefixclass)
      )
    ))

(defvar semantic-php-command-completion-list
 ;; (append (mapcar (lambda (a) (car a)) php-section-list)
;;	  php-environments
;;	  ;; Is there a better list somewhere?  Here are few
;	  ;; of the top of my head.
;;	  "anchor" "asis"
;;	  "bullet"
;;	  "code" "copyright"
;;	  "defun" "deffn" "defoption" "defvar" "dfn"
;;	  "emph" "end"
;;	  "ifinfo" "iftex" "inforef" "item" "itemx"
;;	  "kdb"
;;	  "node"
;;	  "ref"
;;	  "set" "setfilename" "settitle"
;;	  "value" "var"
;;	  "xref"
;;	  )
  "List of commands that we might bother completing.")

(define-mode-local-override semantic-analyze-possible-completions
  php-mode (context)
  "List smart completions at point.
Since php is not a programming language the default version is not
useful.  Insted, look at the current symbol.  If it is a command
do primitive php built ins.  If not, use ispell to lookup words
that start with that symbol."
  (let ((prefix (car (oref context :prefix)))
	)
    (cond ((member 'function (oref context :prefixclass))
	   ;; Do completion for php commands
	   (let* ((cmd (substring prefix 1))
		  (lst (all-completions
			cmd semantic-php-command-completion-list)))
	     (mapcar (lambda (f) (semantic-tag (concat "@" f) 'function))
		     lst))
	   )
	  ((member 'word (oref context :prefixclass))
	   ;; Do completion for words via ispell.
	   (require 'ispell)
	   (let ((word-list (lookup-words prefix)))
	     (mapcar (lambda (f) (semantic-tag f 'word)) word-list))
	   )
	  (t nil))
    ))

;;;###autoload
(defun semantic-default-php-setup ()
  "Set up a buffer for parsing of Php files."
  ;; This will use our parser.
  (semantic-install-function-overrides
   '((parse-region . semantic-php-parse-region)
     (parse-changes . semantic-php-parse-changes)))
  (setq semantic-parser-name "PHP"
        ;; Setup a dummy parser table to enable parsing!
        semantic--parse-table t
        imenu-create-index-function 'semantic-create-imenu-index
	semantic-command-separation-character "@"
	semantic-type-relation-separator-character '(":")
	semantic-symbol->name-assoc-list '((section . "Section")
					   (def . "Definition")
					   )
	semantic-imenu-expandable-tag-classes '(section)
	semantic-imenu-bucketize-file nil
	semantic-imenu-bucketize-type-members nil
	senator-step-at-start-end-tag-classes '(section)
	semantic-stickyfunc-sticky-classes '(section)
	)
  (local-set-key [(f9)] 'semantic-php-update-doc-from-php)
  )

;;;###autoload
(add-hook 'php-mode-hook 'semantic-default-php-setup)


;;; Special features of Php tag streams
;;
;; This section provides specialized access into php files.
;; Because php files often directly refer to functions and programs
;; it is useful to access the php file from the C code for document
;; maintainance.
(defun semantic-php-associated-files (&optional buffer)
  "Find php files associated with BUFFER."
  (save-excursion
    (if buffer (set-buffer buffer))
    (cond ((and (fboundp 'ede-documentation-files)
                ede-minor-mode (ede-current-project))
	   ;; When EDE is active, ask it.
	   (ede-documentation-files)
	   )
	  ((and (featurep 'semanticdb) (semanticdb-minor-mode-p))
	   ;; See what php files we have loaded in the database
	   (let ((tabs (semanticdb-get-database-tables
			semanticdb-current-database))
		 (r nil))
	     (while tabs
	       (if (eq (oref (car tabs) major-mode) 'php-mode)
		   (setq r (cons (oref (car tabs) file) r)))
	       (setq tabs (cdr tabs)))
	     r))
	  (t
	   (directory-files default-directory nil "\\.php$"))
	  )))

;; Turns out this might not be useful.
;; Delete later if that is true.
(defun semantic-php-find-documentation (name &optional type)
  "Find the function or variable NAME of TYPE in the php source.
NAME is a string representing some functional symbol.
TYPE is a string, such as \"variable\" or \"Command\" used to find
the correct definition in case NAME qualifies as several things.
When this function exists, POINT is at the definition.
If the doc was not found, an error is thrown.
Note: TYPE not yet implemented."
  (let ((f (semantic-php-associated-files))
	stream match)
    (while (and f (not match))
      (unless stream
	(with-current-buffer (find-file-noselect (car f))
	  (setq stream (semantic-fetch-tags))))
      (setq match (semantic-find-first-tag-by-name name stream))
      (when match
	(set-buffer (semantic-tag-buffer match))
	(goto-char (semantic-tag-start match)))
      (setq f (cdr f)))))

(defun semantic-php-update-doc-from-php (&optional tag)
  "Update the documentation in the php deffn class tag TAG.
The current buffer must be a php file containing TAG.
If TAG is nil, determine a tag based on the current position."
  (interactive)
  (unless (or (featurep 'semanticdb) (semanticdb-minor-mode-p))
    (error "Php updating only works when `semanticdb' is being used"))
  (semantic-fetch-tags)
  (unless tag
    (beginning-of-line)
    (setq tag (semantic-current-tag)))
  (unless (semantic-tag-of-class-p tag 'def)
    (error "Only deffns (or defun or defvar) can be updated"))
  (let* ((name (semantic-tag-name tag))
	 (tags (semanticdb-strip-find-results
		(semanticdb-with-match-any-mode
		  (semanticdb-brute-deep-find-tags-by-name name))
		t))
	 (docstring nil)
	 (docstringproto nil)
	 (docstringvar nil)
	 (doctag nil)
	 (doctagproto nil)
	 (doctagvar nil)
	 )
    (save-excursion
      (while (and tags (not docstring))
	(let ((sourcetag (car tags)))
	  ;; There could be more than one!  Come up with a better
	  ;; solution someday.
	  (when (semantic-tag-buffer sourcetag)
	    (set-buffer (semantic-tag-buffer sourcetag))
	    (unless (eq major-mode 'php-mode)
	    (cond ((semantic-tag-get-attribute sourcetag :prototype-flag)
		   ;; If we found a match with doc that is a prototype, then store
		   ;; that, but don't exit till we find the real deal.
		   (setq docstringproto (semantic-documentation-for-tag sourcetag)
			 doctagproto sourcetag))
		  ((eq (semantic-tag-class sourcetag) 'variable)
		   (setq docstringvar (semantic-documentation-for-tag sourcetag)
			 doctagvar sourcetag))
		  ((semantic-tag-get-attribute sourcetag :override-function-flag)
		   nil)
		  (t
		   (setq docstring (semantic-documentation-for-tag sourcetag))))
	    (setq doctag (if docstring sourcetag nil))))
	  (setq tags (cdr tags)))))
    ;; If we found a prototype of the function that has some doc, but not the
    ;; actual function, lets make due with that.
    (if (not docstring)
	(cond ((stringp docstringvar)
	       (setq docstring docstringvar
		     doctag doctagvar))
	      ((stringp docstringproto)
	       (setq docstring docstringproto
		     doctag doctagproto))))
    ;; Test for doc string
    (unless docstring
      (error "Could not find documentation for %s" (semantic-tag-name tag)))
    ;; If we have a string, do the replacement.
    (delete-region (semantic-tag-start tag)
		   (semantic-tag-end tag))
    ;; Use useful functions from the docaument library.
    (require 'document)
    (document-insert-php doctag (semantic-tag-buffer doctag))
    ))

(defun semantic-php-update-doc-from-source (&optional tag)
  "Update the documentation for the source TAG.
The current buffer must be a non-php source file containing TAG.
If TAG is nil, determine the tag based on the current position.
The current buffer must include TAG."
  (interactive)
  (when (eq major-mode 'php-mode)
    (error "Not a source file"))
  (semantic-fetch-tags)
  (unless tag
    (setq tag (semantic-current-tag)))
  (unless (semantic-documentation-for-tag tag)
    (error "Cannot find interesting documentation to use for %s"
	   (semantic-tag-name tag)))
  (let* ((name (semantic-tag-name tag))
	 (php (semantic-php-associated-files))
	 (doctag nil)
	 (docbuff nil))
    (while (and php (not doctag))
      (set-buffer (find-file-noselect (car php)))
      (setq doctag (car (semantic-deep-find-tags-by-name
			 name (semantic-fetch-tags)))
	    docbuff (if doctag (current-buffer) nil))
      (setq php (cdr php)))
    (unless doctag
      (error "Tag %s is not yet documented.  Use the `document' command"
             name))
    ;; Ok, we should have everything we need.  Do the deed.
    (if (get-buffer-window docbuff)
	(set-buffer docbuff)
      (switch-to-buffer docbuff))
    (goto-char (semantic-tag-start doctag))
    (delete-region (semantic-tag-start doctag)
		   (semantic-tag-end doctag))
    ;; Use useful functions from the document library.
    (require 'document)
    (document-insert-php tag (semantic-tag-buffer tag))
    ))

(defun semantic-php-update-doc (&optional tag)
  "Update the documentation for TAG.
If the current buffer is a php file, then find the source doc, and
update it.  If the current buffer is a source file, then get the
documentation for this item, find the existing doc in the associated
manual, and update that."
  (interactive)
  (cond ((eq major-mode 'php-mode)
	 (semantic-php-update-doc-from-php tag))
	(t
	 (semantic-php-update-doc-from-source tag))))

(defun semantic-php-goto-source (&optional tag)
  "Jump to the source for the definition in the php file TAG.
If TAG is nil, it is derived from the deffn under POINT."
  (interactive)
  (unless (or (featurep 'semanticdb) (semanticdb-minor-mode-p))
    (error "Php updating only works when `semanticdb' is being used"))
  (semantic-fetch-tags)
  (unless tag
    (beginning-of-line)
    (setq tag (semantic-current-tag)))
  (unless (semantic-tag-of-class-p tag 'def)
    (error "Only deffns (or defun or defvar) can be updated"))
  (let* ((name (semantic-tag-name tag))
	 (tags (semanticdb-strip-find-results
		(semanticdb-with-match-any-mode
		  (semanticdb-brute-deep-find-tags-by-name name nil t))
		))
	 (done nil)
	 )
    (save-excursion
      (while (and tags (not done))
	(set-buffer (semantic-tag-buffer (car tags)))
	(unless (eq major-mode 'php-mode)
	  (switch-to-buffer (semantic-tag-buffer (car tags)))
	  (goto-char (semantic-tag-start (car tags)))
	  (setq done t))
	(setq tags (cdr tags)))
      (if (not done)
	  (error "Could not find tag for %s" (semantic-tag-name tag)))
      )))

(provide 'semantic-php)

;;; semantic-php.el ends here
