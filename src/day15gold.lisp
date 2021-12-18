(in-package #:aoc2021)

(defun day15-gold-parse (file)
  (make-gold-risk-matrix (make-risk-matrix file)))

(defun day15-gold (risk-matrix)
  (let* ((adjacencies (make-adjacency-hash risk-matrix))
         (matrix-size (array-total-size risk-matrix))
         (visits (make-array (array-dimensions risk-matrix) :element-type 'bit))
         (prevs  (make-array (array-dimensions risk-matrix) :element-type '(unsigned-byte 32)))
         (costs  (make-costs matrix-size)))
    (print matrix-size)
    (dijkstra-gold (1- matrix-size) risk-matrix
                   adjacencies visits prevs costs)
    (+ (retrace-and-sum (1- matrix-size) risk-matrix prevs)
       (row-major-aref risk-matrix (1- matrix-size)))))

(defun dijkstra-gold (to matrix adjacencies visits prevs costs)
  (iter (for (node cost) = (pop costs))
    (while (and node (/= node to)))
    (when (zerop (mod node 500))
      (format t "Currently on node: ~A~%" node))
    (dolist (adj (href adjacencies node))
      (let ((new-cost (+ cost (row-major-aref matrix adj))))
        (when (and (not (logbitp 0 (row-major-aref visits adj)))
                   (< new-cost (assocadr adj costs)))
          (setf (row-major-aref prevs adj) node)
          (add-cost costs `(,adj ,new-cost)))))
    (setf (row-major-aref visits node) #b1)))

(defun make-gold-risk-matrix (matrix)
  (destructuring-bind (ncols nrows) (array-dimensions matrix)
    (lret ((5-matrix (make-array (mapcar (op (* 5 _)) `(,ncols ,nrows));; FIXME
                                 :element-type '(unsigned-byte 4))))
      ;; Horizontal Grids
      (dotimes (y ncols)
        (dotimes (x nrows)
          (setf (aref 5-matrix x y) (aref matrix x y))
          (dotimes (dt 4);; FIXME
            (let ((curry (+ y (*     dt  ncols)))
                  (nexty (+ y (* (1+ dt) ncols))))
              (setf (aref 5-matrix x nexty)
                    (1+ (mod (aref 5-matrix x curry) 9)))))))
      ;; Vertical Grids
      (dotimes (y (array-dimension 5-matrix 1))
        (dotimes (x nrows)
          (dotimes (dt 4);; FIXME
            (let ((currx (+ x (*     dt  ncols)))
                  (nextx (+ x (* (1+ dt) ncols))))
              (setf (aref 5-matrix nextx y)
                    (1+ (mod (aref 5-matrix currx y) 9))))))))))
