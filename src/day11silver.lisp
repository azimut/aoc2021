(in-package #:aoc2021)

(defun day11-silver (array days)
  (values
   (iterate (repeat days)
     (summing (count-flashes-next-day array)))
   array))

(defun count-flashes-next-day (array)
  (incf-slot-and-adjacents array)
  (count-and-reset-flashes array))

(defun incf-slot-and-adjacents (array)
  (iterate (for x below (array-dimension array 0))
    (iterate (for y below (array-dimension array 1))
      (when (= 10 (incf (aref array x y)))
        (incf-adjacent array x y)))))

(defun incf-adjacent (array fromx fromy)
  (iterate (for x from (max 0 (1- fromx)) to (min (1+ fromx) (1- (array-dimension array 0))))
    (iterate (for y from (max 0 (1- fromy)) to (min (1+ fromy) (1- (array-dimension array 1))))
      (when (and (= 10 (incf (aref array x y))) (not (and (= x fromx) (= y fromy))))
        (incf-adjacent array x y)))))

(defun count-and-reset-flashes (array)
  (iterate (for i below (array-total-size array))
    (when (< 9 (row-major-aref array i))
      (counting (setf (row-major-aref array i) 0)))))
