(in-package #:aoc2021)

(defun list-to-array (list)
  (let ((h (length list))
        (w (length (first list))))
    (make-array (list h w) :initial-contents list)))

(defun adjacent (array x y)
  (loop for dx in '(-1 0 1)
        appending
        (loop for dy in '(-1 0 1)
              when (and (<= 0 (+ x dx) (1- (array-dimension array 0)))
                        (<= 0 (+ y dy) (1- (array-dimension array 1)))
                        (not (= (abs dx) (abs dy))))
                collecting
                (aref array (+ x dx) (+ y dy)))))

(defun day9-silver-parse (file)
  (->> file
       (slurp)
       (lines)
       (mapcar
        (serapeum:op
          (map 'list (compose #'parse-integer #'string )
               _)))
       (list-to-array)))

(defun day9-silver (array)
  (let ((mins ()))
    (dotimes (x (array-dimension array 0))
      (dotimes (y (array-dimension array 1))
        (when (< (aref array x y)
                 (apply #'min (adjacent array x y)))
          (push (aref array x y) mins))))
    (print mins)
    (reduce #'+ (mapcar #'1+ mins))))

(defun day9-gold-parse (file))
(defun day9-gold () 0)
