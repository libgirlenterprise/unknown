#|
  This file is a part of com.libgirl.unknown project.
|#

(in-package :cl-user)
(defpackage com.libgirl.unknown-asd
  (:use :cl :asdf))
(in-package :com.libgirl.unknown-asd)

(defsystem unknown
  :version "0.1"
  :author ""
  :license ""
  :depends-on (:smcl
               :ningle
	       :clack)
  :components ((:module "src"
                :components
                ((:file "unknown"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op unknown-test))))
