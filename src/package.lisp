(uiop:define-package #:aoc2021
  (:use #:cl #:arrows)
  (:export
   ;; Day 1
   #:count-increases
   #:sum-group-by-3
   #:get-integer-input-for-day
   ;; Day 2
   #:slurp
   #:test-file
   #:input-file
   #:forward #:down #:up
   #:day2-silver
   #:day2-gold))
