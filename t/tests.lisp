(in-package #:aoc2021-test)

(define-test day1
  (is = 7
      (count-increases '(199 200 208 210 200 207 240 269 260 263)))
  (is = 1759
      (count-increases (get-integer-input-for-day 1)))
  (is equal '(607 618 618 617 647 716 769 792)
      (sum-group-by-3
       '(199 200 208 210 200 207 240 269 260 263)))
  (is = 5
      (count-increases
       (sum-group-by-3
        '(199 200 208 210 200 207 240 269 260 263)))))

(defvar *day2* "forward 5
down 5
forward 8
up 3
down 8
forward 2")

(define-test day2
  (is = 150
      (day2-silver *day2*))
  (is = 900
      (day2-gold *day2*)))
