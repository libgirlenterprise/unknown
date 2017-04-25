
(in-package :cl-user)

(defpackage com.libgirl.unknown
  (:use :cl :com.libgirl.smcl :ningle :clack :decimals)
  (:export :unknown :unknown-stop))

(in-package :com.libgirl.unknown)

(defvar *unknown-generator-app*)

(defvar *unknown-generator-app-handler*)

(defun char-to-number-code (char) ;;TODO: should auto test this function
  (let ((code (char-code char)))
    (cond
      ((eq code 45) 36)
      ((and (>= code 48)
	    (<= code 57))
       (- code 48))
      ((and (>= code 97)
	    (<= code 122))
       (- code 87)) ; former 10 are 0~9, so 87 means code - 97 + 10
      (t (error "character is not in number, alphabet, or #\-")))))
	       
;; (defmacro get-char-form (form)
;;       #'(lambda (params)
;; 	  (format nil
;; 		  "~a"
;; 		  (smcl-get-char))))

(setf *unknown-generator-app*
      (make-instance 'ningle:<app>))

;;(setf (ningle:route *unknown-generator-app* "/get-char/:format"))
      
(setf (ningle:route *unknown-generator-app* "/")
      #'(lambda (params)
	  (format nil
		  "~a"
		  (smcl-get-char))))

(setf (ningle:route *unknown-generator-app* "/normalize")
      #'(lambda (params)
	  (format-decimal-number (/ (char-to-number-code (smcl-get-char))
					      36)
				 :round-magnitude -10)))

(setf (ningle:route *unknown-generator-app* "/one-to-36")
      #'(lambda (params)
	  (format nil
		  "~a"
		  (char-to-number-code (smcl-get-char)))))

(setf (ningle:route *unknown-generator-app* "/step/:count")
      #'(lambda (params)
	  (let ((step-count (parse-integer (cdr (assoc :count params))
					   :junk-allowed t)))
	    (and step-count
		 (> step-count 0)
		 (format nil
			 "~a"
			 (progn
			   (smcl-run-steps :step-count step-count)
			   step-count))))))

;; (setf (ningle:route *unknown-generator-app* "/")
;;       "Welcome to unknown!")

(defun unknown ()
  (smcl-thread-run '((:x nil
  		      (:0
  		       :0)
  		      (:list-quote
  		       (:car (:y :a :b)
  			     :y)
  		       :c))
  		     (:y (:p1 :p2)
  		      (:yp
  		       :yp)
  		      (:when :p1 :p2))
  		     (:a (:p1 :p2)
  		      (:a1
  		       :0)
  		      (:list-quote :true (:y :d)))
  		     (:c nil
  		      (:0
  		       :0)
  		      :e)
  		     (:e (:p1)
  		      (:0
  		       :e2)
  		      (:p1 (:list-quote :p1 :none)))
  		     (:f (:x)
  		      (:f1
  		       (:list-quote (:defun :f :g)))
  		      (:e (:y :x)))
  		     (:8 (:p1)
  		      (:3
  		       :9)
  		      (:when (:when :w) (:cdr :p1)))
  		     (:z (:p1 :p2)
  		      ((:list-quote :defun :8)
  		       (:defun :f (:list-quote (:list-quote :3 (:list-quote :car :cdr)))))
  		      (:eq :p1 (:p2 (:e :p1) :1)))))
  (setf *unknown-generator-app-handler*
	(clack:clackup *unknown-generator-app*)))

(defun unknown-stop ()
  (smcl-thread-end)
  (clack:stop *unknown-generator-app-handler*))
