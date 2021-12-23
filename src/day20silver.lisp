(in-package #:aoc2021)

;; NOT 5372 - too high

(defun day20-silver (encoder input times)
  (let* ((mat1 (pad-matrix times input))
         (mat2 (pad-matrix times input))
         (dimx (array-dimension mat1 0))
         (dimy (array-dimension mat1 1)))
    (dotimes (i times)
      (zero-mat mat1)
      (dotimes (x dimx)
        (dotimes (y dimy)
          (setf (aref mat1 x y)
                (cell-to-value mat2 x y encoder dimx dimy))))
      (copy-mat mat2 mat1))
    (values (reduce #'+ (aops:flatten mat2))
            (reduce #'+ (aops:flatten mat1))
            (reduce #'+ (aops:flatten input)))))



(defun zero-mat (mat1)
  (dotimes (i (array-total-size mat1))
    (setf (row-major-aref mat1 i) 0)))

(defun copy-mat (mat1 mat2)
  (dotimes (i (array-total-size mat1))
    (setf (row-major-aref mat1 i)
          (row-major-aref mat2 i))))

(defun cell-to-value (input x y encoder dimx dimy)
  (let ((index 0)
        (bit-index 0))
    (iter (for dx :from (1+ x) :downto (1- x))
      (iter (for dy :from (1+ y) :downto (1- y))
        (setf (ldb (byte 1 bit-index) index)
              (if (or (minusp dx) (minusp dy) (>= dx dimx) (>= dy dimy))
                  0
                  (aref input dx dy)))
        (incf bit-index)))
    (aref encoder index)))

(defun day20-silver-parse (file &aux (lines (lines (slurp file))))
  (labels ((char-to-zero (char)
             (if (eql #\# char) 1 0))
           (map-to-bit-vector (string)
             (map '(simple-bit-vector *)
                  #'char-to-zero
                  string))
           (make-bit-matrix (list)
             (make-array
              `(,(length list) (length (first list)))
              :element-type 'bit
              :initial-contents list)))
    (values (->> lines (first)  (map-to-bit-vector))
            (->> lines
                 (drop 2)
                 (mapcar #'map-to-bit-vector)
                 (make-bit-matrix)))))

(defun pad-matrix (by matrix)
  (lret* ((dimx2 (mapcar (op (+ (* 2 by) _))
                         (array-dimensions matrix)))
          (matx2 (make-array dimx2 :element-type
                             (array-element-type matrix))))
    (dotimes (x (array-dimension matrix 0))
      (dotimes (y (array-dimension matrix 1))
        (setf (aref matx2 (+ by x) (+ by y))
              (aref matrix x y))))))
