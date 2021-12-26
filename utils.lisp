(in-package #:aoc2021)

(defun zip (&rest lists)
  (apply #'mapcar #'list lists))

(defun mapcat (function &rest lists)
  (apply #'alexandria:mappend function lists))

(defun mapv (function first-sequence &rest more-sequences)
  (apply #'map 'vector function first-sequence more-sequences))

(defun test-file  (day)
  (asdf:system-relative-pathname
   :aoc2021 (format nil "static/day/~d/test" day)))

(defun input-file (day)
  (asdf:system-relative-pathname
   :aoc2021 (format nil "static/day/~d/input" day)))
