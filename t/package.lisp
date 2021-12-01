(uiop:define-package #:aoc2021-test
  (:use #:cl #:aoc2021 #:parachute))

(in-package #:aoc2021-test)

(define-test day1
  (is = 7 (n-increases '(199 200 208 210 200 207 240 269 260 263))))
