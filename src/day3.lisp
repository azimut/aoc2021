(in-package #:aoc2021)

(defun day3-silver (text)
  (* (epsilon (lines text))
     (gamma   (lines text))))

(defun epsilon (lines)
  (mapf #'decode-epsilon lines))

(defun gamma (lines)
  (mapf #'decode-gamma lines))

(defun mapf (f lines)
  (-> (loop :for i :to (1- (length (first lines)))
            :collect (funcall f (encode-column i lines)))
      (coerce 'string)
      (parse-integer :radix 2)))

(defun encode-column (i lines)
  (->> lines
       (mapcar (rcurry #'char i))
       (mapcar #'encode-char)
       (reduce #'+)))

(defun encode-char (char)
  (if (char= #\0 char)
      (- 1)
      (+ 1)))

(defun decode-gamma   (int) (if (> int 0) #\1 #\0))
(defun decode-epsilon (int) (if (> int 0) #\0 #\1))

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

(defun parse-binary (i)
  (parse-integer i :radix 2))

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
