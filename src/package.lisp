(uiop:define-package #:aoc2021
  (:mix #:cl #:arrows #:alexandria #:cl-oju #:iterate
        #:str)
  (:import-from #:select #:select)
  (:import-from #:serapeum
                #:filter #:filter-map #:mapply #:op
                #:href #:href-default
                #:pop-assoc
                #:queue #:deq #:enq #:qappend
                #:lret #:lret*)
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
   #:day9-silver-parse
   #:day9-gold-parse
   ;; Day 10
   #:day10-silver
   #:day10-gold
   #:day10-silver-parse
   #:day10-gold-parse
   ;; Day 11
   #:day11-silver
   #:day11-gold
   #:day11-silver-parse
   #:day11-gold-parse
   ;; Day 12
   #:day12-silver
   #:day12-gold
   #:day12-silver-parse
   #:day12-gold-parse
   ;; Day 13
   #:day13-silver
   #:day13-gold
   #:day13-silver-parse
   ;; Day 14
   #:day14-silver
   #:day14-gold
   #:day14-silver-parse
   #:day14-gold-parse))
