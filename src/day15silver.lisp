(in-package #:aoc2021)

(defun day15-silver-parse (file)
  (make-risk-matrix file))

(defun day15-silver (risk-matrix)
  (let* ((risk-matrix-size (array-total-size risk-matrix))
         (adjacencies (make-adjacency-hash risk-matrix))
         (visits (make-array (array-dimensions risk-matrix) :initial-element NIL))
         (prevs  (make-array (array-dimensions risk-matrix)))
         (costs  (make-costs risk-matrix-size)))
    (dijkstra (1- risk-matrix-size) risk-matrix
              adjacencies visits prevs costs)
    (+ (retrace-and-sum (1- risk-matrix-size) risk-matrix prevs)
       (row-major-aref risk-matrix (1- risk-matrix-size))))) ;; *sigh*

(defun retrace-and-sum (from matrix prevs)
  (iter (for prev = (row-major-aref prevs from))
    (while (and prev (/= prev 0)))
    (summing (row-major-aref matrix prev))
    (setf from prev)))

;; I don't know what I am doing
;; https://www.youtube.com/watch?v=GazC3A4OQTE
(defun dijkstra (to matrix adjacencies visits prevs costs)
  (iter (for (node cost) = (first costs))
    (while (and node (/= node to)))
    (dolist (adj (href adjacencies node))
      (when (and (not (row-major-aref visits adj))
                 (< (+ cost (row-major-aref matrix adj))
                    (assocadr adj costs)))
        (setf (row-major-aref prevs adj) node)
        (add-cost costs `(,adj ,(+ cost (row-major-aref matrix adj))))))
    (setf (row-major-aref visits node) T)
    (pop costs)))

(defun make-costs (size)
  (iter (repeat (1- size))
    (for i from 1)
    (collecting `(,i ,most-positive-fixnum) into res)
    (finally (return (cons '(0 0) res)))))

(defun add-cost (costs new-element)
  (prog1 costs
    (setf costs (delete (first new-element) costs :key #'first :test #'=))
    (if-let ((i (position-if (op (>= _ (second new-element))) costs
                             :key #'second)))
      (push new-element (cdr (drop (1- i) costs)))
      (push new-element (cdr (last costs))))))

(defun make-risk-matrix (file)
  (let* ((byte-vector (read-file-into-byte-vector file))
         (space-position (position 10 byte-vector)))
    (-<>> byte-vector
          (delete 10)
          (aops:each* '(unsigned-byte 4) (compose #'digit-char-p #'code-char))
          (aops:reshape <> `(,space-position t)))))

(defun make-adjacency-hash (matrix)
  (lret ((cols (array-dimension matrix 0))
         (size (array-total-size matrix))
         (hash (dict)))
    (dotimes (i size)
      (setf
       (href hash i)
       (remove
        nil
        `(,(and (>= (- i cols) 0)    (- i cols)) ;; up
          ,(and (<  (+ i cols) size) (+ i cols)) ;; down
          ,(and (<= (* cols (floor i cols))      ;; left
                    (- i 1)
                    (* cols (1+ (floor i cols))))
                (- i 1))
          ,(and (< (* (floor i cols) cols)       ;; right
                   (+ i 1)
                   (* (1+ (floor i cols)) cols))
                (+ i 1))))))))
