#! /usr/bin/env clisp

(defun task-is-pending? ()
  (eql
    1
    (run-program
      "grep"
      :arguments '("work out" "/Users/rich/.cl/data")
      :output nil
      )))

(defun query ()
  (format t "did you work out today?(yes no)~%> ")
  (let ((answer (read)))
        (cond
          ((eql 'yes answer) t)
          ((eql 'no answer) nil)
          (t (query))
        )))

(if (task-is-pending?)
  (if (query)
    (with-open-file (out "/Users/rich/.cl/data" :direction :output :if-exists :append )
      (princ "work out" out)))
  (format t ""))


;(let
;  ((prompt '>)
;   (answers '(yes no))
;   (question-prefix "did you")
;   (pretty-time "today")
;   (item-path "~/.cl/questions")
;   )
;
;  (defun get-items (item-path)
;    (setf items nil)
;    (with-open-file (str item-path :direction :input)
;      (do ((line (read-line str nil 'eof)
;                  (read-line str nil 'eof)))
;          ((eql line 'eof))
;          (setf items (append items (list line)))
;          ))
;    items)
;
;  (defun snatch (options)
;    (format t "~%~A " prompt)
;    (setf answer (read))
;    (if (find answer options)
;      answer
;      (snatch options)))
;
;  (defun query (q)
;    (format t "~A ~A ~A? ~A" question-prefix q pretty-time answers)
;    (snatch answers)
;  )
;
;  (defun write-completion (item)
;    (with-open-file (str item-path :direction :output)
;  )
;
;  (mapcar
;    #'(lambda (item)
;     (if (eql (query item) 'yes)
;       (write-completion item))
;    (get-items item-path))
;)
