(asdf:defsystem #:aoc2021
  :description "Describe aoc2021 here"
  :author "azimut <azimut.github@protonmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:alexandria
               #:array-operations
               #:arrows
               #:bitio
               #:bit-smasher
               #:cl-oju
               #:iterate
               #:select
               #:serapeum
               #:str)
  :components ((:file "package")
               (:file "utils")
               (:file "day1")
               (:file "day2")
               (:file "day3")
               (:file "day4")
               (:file "day5")
               (:file "day6")
               (:file "day7")
               ;;(:file "day8")
               (:file "day9silver")
               (:file "day9gold")
               (:file "day10silver")
               (:file "day10gold")
               (:file "day11silver")
               (:file "day11gold")
               (:file "day12silver")
               (:file "day12gold")
               (:file "day20"))
  :in-order-to ((asdf:test-op (asdf:test-op :aoc2021/test))))

(asdf:defsystem #:aoc2021/test
  :depends-on (#:aoc2021 #:parachute)
  :pathname "t"
  :components ((:file "package")
               (:file "tests"))
  :perform (asdf:test-op (op c) (uiop:symbol-call :parachute :test :aoc2021-test)))
