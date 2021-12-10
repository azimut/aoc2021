(in-package #:aoc2021)

(defun day10-silver-parse (file)
  (->> file (slurp) (lines)))

(defun day10-silver (lines)
  (->> lines
       (filter-map #'first-illegal-char)
       (mapcar #'score-char)
       (reduce #'+)))

(defun first-illegal-char (line)
  (loop :for char :across line
        :with openings = ()
        :if (opening-p char)
          :do (push char openings)
        :else
          :do (when (not (eql char (closing-for (pop openings))))
                (return char))))

(defun closing-for (char)
  (ecase char
    (#\( #\))
    (#\[ #\])
    (#\{ #\})
    (#\< #\>)))

(defun opening-p (char)
  (member char '(#\( #\[ #\{ #\<)))

(defun score-char (char)
  (ecase char
    (#\)     3)
    (#\]    57)
    (#\}  1197)
    (#\> 25137)))
