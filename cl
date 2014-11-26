#! /usr/bin/env clisp

(defun get-date ()
 (multiple-value-bind (_ _ _ day month year) (get-decoded-time)
   (format nil "~A-~A-~A" year month day)))

(defun query-text (task)
  (format nil "~A ~A" (get-date) task))

(defun task-is-pending? (task)
  (eql
    1
    (run-program
      "grep"
      :arguments (list (query-text task) "/Users/rich/.cl/data")
      :output nil
      )))

(defun query (task)
  (format t "did you ~A today?(yes no)~%> " task)
  (let ((answer (read)))
        (cond
          ((eql 'yes answer) t)
          ((eql 'no answer) nil)
          (t (query task))
        )))


(defun get-tasks ()
  (setf tasks NIL)
  (with-open-file (in "/Users/rich/.cl/questions" :direction :input)
    (do ((line (read-line in nil 'eof)
               (read-line in nil 'eof)))
      ((eql line 'eof))
      (setf tasks (append tasks (list line)))))
  tasks)

(if (task-is-pending? (car (get-tasks)))
  (if (query (car (get-tasks)))
    (with-open-file (out "/Users/rich/.cl/data" :direction :output :if-exists :append )
      (princ (format nil "~A~%" (query-text (car (get-tasks)))) out))))

