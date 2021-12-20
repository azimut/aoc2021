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

(define-test day10
  (let ((input1 (day10-silver-parse (test-file 10))))
    (is = 26397  (day10-silver input1))
    (is = 288957 (day10-gold   input1))))

(define-test day11
  (let ((input1 (day9-silver-parse (test-file 11))))
    (is = 1656 (day11-silver input1 100))
    (is =  195 (day11-gold   input1 999))))

(define-test day12
  (let ((i1 (day12-silver-parse (asdf:system-relative-pathname :aoc2021 "static/day/12/test1")))
        (i2 (day12-silver-parse (asdf:system-relative-pathname :aoc2021 "static/day/12/test2")))
        (i3 (day12-silver-parse (asdf:system-relative-pathname :aoc2021 "static/day/12/test3"))))
    (is =   10 (day12-silver i1))
    (is =   19 (day12-silver i2))
    (is =  226 (day12-silver i3))
    (is =   36 (day12-gold   i1))
    (is =  103 (day12-gold   i2))
    (is = 3509 (day12-gold   i3))))

;; FIXME: mvlet
(define-test day13
  (let ((input1 (day13-silver-parse (test-file 13))))
    (is = 17 (day13-silver input1))))

(define-test day14
  (let ((i1 (day14-silver-parse (test-file 14)))
        (i2 (day14-gold-parse   (test-file 14))))
    (is = 1588 (day14-silver i1))
    ;;(is = 0 (day14-gold   i2))
    ))

(define-test day15
  (let ((i1 (day15-silver-parse (test-file 15)))
        (i2 (day15-gold-parse   (test-file 15))))
    (is =  40 (day15-silver i1))
    (is = 315 (day15-gold   i2))))

(define-test day16
  (is = 16 (day16-silver (day16-silver-parse "8A004A801A8002F478")))
  (is = 12 (day16-silver (day16-silver-parse "620080001611562C8802118E34")))
  (is = 23 (day16-silver (day16-silver-parse "C0015000016115A2E0802F182340")))
  (is = 31 (day16-silver (day16-silver-parse "A0016C880162017C3686B18A3D4780")))
  (is =  3 (day16-gold (day16-silver-parse "C200B40A82")))
  (is = 54 (day16-gold (day16-silver-parse "04005AC33890")))
  (is =  7 (day16-gold (day16-silver-parse "880086C3E88112")))
  (is =  9 (day16-gold (day16-silver-parse "CE00C43D881120")))
  (is =  1 (day16-gold (day16-silver-parse "D8005AC2A8F0")))
  (is =  0 (day16-gold (day16-silver-parse "F600BC2D8F")))
  (is =  0 (day16-gold (day16-silver-parse "9C005AC2F8F0")))
  (is =  1 (day16-gold (day16-silver-parse "9C0141080250320F1802104A08"))))
