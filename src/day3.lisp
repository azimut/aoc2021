(in-package #:aoc2021)

(defun day3-silver (text)
  (* (->> (lines text)
          (mapcar (lambda (i) (parse-integer i :radix 2)))
          (gamma))
     (->> (lines text)
          (mapcar (lambda (i) (parse-integer i :radix 2)))
          (epsilon))))

(defun parse-binary (i)
  (parse-integer i :radix 2))

(defun bit-aref (number pos)
  (if (logbitp pos number) 1 0))

(defun bit-frequency (readings)
  (let ((state (make-array '(12 2))))
    (dolist (reading readings)
      (dotimes (i 12)
        (incf (aref state i (bit-aref reading i)))))
    state))

(defun gamma (readings)
  (let ((freq (bit-frequency readings))
        (ret  (make-array 0 :element-type 'character :adjustable t :fill-pointer 0)))
    (dotimes (i 12)
      (if (> (aref freq i 0) (aref freq i 1))
          (vector-push-extend #\0 ret)
          (vector-push-extend #\1 ret)))
    (parse-integer (reverse ret) :radix 2)))

(defun epsilon (readings)
  (let ((freq (bit-frequency readings))
        (ret  (make-array 0 :element-type 'character :adjustable t :fill-pointer 0)))
    (dotimes (i 12)
      (if (< (aref freq i 0) (aref freq i 1))
          (vector-push-extend #\0 ret)
          (vector-push-extend #\1 ret)))
    (parse-integer (reverse ret) :radix 2)))