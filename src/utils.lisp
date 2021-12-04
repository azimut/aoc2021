(in-package #:aoc2021)

(defun test-file  (day)
  (asdf:system-relative-pathname
   :aoc2021 (format nil "static/day/~d/test" day)))

(defun input-file (day)
  (asdf:system-relative-pathname
   :aoc2021 (format nil "static/day/~d/input" day)))
