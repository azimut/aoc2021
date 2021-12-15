(in-package #:aoc2021)

(defun day13-gold (matrix folds)
  (if folds
      (destructuring-bind (axis by) (pop folds)
        (day13-gold
         (ecase axis
           (y (fold-up   by matrix))
           (x (fold-left by matrix)))
         folds))
      (values (reduce
               #'+
               (make-array (array-total-size matrix)
                           :displaced-to matrix))
              (array-dimensions matrix)
              matrix)))
