
(in-package :cl-user)

(defpackage com.libgirl.unknown
  (:use :cl-user :com.libgirl.smcl :ningle))

(in-package :com.libgirl.unkown)

;; (smcl-thread-run '((:x nil
;; 		    (:0
;; 		     :0)
;; 		    (:list-quote
;; 		     (:car (:y :a :b)
;; 		      :y)
;; 		     :c))
;; 		   (:y (:p1 :p2)
;; 		    (:yp
;; 		     :yp)
;; 		    (:when :p1 :p2))
;; 		   (:a (:p1 :p2)
;; 		    (:a1
;; 		     :0)
;; 		    (:list-quote :true (:y :d)))
;; 		   (:c nil
;; 		    (:0
;; 		     :0)
;; 		    :e)
;; 		   (:e (:p1)
;; 		    (:0
;; 		     :e2)
;; 		    (:p1 (:list-quote :p1 :none)))
;; 		   (:f (:x)
;; 		    (:f1
;; 		     (:list-quote (:defun :f :g)))
;; 		    (:e (:y :x)))
;; 		   (:8 (:p1)
;; 		    (:3
;; 		     :9)
;; 		    (:when (:when :w) (:cdr :p1)))
;; 		   (:z (:p1 :p2)
;; 		    ((:list-quote :defun :8)
;; 		     (:defun :f (:list-quote (:list-quote :3 (:list-quote :car :cdr)))))
;; 		    (:eq :p1 (:p2 (:e :p1) :1)))))
		     
(defvar *app* (make-instance 'ningle:unknown-generator))

(setf (ningle:route *app* "/")
      "Welcome to unknown!")

(defun unknown ()
  (clack:clackup *app*))
