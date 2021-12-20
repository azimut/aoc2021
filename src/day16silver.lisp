(in-package #:aoc2021)

(defun day16-silver (packets-string)
  (iter (for (desc value)
             :on (read-packet packets-string)
             :by #'cddr)
    (when (eq :version desc)
      (summing value))))

(defun read-packet (bitio)
  (when-let ((version (read-bits 3 bitio)))
    (when-let ((type-id (read-bits 3 bitio)))
      (flatten
       (cons
        (case type-id
          (4 `(:version ,version :type-id ,type-id
               :value ,(read-number bitio)))
          (t `(:version ,version :type-id ,type-id
                        ,(read-operator bitio))))
        (read-packet bitio))))))

(defun read-operator (bitio)
  (when-let ((type (read-bits 1 bitio))
             (data 0))
    `(,(ecase type
         (0 `(:length ,(setf data (read-bits 15 bitio))))
         (1 `(:number ,(setf data (read-bits 11 bitio))))))))

(defun read-number (bitio)
  (iter
    (for mark = (read-bits 1 bitio))
    (for frag = (read-bits 4 bitio))
    (collect frag into fragments)
    (until (or (null mark) (null frag) (zerop mark)))
    (finally
     (return (merge-numbers fragments)))))

(defun merge-numbers (4-bits)
  (loop :for 4-bit :in 4-bits
        :for offset :from (* 4 (1- (length 4-bits))) :downto 0 :by 4
        :with ret = 0
        :do (setf (ldb (byte 4 offset) ret) 4-bit)
        :finally (return ret)))

(defun day16-silver-parse (file)
  (-<>> (etypecase file
          (pathname (uiop:read-file-string file))
          (string file))
        (bitsmash:bits<-)
        (bitsmash:octets<-)
        (fast-io:make-input-buffer :vector)
        (bitio:make-bitio <> #'fast-io:fast-read-byte #'read-bit-sequence)))

(defun read-bit-sequence (bit-sequence buffer &key (start 0) end)
  (fast-io:fast-read-sequence bit-sequence buffer start end))

(defun read-bits (n b)
  (multiple-value-bind (rbit nbit)
      (handler-case (bitio:read-bits b n)
        (error (_)
          nil))
    (when (and nbit rbit (= nbit n))
      rbit)))
