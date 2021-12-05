(in-package #:aoc2021)

(defun day5-silver (text)
  (let* ((numbers  (text-to-numbers text))
         (grid     (make-grid :dim (1+ (apply #'max numbers))))
         (segments (numbers-to-segments numbers)))
    (dolist (s segments)
      (draw grid s))
    (n-danger-spots grid)))

(defclass segment ()
  ((from :initarg :from :reader from)
   (to   :initarg :to   :reader to)))

(defun make-segment (x1 y1 x2 y2 &rest args)
  (apply #'make-instance 'segment
         :from (vector x1 y1)
         :to (vector x2 y2)
         args))

(defmethod print-object ((obj segment) stream)
  (print-unreadable-object (obj stream :type T :identity T)
    (with-slots (from to) obj
      (format stream "(~d ~d) -> (~d ~d)"
              (aref from 0) (aref from 1) (aref to 0) (aref to 1)))))

(defmethod diagonal-p ((obj segment))
  (let ((slope (slope obj)))
    (and slope (= 1 (abs slope)))))

(defmethod flat-p ((obj segment))
  (let ((slope (slope obj)))
    (or (not slope)
        (= 0 slope))))

;; Thanks again Khan...
;; Slope = Raise/Run = dy/dx = m
;; = (y2-y1)/(x2-x1)
;; = 0 when is horizontal
;; = 1 when 45° diagonal
;; = UNDEFINED for vertical lines
(defmethod slope ((obj segment))
  (handler-case
      (->> (mapv #'- (to obj) (from obj))
           (reduce #'/))
    (division-by-zero (_)
      (declare (ignore _)))))

(defun numbers-to-segments (numbers)
  (->> numbers
       (partition-n 4 4)
       (mapply #'make-segment)
       (filter #'flat-p)))

(defun text-to-numbers (text)
  (->> (words text)
       (remove-if (curry #'string= "->"))
       (mappend (curry #'split ","))
       (mapcar #'parse-integer)))

(defclass grid ()
  ((board :reader board)
   (dim   :initarg :dim :initform (error "You need to specify the grid DIM (ensions)"))))

(defmethod print-object ((obj grid) stream)
  (print-unreadable-object (obj stream :type T :identity T)
    (format stream "~a" (board obj))))

(defmethod initialize-instance :after ((obj grid) &key dim)
  (setf (slot-value obj 'board) (make-array (list dim dim))))

(defun make-grid (&rest args)
  (apply #'make-instance 'grid args))

(defmethod n-danger-spots ((obj grid))
  (loop :for i :below (array-total-size (board obj))
        :count (>= (row-major-aref (board obj) i) 2)))

(defmethod draw ((obj grid) (segment segment))
  (when (flat-p segment)
    (let ((board (board obj))
          (x1    (aref (from segment) 0))
          (x2    (aref (to   segment) 0))
          (y1    (aref (from segment) 1))
          (y2    (aref (to   segment) 1)))
      (loop :for i :from (min x1 x2)
              :to (max x1 x2)
            :when (not (= x1 x2))
              :do (incf (aref board y1 i)))
      (loop :for i :from (min y1 y2)
              :to (max y1 y2)
            :when (not (= y1 y2))
              :do (incf (aref board i x1)))))
  (when (diagonal-p segment)
    (loop :with from  = (copy-seq (from segment))
          :with to    = (copy-seq (to   segment))
          :with board = (board obj)
          :until (equalp from to)
          :do
             (incf (aref board (aref from 1) (aref from 0)))
             (setf from (mapv #'+ from (walk-to from to)))
          :finally
             (incf (aref board (aref from 1) (aref from 0))))))

(defun walk-to (from to)
  (->> (mapv #'- to from)
       (mapv #'one-for-all)))

(defun one-for-all (n)
  (cond ((plusp  n) +1)
        ((minusp n) -1)
        (t 0)))

(defun numbers-to-valid-segments (numbers)
  (->> numbers
       (partition-n 4 4)
       (mapply #'make-segment)
       (filter (disjoin #'flat-p #'diagonal-p))))

;; IS NOT: 17656, 30406, 20195
(defun day5-gold (text)
  (let* ((numbers  (text-to-numbers text))
         (grid     (make-grid :dim (1+ (apply #'max numbers))))
         (segments (numbers-to-valid-segments numbers)))
    (dolist (s segments)
      (draw grid s))
    (n-danger-spots grid)))

