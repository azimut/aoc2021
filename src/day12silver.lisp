(in-package #:aoc2021)

(defun day12-silver (edges)
  (let ((adjacencies (edges-to-adjacencies edges)))
    (find-silver-paths adjacencies
                (make-hash-table :test #'equal)
                "start"
                "end")))

(defun dead-end-silver-p (edge counter)
  (and (change-case:string-lower-case-p edge)
       (= 1 (href-default 0 counter edge))))

;; I don't know what I am doing...sorta
;; https://www.youtube.com/watch?v=TlYExiAAbHo&t=742s
(defun find-silver-paths (adjacencies counter from to)
  (if (string/= from to)
      (iter (for adj in (gethash from adjacencies))
        (when (not (dead-end-silver-p adj counter))
          (setf (href counter from) 1)
          (summing (find-silver-paths adjacencies counter adj to))
          (decf (gethash from counter))))
      1))

(defun day12-silver-parse (file)
  (->> file slurp lines (mapcar (curry #'split "-"))))

(defun edges-to-adjacencies (edges)
  (lret ((adjacencies (make-hash-table :test #'equal)))
    (iter (for (e1 e2) in edges)
      (push e1 (href adjacencies e2))
      (push e2 (href adjacencies e1)))))
