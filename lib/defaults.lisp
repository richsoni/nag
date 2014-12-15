(setf nag-count 3)

(defun choose-task-subset(src dst)
  (let ((task (nth (random (length src)) src)))
    (if (find task dst)
      (choose-task-subset src dst)
      (append dst (list task)))))
