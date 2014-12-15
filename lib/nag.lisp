(defun home-path ()
  (directory-namestring
    (merge-pathnames 
     (make-pathname
      :directory '(:relative ""))
     (user-homedir-pathname))))

(load (format nil "~Anag/lib/each-file-line.lisp" (home-path)))
(load (format nil "~Anag/lib/defaults.lisp" (home-path))) ;./defaults.lisp

(defun get-date ()
 (multiple-value-bind (_ _ _ day month year) (get-decoded-time)
   (format nil "~A-~A-~A" year month day)))

(defun query-text (task)
  (format nil "~A ~A" (get-date) task))

(defun flagp (elem)
  (if (< 2 (length elem))
    (equal "--" (subseq elem 0 2))))

(defun has-flag (mode)
  (find (format nil "--~A" mode) *args* :test #'equal))

(defun task-is-pending? (task)
  (if (has-flag "test")
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
              (if (not (and (has-flag "test") (eql 'exit answer)))
                (progn
                   (format t "~%")
                   (query task))))))))

(defun read-lines (path)
  (setf lines NIL)
  (each-file-line path
    #'(lambda (line)
    (setf lines (append lines (list line)))))
  lines)

(let ((_pending-tasks NIL))
  (defun pending-tasks ()
    (if (not (null _pending-tasks))
      _pending-tasks
      (setf
        _pending-tasks
        (reduce
          #'(lambda (memo task)
              (if (task-is-pending? task)
                (append memo (list task))
                memo))
          (read-lines (format nil "~A.nag/questions" (home-path)))
          :initial-value NIL)))))

(defun nag-count-len()
  (let ((max-len (length (pending-tasks))))
    (if (or (null nag-count) (> nag-count max-len))
      max-len
      nag-count)))

(let ((_nag-count (nag-count-len)))
  (defun get-tasks (&optional (tasks '()))
    (case _nag-count
      ((eql nil)
       (pending-tasks))
      (0
       (setf _nag-count (nag-count-len))
       tasks)
      (t
        (decf _nag-count)
        (get-tasks (choose-task-subset (pending-tasks) tasks))))))

(defun process-task (task)
  (if (task-is-pending? task)
    (if (query task)
      (with-open-file (out (format nil "~A.nag/data" (home-path)) :direction :output :if-exists :append )
        (princ (format nil "~A~%" (query-text task)) out)))))
