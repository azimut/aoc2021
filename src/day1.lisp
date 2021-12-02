(in-package #:aoc2021)

(defun get-integer-input-for-day (day)
  (let ((day-path (format nil "static/day/~d/input" day)))
    (arrows:->> (asdf:system-relative-pathname :aoc2021 day-path)
                (uiop:read-file-lines)
                (mapcar #'parse-integer))))

(defun count-increases (readings)
  (loop :for (x y) :on readings
        :count (and x y (> y x))))

(defun sum-group-by-3 (readings)
  (loop :for (x y z) :on readings
        :while (and x y z)
        :collect (+ x y z)))
