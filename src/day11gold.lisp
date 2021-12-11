(in-package #:aoc2021)

(defun day11-gold (array days)
  (let ((total-size (array-total-size array)))
    (values
     (1+ (iterate (repeat days)
           (while (/= total-size (count-flashes-next-day array)))
           (counting t)))
     array)))
