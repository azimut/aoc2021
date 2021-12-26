(in-package #:aoc2021)

(defun day18-silver (input)
  (->> input
       (mapcar #'silverfish-reduce)
       (silverfish-sum)
       (silverfish-magnitude)))

(defun silverfish-reduce (fish)
  )

(defun find-cons-at-4-depth (fish &aux (position 0))
  (labels
      ((cons-of-nums-p (cons)
         (and (consp cons)
              (numberp (car cons))
              (numberp (cdr cons))))
       (tree-walk (tree target depth)
         (cond
           ((and (> target depth) (consp tree))
            (tree-walk (car tree) target (1+ depth))
            (tree-walk (cdr tree) target (1+ depth)))
           ((and (= target depth) (cons-of-nums-p tree))
            (return-from find-cons-at-4-depth (cons position tree))))))
    (tree-walk fish 5 0)))

(defun reduce-explode (fish &aux (depth 0))
  (flet ((foo (node)
           (when (and (consp node) (= 4 (incf depth)))
             )
           node))
    (serapeum:map-tree #'foo fish)))

(defun reduce-split (fish &aux flag)
  (serapeum:leaf-map
   (lambda (a) (if (and (not flag) (> a 9))
              (setf flag (cons (floor a) (ceiling a)))
              a))
   fish))

(defun silverfish-sum (fishes))
(defun silverfish-magnitude (fish-number))

(defun day18-silver-parse (input)
  (->> (etypecase input
         (pathname (slurp input))
         (string input))
       (lines)
       (mapcar #'silverfish-cons)))

(defstruct node
  (car   nil)
  (cdr   nil)
  (depth 0)
  (pos   0))

(defun silverfish-cons (string)
  (->> string
       (replace-all "," " :cdr ")
       (replace-all "]" " :depth 0 :pos 0)")
       (replace-all "[" "#S(NODE :car " )
       (read-from-string)))


(defun silverfish-cons (string)
  (->> string
       (replace-all "," " . ")
       (replace-all "]" ")")
       (replace-all "[" "(" )
       (read-from-string)))

(defun silverfish-magnitude (input)
  (typecase input
    (list (+ (* 3 (silverfish-magnitude (first input)))
             (* 2 (silverfish-magnitude (second input)))))
    (number input)))
