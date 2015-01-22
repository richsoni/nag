(defun each-file-line (path fn)
  (with-open-file (in path :direction :input)
    (do ((line (read-line in nil 'eof)
               (read-line in nil 'eof)))
      ((eql line 'eof))
      (funcall fn line))))

