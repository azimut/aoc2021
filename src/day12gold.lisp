(in-package #:aoc2021)

(defun day12-gold (edges)
  (let ((adjacencies (edges-to-adjacencies edges))
        (lowercases  (cons "noexiste" (lowercase-edges edges)))
        (coll '()))
    (dolist (lowercase lowercases)
      (push (find-gold-paths adjacencies
                             (make-hash-table :test #'equal)
                             "start"
                             "end"
                             lowercase)
            coll))
    ;; TODO: YIKES!!!
    (+ (lastcar coll)
       (reduce #'+ (mapcar (rcurry #'- (lastcar coll))
                           coll)))))

(defun dead-end-gold-p (edge counter twice)
  (and (change-case:string-lower-case-p edge)
       (if (string= edge twice)
           (= 2 (href-default 0 counter edge))
           (= 1 (href-default 0 counter edge)))))

(defun find-gold-paths (adjacencies counter from to twice)
  (if (string/= from to)
      (iter (for adj in (gethash from adjacencies))
        (when (not (dead-end-gold-p adj counter twice))
          (setf (href counter from) (1+ (or (gethash from counter) 0)))
          (summing (find-gold-paths adjacencies counter adj to twice))
          (decf (gethash from counter))))
      1))

(defun lowercase-edges (edges)
  (-<>> edges
        (flatten)
        (filter #'change-case:string-lower-case-p)
        (remove-duplicates <> :test #'equal)
        (remove "end" <> :test #'equal)
        (remove "start" <> :test #'equal)))
