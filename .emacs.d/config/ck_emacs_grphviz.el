(load "graphviz-dot-mode.el" nil t t)

(add-hook 'find-file-hook (lambda()
                            (if (string= "dot" (file-name-extension
                                                buffer-file-name))
                                (progn
                                  (message "Enabling Setings for dot-mode")
                                  (setq fill-column 1000)
                                  (base-auto-pair)
                                  (local-set-key (kbd "<C-f6>") 'compile)
                                  )
                              )))


;; Function used to add fields of struct into a dot file (for Graphviz).
(defconst yyc/dot-head "subgraph cluster_%s {
	node [shape=record fontsize=12 fontname=Courier style=filled];
	color = lightgray;
	style=filled;
	label = \"Struct %s\";
	edge[color=\"#2e3436\"];"
  "Header part of dot file.")
(defconst yyc/dot-tail "
}"
  "Tail part of dot")
(defconst yyc/dot-node-head
  "
		node_%s[shape=record label=\"<f0>*** STRUCT %s ***|\\"
  "Format of node.")
(defconst yyc/dot-node-tail "
\"];"
  "Format of node.")
(defconst r_attr_str "[ \t]+\\(.*+\\)[ \t]+\\(.*\\)?;"
  "Regular expression for matching struct fields.")
(defconst r_name "\\_<\\(typedef[ \t]+\\)?struct[ \t]+\\(.*\\)?[ \t]*{"
  "Regular expression for mating struct name")
(defconst attr_str "
<f%d>%s %s\\l|\\" "nil")
(defun yyc/datastruct-to-dot (start end)
  "generate c++ function definition and insert it into `buffer'"
  (interactive "rp")
  (setq var-defination (buffer-substring-no-properties start end))
  (let* ((tmp_str "")
		 (var-name "")
		 (var-type "")
		 (counter 0)
		 (struct-name "")
		 (header-str "")
		 )
	(defun iter (pos)
	  (setq counter (+ counter 1))
	  (message (format "Counter: %d, pos: %d"
					   counter pos))
	  (if (string-match r_name var-defination pos)
		  (progn
			(message "A")
			(setq struct-name
				  (match-string 2 var-defination))
			(setq header-str
				  (format yyc/dot-head struct-name struct-name))
			(setq tmp_str
				  (format yyc/dot-node-head struct-name struct-name))
			(iter (match-end 0)))
		(if (string-match r_attr_str var-defination pos)
			(progn
			  (message "B")
			  (setq var-type
					(match-string 1 var-defination))
			  (setq var-name
					(match-string 2 var-defination))
			  (setq tmp_str
					(concat tmp_str
							(format attr_str counter var-type var-name)))
			  (iter (match-end 0)))
		  nil)))
	(save-excursion
	  (iter 0)
	  (set-buffer (get-buffer-create "tmp.dot"))
	  (graphviz-dot-mode)
	  (setq pos (point-max))
	  (insert  header-str tmp_str )
	  (goto-char (point-max))
	  (delete-char -1)
	  (insert "<f999>\\"yyc/dot-node-tail yyc/dot-tail)
	  )
	(if (one-window-p)
		(split-window-vertically))
	(switch-to-buffer-other-window "tmp.dot")
	(goto-char (point-min))
	)
  (message "Finished, please see *tmp.dot* buffer.")
  )


