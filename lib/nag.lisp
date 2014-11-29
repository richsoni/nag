(load "/Users/rich/nag/lib/each-file-line.lisp")

(defun get-date ()
 (multiple-value-bind (_ _ _ day month year) (get-decoded-time)
   (format nil "~A-~A-~A" year month day)))

(defun query-text (task)
  (format nil "~A ~A" (get-date) task))

(defun flagp (mode)
  (find (format nil "--~A" mode) *args* :test #'equal))

(defun task-is-pending? (task)
  (if (flagp "test")
    t
    (eql
      1
      (run-program
        "grep"
        :arguments (list (query-text task) "/Users/rich/.nag/data")
        :output nil
        ))))

(defun query (task)
  (format t "did you ~A today?(yes no)~%> " task)
  (catch 'query
    (let ((answer (read t nil 'exit)))
          (cond
            ((eql 'yes answer) t)
            ((eql 'no answer) nil)
            (t
              (if (not (and (flagp "test") (eql 'exit answer)))
                (progn
                   (format t "~%")
                   (query task))))))))


(defun read-lines (path)
  (setf lines NIL)
  (each-file-line path
    #'(lambda (line)
    (setf lines (append lines (list line)))))
  lines)

(defun process-task (task)
  (if (task-is-pending? task)
    (if (query task)
      (with-open-file (out "/Users/rich/.nag/data" :direction :output :if-exists :append )
        (princ (format nil "~A~%" (query-text task)) out))))
  )
