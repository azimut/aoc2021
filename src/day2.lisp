(in-package #:aoc2021)

;; Lesson learned:
;; - Not use floats what should be INT

(defun day2-silver (text)
  (let ((v (arrows:->> text
                       (lines)
                       (mapcar #'reading-to-pair)
                       (reduce-readings))))
    (* (aref v 0) (aref v 1))))

(defun reduce-readings (readings)
  (reduce (lambda (v1 v2)
            (vector (+ (aref v1 0) (aref v2 0))
                    (+ (aref v1 1) (aref v2 1))))
          readings :initial-value (vector 0 0)))

(defun reading-to-pair (reading)
  (destructuring-bind (dir ammount) (words reading)
    (let ((x (parse-integer ammount)))
      (alexandria:eswitch (dir :test #'string=)
        ("forward" (vector x    0))
        ("down"    (vector 0    x))
        ("up"      (vector 0 (- x)))))))

(defun day2-gold (text)
  (let ((v (arrows:->> text
                       (lines)
                       (mapcar #'reading-to-thrice)
                       (reduce-readings-thrice))))
    (* (aref v 0) (aref v 1))))

(defun reduce-readings-thrice (readings)
  (reduce (lambda (acc new)
            (if (> (aref new 0) 0)
                (vector (+ (aref acc 0) (aref new 0))
                        (+ (aref acc 1) (* (aref acc 2) (aref new 0)))
                        (+ (aref acc 2) (aref new 2)))
                (vector (+ (aref acc 0) (aref new 0))
                        (+ (aref acc 1) (aref new 1))
                        (+ (aref acc 2) (aref new 2)))))
          readings
          :initial-value (vector 0 0 0)))

(defun reading-to-thrice (reading)
  (destructuring-bind (dir ammount) (words reading)
    (let ((x (parse-integer ammount)))
      (alexandria:eswitch (dir :test #'string=)
        ("forward" (vector x 0    0))
        ("down"    (vector 0 0    x))
        ("up"      (vector 0 0 (- x)))))))
