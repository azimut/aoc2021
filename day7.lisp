(in-package #:aoc2021)

;; Only moves horizontal
;; INPUT: horizontal positions
;; GOAL: align them with min movement
;; minimize the sum of movement
;; 1880 = (apply #'max (text-to-crabs (slurp (input-file 7))))
;; 1000 = (length (text-to-crabs (slurp (input-file 7))))
;; 634  = (length (cl-oju:frequencies (text-to-crabs (slurp (input-file 7)))))
;; 1880 * 1000

(defun text-to-crabs (text)
  (->> text (split ",") (mapcar #'parse-integer)))

(defun day7-silver (text)
  (let* ((crabs   (text-to-crabs text))
         (max-pos (apply #'max crabs))
         (min-pos (apply #'min crabs))
         (fuels   (make-array (- max-pos min-pos))))
    (loop :for pos :from min-pos :below max-pos
          :do (loop :for crab :in crabs
                    :do (incf (aref fuels pos) (abs (- crab pos)))))
    (reduce #'min fuels)))

;; ? https://en.wikipedia.org/wiki/Triangular_number
;; https://mathworld.wolfram.com/ArithmeticSeries.html
(declaim (inline mvf))
(defun mvf (from to)
  (declare (optimize (speed 3)) (fixnum from to))
  (let ((n (abs (- from to))))
    (declare (fixnum n))
    (/ (* n (+ n 1)) 2)))

(defun day7-gold (text)
  (declare (optimize (speed 3)))
  (let* ((crabs   (text-to-crabs text))
         (max-pos (apply #'max crabs))
         (min-pos (apply #'min crabs))
         (fuels   (make-array (- max-pos min-pos) :element-type 'fixnum)))
    (loop :for pos :of-type fixnum :from min-pos :below max-pos
          :do (loop :for crab :in crabs
                    :do (incf (aref fuels pos)
                              (mvf crab pos))))
    (reduce #'min fuels)))
