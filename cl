#! /usr/bin/env clisp
(defun get-date ()
 (multiple-value-bind (_ _ _ day month year) (get-decoded-time)
   (format nil "~A-~A-~A" year month day)))

(defun query-text ()
  (format nil "~A ~A" (get-date) "work out"))

(defun task-is-pending? ()
  (eql
    1
    (run-program
      "grep"
      :arguments (list (query-text) "/Users/rich/.cl/data")
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
      (princ (format nil "~A~%" (query-text)) out))))
