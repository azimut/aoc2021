(in-package #:aoc2021)

(defun day10-gold-parse (file))

(defun day10-gold (line)
  (-<>> line
        (remove-if #'corrupted-p)
        (mapcar #'completed-by)
        (mapcar #'score-completion)
        (sort <> #'>)
        (middle)))

(defun middle (list)
  (nth (floor (/ (length list) 2)) list))

(defun completed-by (line)
  (loop :for char :across line
        :with opening-chars = ()
        :if (opening-p char)
          :do (push char opening-chars)
        :else
          :do (pop opening-chars)
        :finally (return (map 'string #'identity (mapcar #'closing-for opening-chars)))))

(define-modify-macro mulf (x) *)
(defun score-completion (completion-string)
  (flet ((score-char (c)
           (ecase c
             (#\) 1)
             (#\] 2)
             (#\} 3)
             (#\> 4))))
    (loop :for char :across completion-string
          :with score = 0
          :do (mulf score 5)
              (incf score (score-char char))
          :finally (return score))))

(defun corrupted-p (line)
  (first-illegal-char line))
