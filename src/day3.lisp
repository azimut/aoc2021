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


;;----------------------------------------

(defun day3-gold (text)
  (* (->> (lines text)
          (o2))
     (->> (lines text)
          (co2))))

(defun frequencies-char (strings i)
  (->> strings
       (mapcar (serapeum:op (char _ i)))
       (serapeum:frequencies)))

(defun highest-frequency (strings i)
  (let* ((freq  (frequencies-char strings i))
         (zerof (gethash #\0 freq))
         (onef  (gethash #\1 freq)))
    (cond ((not zerof)    #\0)
          ((not onef)     #\1)
          ((> zerof onef) #\0)
          ((= zerof onef) #\1)
          (t #\1))))

(defun lowest-frequency (strings i)
  (let* ((freq  (frequencies-char strings i))
         (zerof (gethash #\0 freq))
         (onef  (gethash #\1 freq)))
    (cond ((not zerof)    #\1)
          ((not onef)     #\0)
          ((> zerof onef) #\1)
          ((= zerof onef) #\0)
          (t #\0))))

(defun  o2 (readings)
  (dotimes (i (length (first readings)))
    (let ((char-to-keep (highest-frequency readings i)))
      (serapeum:filterf
       readings
       (serapeum:op (equal char-to-keep (char _ i))))))
  (parse-binary (first readings)))

(defun co2 (readings)
  (dotimes (i (length (first readings)))
    (let ((char-to-keep (lowest-frequency readings i)))
      (serapeum:filterf
       readings
       (serapeum:op (eql char-to-keep (char _ i))))))
  (parse-binary (first readings)))
