(in-package #:aoc2021)

;; INPUT:
;; nearby vents
;; represented as Line Segments
;; x1,y1 -> x2->y2
;; Ony
;; x1=x2 y1=y2
;; 0,0 TL
;; 9,9 BR
;; 2 Lines might cover the same point
;;
;; How many points >=2 overlaps?
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
  (apply #'make-instance 'segment :from (vector x1 y1) :to (vector x2 y2) args))

(defmethod print-object ((obj segment) stream)
  (print-unreadable-object (obj stream :type T :identity T)
    (with-slots (from to) obj
      (format stream "(~d ~d) -> (~d ~d)"
              (aref from 0) (aref from 1) (aref to 0) (aref to 1)))))

(defmethod diagonal-p ((obj segment))
  (not (or (= (aref (from obj) 0)
              (aref (to   obj) 0))
           (= (aref (from obj) 1)
              (aref (to   obj) 1)))))

(defun numbers-to-segments (numbers)
  (->> numbers
       (partition-n 4 4)
       (serapeum:mapply #'make-segment)
       (remove-if #'diagonal-p)))

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
  (loop :for i :to (1- (array-total-size (board obj)))
        :count (>= (row-major-aref (board obj) i) 2)))

(defmethod draw ((obj grid) (segment segment))
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

(defun day5-gold   (text) 1)
