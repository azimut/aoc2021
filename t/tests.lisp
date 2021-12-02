(in-package #:aoc2021-test)

(define-test day1
  (is = 7
      (count-increases '(199 200 208 210 200 207 240 269 260 263)))
  (is = 1759
      (count-increases '(199 200 208 210 200 207 240 269 260 263)))
  (is equal '(607 618 618 617 647 716 769 792)
      (sum-group-by-3
       '(199 200 208 210 200 207 240 269 260 263)))
  (is = 5
      (count-increases
       (sum-group-by-3
        '(199 200 208 210 200 207 240 269 260 263)))))

(define-test day2
  (is = 150 (day2-silver (slurp (test-file 2))))
  (is = 900 (day2-gold   (slurp (test-file 2)))))
