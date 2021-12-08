(in-package #:aoc2021)

(defun day8-parse (file)
  (->> file (slurp) (split ",") (mapcar #'parse-integer)))

(defun day8-silver (input)
  0)

(defun day8-gold (input)
  0)
