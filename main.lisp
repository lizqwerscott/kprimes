(defun create-lists (start end &optional (space-s 1) (group (list start))) 
  (if (> (+ space-s (car (last group))) end) group 
      (create-lists start end space-s (append group (list (+ space-s (car (last group))))))))

(defun split-list (start end n-list) 
  (let ((result-list)) 
    (dolist (i n-list) 
      (if (and (>= i start) (<= i end)) 
          (setf result-list (append result-list (list i))))) 
    result-list))

(defun slove (start end k &optional (nk 1) (last-list (create-lists 2 end))) 
  (format t "~A----~%" last-list)
  (let ((now-list) (next-list)) 
    (do ((i-list last-list (cdr i-list))) 
        ((or (not i-list) (> (car i-list) (* nk (expt (car (last last-list)) 1/2)))) 
         (setf now-list (append now-list i-list)) 
         (setf next-list (sort next-list #'<))) 
        (format t "i-list:~A~%" i-list)
        (setf now-list (append now-list (list (car i-list))))
        (dolist (j (cdr i-list)) 
          (format t "j:~A~%" j)
          (if (= 0 (rem j (car i-list))) 
              (progn (setf i-list (remove j i-list)) 
                     (setf next-list (append next-list (list j))))))) 
    (format t "now-list:~A~%" now-list)
    (format t "next-list:~A~%" next-list)
    (if (= nk k) (split-list start end now-list) 
        (slove start end k (+ nk 1) next-list))))

