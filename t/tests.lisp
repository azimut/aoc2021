(in-package #:aoc2021-test)

(define-test day1
  (is = 7
      (n-increases '(199 200 208 210 200 207 240 269 260 263)))
  (is = 1759
      (n-increases (get-integer-input-for-day 1)))
  (is equal '(607 618 618 617 647 716 769 792)
      (sum-group-by-3
       '(199 200 208 210 200 207 240 269 260 263)))
  (is = 5
      (n-increases
       (sum-group-by-3
        '(199 200 208 210 200 207 240 269 260 263)))))
