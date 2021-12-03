(uiop:define-package #:aoc2021
  (:mix #:cl #:arrows #:alexandria #:str)
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
   #:day2-gold
   ;; Day 3
   #:gamma
   #:epsilon
   #:day3-silver
   #:o2
   #:co2
   #:day3-gold))
