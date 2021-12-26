(in-package #:aoc2021)

(defun day14-silver (template rules steps)
  (-<>> (polymer-after-nth template rules steps)
        (frequencies)
        (sort <> #'> :key #'second)
        (funcall
         (fork #'-
               #'cadar
               (compose #'lastcar #'lastcar)))))

(defun polymer-after-nth (template rules steps)
  (dotimes (i steps template)
    (setf template (template-resolved template rules))))

(defun template-resolved (template rules)
  (iter (for (t1 t2) on template)
    (while (and t1 t2))
    (appending (polymer-resolved t1 t2 rules)
               into final)
    (finally (return (nconc final (last template))))))

(defun polymer-resolved (p1 p2 rules)
  (iter (for (r1 r2 middle) in rules)
    (finding `(,r1 ,middle) ;; NOTE: missing the last item
             such-that (and (eql r1 p1) (eql r2 p2))
             on-failure `(,r1))))

(defun day14-silver-parse (file)
  (values (polymer-template file)
          (polymer-rules file)))

(defun polymer-rules (file)
  (->> (slurp file)
       (lines)
       (drop 2)
       (mapcar #'polymer-rule)))

(defun polymer-rule (rule)
  `(,(read-from-string (substring 0 1 rule))
    ,(read-from-string (substring 1 2 rule))
    ,(read-from-string (substring 6 7 rule))))

(defun polymer-template (file)
  (with-open-file (stream file)
    (->> (read-line stream)
         (map 'list (compose #'read-from-string #'string)))))
