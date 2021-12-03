(in-package #:aoc2021-test)

(define-test day1
  (is = 7 (day1-silver (slurp (test-file 1))))
  (is = 5 (day1-gold   (slurp (test-file 1)))))

(define-test day2
  (is = 150 (day2-silver (slurp (test-file 2))))
  (is = 900 (day2-gold   (slurp (test-file 2)))))

(define-test day3
  (is = 22 (gamma (mapcar #'parse-binary
                          (str:lines (slurp (test-file 3))))))
  (is = 9 (epsilon (mapcar #'parse-binary
                           (str:lines (slurp (test-file 3))))))
  (is = 198 (day3-silver (slurp (test-file 3))))
  ;; (is = 1 (day3-gold   (slurp (test-file 3))))
  )
