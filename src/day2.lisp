(in-package #:aoc2021)

(defun get-string-for-day (day)
  (let ((day-path (format nil "static/day/~d/input" day)))
    (arrows:->> (asdf:system-relative-pathname :aoc2021 day-path)
                (alexandria:read-file-into-string))))

(defun reduce-readings (readings)
  (reduce #'v2:+ readings :initial-value (v! 0 0)))

(defun reading-to-pair (reading)
  (destructuring-bind (dir ammount) (words reading)
    (let ((x (parse-integer ammount)))
      (alexandria:eswitch (dir :test #'string=)
        ("forward" (v! x    0))
        ("down"    (v! 0    x))
        ("up"      (v! 0 (- x)))))))

(defun day2-silver (text)
  (let ((v (arrows:->> text
                       (lines)
                       (mapcar #'reading-to-pair)
                       (reduce-readings))))
    (* (x v) (y v))))

(defun reading-to-thrice (reading)
  (destructuring-bind (dir ammount) (words reading)
    (let ((x (parse-integer ammount)))
      (alexandria:eswitch (dir :test #'string=)
        ("forward" (v! x 0    0))
        ("down"    (v! 0 0    x))
        ("up"      (v! 0 0 (- x)))))))

(defun reduce-readings-thrice (readings)
  (reduce (lambda (acc new)
            (if (> (x new) 0)
                (v:+ acc (v! (x new)
                             (* (x new) (z acc))
                             0))
                (v:+ acc new)))
          readings
          :initial-value (v! 0 0 0)))

(defun day2-gold (text)
  (let ((v (arrows:->> text
                       (lines)
                       (mapcar #'reading-to-thrice)
                       (reduce-readings-thrice))))
    (* (round (x v)) (round (y v)))))

(defun lines (text) (cl-ppcre:split #\NewLine text))
(defun words (line) (cl-ppcre:split #\Space   line))


