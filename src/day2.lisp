(in-package #:aoc2021)

(defclass silver ()
  ((horizontal :initform 0 :accessor horizontal)
   (depth      :initform 0 :accessor depth)))

(defmethod result (obj)
  (* (horizontal obj) (depth obj)))
(defmethod forward ((obj silver) qty)
  (incf (horizontal obj) qty))
(defmethod down ((obj silver) qty)
  (incf (depth obj) qty))
(defmethod up ((obj silver) qty)
  (decf (depth obj) qty))

(defun readarray (text)
  (-> text words unlines lines))

(defun day2-silver (text)
  (let ((silver (make-instance 'silver)))
    (loop :for (operation ammount) :on (readarray text) :by #'cddr
          :do (funcall (read-from-string operation)
                       silver
                       (parse-integer ammount)))
    (result silver)))

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
