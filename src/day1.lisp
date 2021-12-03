(in-package #:aoc2021)

(defun day1-silver (text)
  (->> (lines text)
       (mapcar #'parse-integer)
       (count-increases)))

(defun day1-gold (text)
  (->> (lines text)
       (mapcar #'parse-integer)
       (sum-group-by-3)
       (count-increases)))

(defun count-increases (readings)
  (loop :for (x y) :on readings
        :count (and x y (> y x))))

(defun sum-group-by-3 (readings)
  (loop :for (x y z) :on readings
        :while (and x y z)
        :collect (+ x y z)))
