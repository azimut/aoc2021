(in-package #:aoc2021)

(defun day4-silver (text)
  (let* ((lines (lines text))
         (raffle (lines-to-raffle-numbers lines))
         (boards (lines-to-boards lines)))
    (block nested
      (dolist (r raffle)
        (dolist (b boards)
          (mark b r)
          (when (bingo-p b)
            (return-from nested (* r (sum-of-unmarked b)))))))))

(defun day4-gold (text)
  (let* ((lines (lines text))
         (raffle (lines-to-raffle-numbers lines))
         (boards (lines-to-boards lines))
         (last-score))
    (dolist (r raffle)
      (dolist (b boards)
        (mark b r)
        (when (bingo-p b)
          (setf last-score (* r (sum-of-unmarked b)))
          (setf boards (remove b boards :test #'equal)))))
    last-score))

(defclass board ()
  ((numbers
    :initform (make-array '(5 5))
    :reader numbers)
   (hits
    :initform (make-array '(5 5) :initial-element NIL)
    :reader hits)))

(defun make-board (&rest args)
  (apply #'make-instance 'board args))

(defun lines-to-raffle-numbers (lines)
  (->> (first lines)
       (split ",")
       (mapcar #'parse-integer)))

(defun lines-to-boards (lines)
  (->> lines
       (drop 2)
       (remove-if #'blankp)
       (unlines)
       (words)
       (mapcar #'parse-integer)
       (partition-n 25 25)
       (mapcar #'numbers-to-board)))

(defun numbers-to-board (numbers)
  (loop :with board = (make-board)
        :for n :in numbers
        :for i :from 0
        :do (setf (row-major-aref (numbers board) i) n)
        :finally (return board)))

(defmethod bingo-p ((obj board))
  (or (bingo-row-p obj)
      (bingo-col-p obj)))

(defmethod bingo-col-p ((obj board))
  (dotimes (c 5)
    (and (aref (hits obj) c 0)
         (aref (hits obj) c 1)
         (aref (hits obj) c 2)
         (aref (hits obj) c 3)
         (aref (hits obj) c 4)
         (return t))))

(defmethod bingo-row-p ((obj board))
  (dotimes (r 5)
    (and (aref (hits obj) 0 r)
         (aref (hits obj) 1 r)
         (aref (hits obj) 2 r)
         (aref (hits obj) 3 r)
         (aref (hits obj) 4 r)
         (return t))))

(defmethod sum-of-unmarked ((obj board))
  (loop :for i :below (array-total-size (hits obj))
        :unless (row-major-aref (hits obj) i)
          :summing (row-major-aref (numbers obj) i)))

(defmethod mark ((obj board) number)
  (loop :for i :below (array-total-size (hits obj))
        :when (= number (row-major-aref (numbers obj) i))
          :do (setf (row-major-aref (hits obj) i) T)))
