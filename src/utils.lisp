(in-package #:aoc2021)

(defun lines (text) (cl-ppcre:split #\NewLine text))
(defun words (line) (cl-ppcre:split #\Space   line))

(defun get-test-string-for-day (day)
  (let ((day-path (format nil "static/day/~d/test" day)))
    (arrows:->> (asdf:system-relative-pathname :aoc2021 day-path)
                (alexandria:read-file-into-string))))

(defun get-input-string-for-day (day)
  (let ((day-path (format nil "static/day/~d/input" day)))
    (arrows:->> (asdf:system-relative-pathname :aoc2021 day-path)
                (alexandria:read-file-into-string))))
