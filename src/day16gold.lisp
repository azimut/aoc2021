

(defun read-number (arr)
  (ldb (byte 1 1) (aref arr 0));; A signal
  (ldb (byte 1 0) (aref arr 0));; A half
  (ldb (byte 3 5) (aref arr 1));; A half
  (ldb (byte 5 0) (aref arr 1));; B signal + whole
  (ldb (byte 5 3) (aref arr 2));; C signal + whole
  (ldb (byte 3 0) (aref arr 2));; D signal + half
  (ldb (byte 2 6) (aref arr 3));; D half
  (ldb (byte 5 2) (aref arr 3));; E signal + whole
  )

(defun read-literal (input-array)
  (list :version (read-version input-array)
        :id (read-typeid input-array)
        :number (read-number input-array)))

(defun read-operator (arr)
  (flet ((read-length-type (a)
           (ldb (byte 1 1) (aref a 0))))
    (list :version (read-version arr)
          :id (read-typeid arr)
          :length-type (read-length-type arr))))


(defclass packet ()
  ((version :reader packer-version :initarg :version)
   (typeid  :reader packet-typeid  :initarg :typeid)))
(defclass packet-literal (packet)
  ((number :reader packet-number :initarg :number)))
(defclass packet-operator (packet)
  ((lengthid :reader packet-lengthid :initarg :lengthid)))
