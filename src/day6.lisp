(in-package #:aoc2021)

(defun day6-silver (days text)
  (let ((fishes (text-to-fish text)))
    (future-fish days fishes)))

(declaim (inline age-fishes))
(defun age-fishes (fishes)
  (declare (optimize (speed 3)))
  (loop :for fish :in fishes
        :if (minusp (1- (the fixnum fish)))
          :append '(6 8)
        :else
          :collect (1- (the fixnum fish))))

(defun future-fish (days fishes)
  (declare (optimize (speed 3)))
  (declare (type list fishes) (type fixnum days))
  (dotimes (i days)
    (print i)
    (length fishes)
    (setf fishes (age-fishes fishes))))

(defun text-to-fish (text)
  (->> text (split ",") (mapcar #'parse-integer)))

;; 8,907,435  fishes before it dies
(defun day6-gold   (text) 1)
