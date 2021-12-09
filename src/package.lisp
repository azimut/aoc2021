(uiop:define-package #:aoc2021
  (:mix #:cl #:arrows #:alexandria #:cl-oju #:str
        #:iterate)
  (:import-from #:serapeum #:filter #:mapply)
  (:export
   ;; util.lisp
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
   #:day3-gold
   ;; Day 4
   #:day4-silver
   #:day4-gold
   ;; Day 5
   #:day5-silver
   #:day5-gold
   ;; Day 6
   #:day6-silver
   #:day6-gold
   ;; Day 7
   #:day7-silver
   #:day7-gold
   ;; Day 8
   #:day8-silver
   #:day8-gold
   #:day8-silver-parse
   #:day8-gold-parse
   ;; Day 9
   #:day9-silver
   #:day9-gold
   #:day9-parse))
