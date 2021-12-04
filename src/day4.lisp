(in-package #:aoc2021)

;; Row or Colum = WIN
;; SCORE? sum of all unmarked      = 188
;;      x number that make the win = 24
;;        = 188 x 24 = 4512
;; Which board will win first?
;; SCORE?

(defun day4-silver (text)
  (let* ((lines (lines text))
         (raffle (lines-to-raffle-numbers lines))
         (boards (lines-to-boards lines)))
    (dolist (r raffle)
      (dolist (b boards)
        (mark b r)
        (when (bingo-p b)
          (print (* (sum-of-unmarked b)
                    r)) ;; FIXME
          (return))))))

(defclass board ()
  ((numbers
    :initform (make-array '(5 5))
    :accessor numbers)
   (hits
    :initform (make-array '(5 5) :initial-element NIL)
    :accessor hits)))

(defun numbers-to-board (numbers)
  (loop :with board = (make-board)
        :for n :in numbers
        :for i :from 0
        :do (setf (row-major-aref (numbers board) i) n)
        :finally (return board)))

(defun lines-to-raffle-numbers (lines)
  (->> (first lines)
       (split ",")
       (mapcar #'parse-integer)))

(defun lines-to-boards (lines)
  (->> lines
       (nthcdr 2)
       (remove-if #'blankp)
       (unlines)
       (words)
       (mapcar #'parse-integer)
       (cl-oju:partition-n 25 25)
       (mapcar #'numbers-to-board)))

(defun make-board (&rest args)
  (apply #'make-instance 'board args))

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

(defmethod bingo-p ((obj board))
  (or (bingo-row-p obj)
      (bingo-col-p obj)))

(defmethod sum-of-unmarked ((obj board))
  (loop :for i :to (1- (array-total-size (hits obj)))
        :unless (row-major-aref (hits obj) i)
          :summing (row-major-aref (numbers obj) i)))

(defmethod mark ((obj board) number)
  (loop :for i :to (1- (array-total-size (hits obj)))
        :when (= number (row-major-aref (numbers obj) i))
          :do (setf (row-major-aref (hits obj) i) T)))

;;----------------------------------------

(defun day4-gold (text)  0)
