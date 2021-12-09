(in-package #:aoc2021)

(defun day9-gold (array mask)
  (-<>> (basins array mask)
        (sort <> #'>)
        (take 3)
        (reduce #'*)))

(defun basins (array mask)
  (mask-nine array mask)
  (iterate outer (for x below (array-dimension array 0))
    (iterate (for y below (array-dimension array 1))
      (when (aref mask x y)
        (in outer (collect (excursion array mask `((,x ,y)))))))))

(defun mask-nine (array mask)
  (dotimes (i (array-total-size array))
    (when (= 9 (row-major-aref array i))
      (setf (row-major-aref mask i) NIL))))

(defun excursion (array mask pending &optional (counter 0))
  (when pending
    (destructuring-bind (fromx fromy) (pop pending)
      (appendf pending (excursion-up    array mask fromx fromy))
      (appendf pending (excursion-down  array mask fromx fromy))
      (appendf pending (excursion-left  array mask fromx fromy))
      (appendf pending (excursion-right array mask fromx fromy))
      (when (and (aref mask fromx fromy); yikes
                 (/= 9 (aref array fromx fromy)))
        (incf counter))
      (setf (aref mask fromx fromy) nil)))
  (if (null pending)
      counter
      (excursion array mask pending counter)))

(defun excursion-down (array mask fromx fromy)
  (iterate (for x from (1+ fromx) below (array-dimension array 0))
    (while (aref mask x fromy))
    (collect `(,x ,fromy))))
(defun excursion-up (array mask fromx fromy)
  (declare (ignore array))
  (iterate (for x from (1- fromx) downto 0)
    (while (aref mask x fromy))
    (collect `(,x ,fromy))))
(defun excursion-right (array mask fromx fromy)
  (iterate (for y from (1+ fromy) below (array-dimension array 1))
    (while (aref mask fromx y))
    (collect `(,fromx ,y))))
(defun excursion-left (array mask fromx fromy)
  (declare (ignore array))
  (iterate (for y from (1- fromy) downto 0)
    (while (aref mask fromx y))
    (collect `(,fromx ,y))))

(defun list-to-array-and-mask (list)
  (let ((h (length list))
        (w (length (first list))))
    (list (make-array `(,h ,w) :initial-contents list :element-type 'fixnum)
          (make-array `(,h ,w) :initial-element t :element-type 'boolean))))

(defun day9-gold-parse (file)
  (->> file
       (slurp)
       (lines)
       (mapcar
        (serapeum:op
          (map 'list (compose #'parse-integer #'string )
               _)))
       (list-to-array-and-mask)))
