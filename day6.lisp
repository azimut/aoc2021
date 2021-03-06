(in-package #:aoc2021)

(defun day6-silver (days text)
  (let ((fishes (text-to-fish text)))
    (future-fish days fishes)))

(declaim (inline age-fishes))
(defun age-fishes (fishes)
  (declare (optimize (speed 3) (safety 0)))
  (loop :for fish :of-type fixnum :in fishes
        :if (minusp (1- fish))
          :append '(6 8)
        :else
          :collect (1- fish)))

(defun future-fish (days fishes)
  (declare (optimize (speed 3) (safety 0)) (list fishes) (fixnum days))
  (dotimes (i days)
    (setf fishes (age-fishes fishes)))
  (length fishes))

(defun text-to-fish (text)
  (->> text (split ",") (mapcar #'parse-integer)))

;;----------------------------------------

(defun day6-gold (days text)
  (let ((counters (fishes-to-counters (text-to-fish text))))
    (dotimes (day days)
      (setf counters (rotate-fish counters)))
    (reduce #'+ counters)))

(defun rotate-fish (counters)
  (let ((rotated (rotate counters -1)))
    (incf (nth 6 rotated) (lastcar rotated))
    rotated))

(defun fishes-to-counters (fishes)
  (let ((counter (make-list (+ 2 7) :initial-element 0)))
    (dolist (fish fishes)
      (incf (elt counter fish)))
    counter))
