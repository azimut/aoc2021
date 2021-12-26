(in-package #:aoc2021)

(defun day9-silver (array)
  (->> (mins array)
       (mapcar #'1+)
       (reduce #'+)))

(defun mins (array)
  (iterate outer (for x below (array-dimension array 0))
    (iterate (for y below (array-dimension array 1))
      (when (< (aref array x y)
               (apply #'min (adjacent array x y)))
        (in outer (collect (aref array x y)))))))

(defun adjacent (array x y)
  (iterate outer (for dx in '(-1 0 1))
    (iterate (for dy in '(-1 0 1))
      (when (and (<= 0 (+ x dx) (1- (array-dimension array 0)))
                 (<= 0 (+ y dy) (1- (array-dimension array 1)))
                 (not (= (abs dx) (abs dy))))
        (in outer (collect (aref array (+ x dx) (+ y dy))))))))

(defun list-to-array (list)
  (let ((h (length list))
        (w (length (first list))))
    (make-array (list h w) :initial-contents list)))

(defun day9-silver-parse (file)
  (->> file
       (slurp)
       (lines)
       (mapcar
        (serapeum:op
          (map 'list (compose #'parse-integer #'string)
               _)))
       (list-to-array)))
