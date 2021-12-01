(in-package #:aoc2021)

(defun get-integer-input-for-day (day)
  (let ((day-path (format nil "static/day/~d/input" day)))
    (arrows:->> (asdf:system-relative-pathname :aoc2021 day-path)
                (alexandria:read-file-into-string)
                (cl-ppcre:split "\\n")
                (mapcar #'parse-integer))))

(defun n-increases (readings)
  "Count the number of times the readings increase"
  (loop :for (r1 r2) :on readings :by #'cdr
        :with i = 0
        :if (and r1 r2 (> r2 r1))
          :count i))

(defun sum-group-by-3 (readings)
  (loop :for (r1 r2 r3) :on readings
        :while (and r1 r2 r3)
        :collect (+ r1 r2 r3)))
