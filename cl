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
      (princ "work out" out))))

