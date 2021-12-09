(asdf:defsystem #:aoc2021
  :description "Describe aoc2021 here"
  :author "azimut <azimut.github@protonmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :pathname "src"
  :depends-on (#:alexandria
               #:arrows
               #:str
               #:cl-oju
               #:serapeum
               #:iterate)
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
               (:file "day9gold"))
  :in-order-to ((asdf:test-op (asdf:test-op :aoc2021/test))))

(asdf:defsystem #:aoc2021/test
  :depends-on (#:aoc2021 #:parachute)
  :pathname "t"
  :components ((:file "package")
               (:file "tests"))
  :perform (asdf:test-op (op c) (uiop:symbol-call :parachute :test :aoc2021-test)))
