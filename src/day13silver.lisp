(in-package #:aoc2021)

(defun day13-silver (matrix folds)
  (destructuring-bind (axis by) (pop folds)
    (let ((mat (ecase axis
                 (y (fold-up   by matrix))
                 (x (fold-left by matrix)))))
      (reduce
       #'+
       (make-array (array-total-size mat)
                   :displaced-to mat)))))

(defun fold-up (at matrix)
  (destructuring-bind (h w) (array-dimensions matrix)
    (lret ((down (select matrix (iota (- h at 1) :start (1+ at)) t))
           (up   (select matrix (iota at) t)))
      (iter (for col below w)
        (iter
          (for up-row   from 0  below at)
          (for down-row from (1- (array-dimension down 0)) downto 0)
          (setf (aref up up-row col)
                (logior (aref up   up-row   col)
                        (aref down down-row col))))))))

(defun fold-left (at matrix)
  (destructuring-bind (h w) (array-dimensions matrix)
    (lret ((left  (select matrix t (iota at)))
           (right (select matrix t (iota (- w at 1) :start (1+ at)))))
      (iter (for row below h)
        (iter
          (for left-col from 0 below at)
          (for right-col from (1- (array-dimension right 1)) downto 0)
          (setf (aref right row right-col)
                (logior (aref left  row left-col)
                        (aref right row right-col))))))))

(defun day13-silver-parse (file)
  (let* ((pairs (file-to-pairs file))
         (grid  (pairs-to-grid pairs))
         (folds (file-to-folds file)))
    (upload pairs grid)
    (values grid
            folds)))

(defun upload (pairs grid)
  (iter (for (y x) in pairs)
    (setf (aref grid x y) 1)))

(defun file-to-pairs (file)
  (->> (slurp file)
       (lines)
       (filter (curry #'containsp ","))
       (mapcar (curry #'split ","))
       (mapcar (curry #'mapcar #'parse-integer))))

(defun file-to-folds (file)
  (->> (slurp file)
       (lines)
       (filter (curry #'containsp "fold"))
       (mapcar (compose #'fold-to-pair #'lastcar #'words))))

(defun pairs-to-grid (pairs)
  (let ((h (1+ (reduce #'max (mapcar #'second pairs))))
        (w (1+ (reduce #'max (mapcar #'first  pairs)))))
    (values (make-array `(,h ,w))
            `(,h ,w))))

(defun fold-to-pair (fold)
  `(,(read-from-string (subseq fold 0 1))
    ,(parse-integer    (subseq fold 2))))
