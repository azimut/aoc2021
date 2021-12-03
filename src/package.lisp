(uiop:define-package #:aoc2021
  (:use #:cl #:arrows)
  (:export
   ;; util.lisp
   #:slurp
   #:test-file
   #:input-file
   ;; Day 1
   #:day1-silver
   #:day1-gold
   ;; Day 2
   #:forward #:down #:up
   #:day2-silver
   #:day2-gold))
