(in-package #:aoc2021)

(defun day8-silver-parse (file)
  (->> file
       (slurp)
       (lines)
       (mapcar (curry #'split "|"))
       (mapcar #'second)
       (mapcar #'words)
       (mappend (curry #'mapcar #'length))))

(defun day8-silver (input)
  (+ (count 2 input); 1
     (count 4 input); 4
     (count 3 input); 7
     (count 7 input))) ;8

(defun day8-gold-parse (file)
  (->> file
       (slurp)
       (lines)
       (mapcar (curry #'split "|"))
       (mapcar #'unlines)
       (mapcar #'words)))

(screamer:define-screamer-package #:day8)

(in-package #:day8)

(defun day8-gold (input)
  ())

(defun add-readings-to-segment (segment readings)
  (loop :for reading :in readings
        :do (update segment reading))
  segment)

(defun add-reading-to-segment (segments reading)
  (dolist (i (reading-to-segments-index reading))
    (dolist (r (negative-index (reading-to-indexes reading)))
      (assert! (/=v (nth i segments) r))))
  (dolist (i (print (reading-to-segments-index reading)))
    (assert! (memberv (nth i segments) (print (reading-to-indexes reading))))))

(defun reading-to-segments-index (reading)
  (case (length reading)
    (2 '(2 5))                          ; one
    (3 '(0 2 5))                        ; seven
    (4 '(1 2 3 5))))                                        ; four

(defun reading-to-indexes (reading)
  (loop :for c :across reading
        :collect (- (char-code c) 97)))

(defun negative-index (indexes)
  (when indexes
    (set-difference '(0 1 2 3 4 5 6) indexes)))

(defun number-to-segments (number)
  (ecase number
    (0 '(0 1 2 4 5 6 7))
    (1 '(2 5))
    (2 '(0 2 3 4 6))
    (3 '(0 2 3 5 6))
    (4 '(1 2 3 5))
    (5 '(0 1 3 5 6))
    (6 '(0 1 3 4 5 6))
    (7 '(0 2 5 6))
    (8 '(0 1 2 3 4 5 6))
    (9 '(0 1 2 3 4 6))))

(defun make-segment ()
  (let ((a (an-integer-betweenv 0 6 :a))
        (b (an-integer-betweenv 0 6 :b))
        (c (an-integer-betweenv 0 6 :c))
        (d (an-integer-betweenv 0 6 :d))
        (e (an-integer-betweenv 0 6 :e))
        (f (an-integer-betweenv 0 6 :f))
        (g (an-integer-betweenv 0 6 :g)))
    (assert! (/=v a b c d e f g))
    (list a b c d e f g)))

(defun string-to-fact (string)
  (case (length string)
    (2 (either 1))
    (3 (either 7))
    (4 (either 4))
    (5 (either 2 3 5))
    (6 (either 0 6 9))
    (7 (either 8))
    (t (fail))))
