(defun home-path ()
  (directory-namestring
    (merge-pathnames 
     (make-pathname
      :directory '(:relative ""))
     (user-homedir-pathname))))

(load (format nil "~Anag/lib/each-file-line.lisp" (home-path)))

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
        :arguments (list (query-text task) (format nil "~A.nag/data" (home-path)))
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
      (with-open-file (out (format nil "~A.nag/data" (home-path)) :direction :output :if-exists :append )
        (princ (format nil "~A~%" (query-text task)) out))))
  )