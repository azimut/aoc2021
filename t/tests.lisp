(in-package #:aoc2021-test)

(define-test day1
  (is = 7 (day1-silver (slurp (test-file 1))))
  (is = 5 (day1-gold   (slurp (test-file 1)))))

(define-test day2
  (is = 150 (day2-silver (slurp (test-file 2))))
  (is = 900 (day2-gold   (slurp (test-file 2)))))

(define-test day3
  (is =  22 (gamma (str:lines (slurp (test-file 3)))))
  (is =   9 (epsilon (str:lines (slurp (test-file 3)))))
  (is = 198 (day3-silver (slurp (test-file 3))))
  (is = 230 (day3-gold (slurp (test-file 3))))
  (is =  23 (arrows:->> (test-file 3)
                        (slurp)
                        (str:lines)
                        (o2)))
  (is =  10 (arrows:->> (test-file 3)
                        (slurp)
                        (str:lines)
                        (co2))))

(define-test day4
  (is = 4512 (day4-silver (slurp (test-file 4))))
  (is = 1924 (day4-gold   (slurp (test-file 4)))))

(define-test day5
  (is = 5  (day5-silver (slurp (test-file 5))))
  (is = 12 (day5-gold   (slurp (test-file 5)))))

(define-test day6
  (is =          26 (day6-silver 18 (slurp (test-file 6))))
  (is =        5934 (day6-silver 80 (slurp (test-file 6))))
  (is = 26984457539 (day6-gold  256 (slurp (test-file 6)))))

(define-test day7
  (is = 37 (day7-silver (slurp (test-file 7))))
  (is = 168 (day7-gold   (slurp (test-file 7)))))

;; (define-test day8
;;   (let ((input1 (day8-silver-parse (test-file 8)))
;;         (input2 (day8-gold-parse (test-file 8))))
;;     (is = 26 (day8-silver input1))
;;     (is = 1  (day8-gold   input2))))

(define-test day9
  (let* ((input1 (day9-silver-parse (test-file 9)))
         (input2 (day9-gold-parse   (test-file 9)))
         (array  (first  input2))
         (mask   (second input2)))
    (is = 15   (day9-silver input1))
    (is = 1134 (day9-gold array mask))))

