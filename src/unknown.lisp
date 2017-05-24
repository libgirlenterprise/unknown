
(in-package :cl-user)

(defpackage com.libgirl.unknown
  (:use :cl :com.libgirl.smcl :ningle :clack :decimals)
  (:import-from :cl-utilities :split-sequence)
  (:export :unknown :unknown-stop))

(in-package :com.libgirl.unknown)

(defun make-symbol-with-security-suffix (symbol-as-string)
  (read-from-string (format nil
			    "~a-i-love-libgirl"
			    symbol-as-string)))

(defvar *unknown-generator-app*)

(defvar *unknown-generator-app-handler*)

(define-condition character-range-error (error)
  ((message :initarg :message :initform "character is not in number, alphabet, or #\-")))

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
      (t (error 'character-range-error)))))

;; (defmacro get-char-form (form)
;;       #'(lambda (params)
;; 	  (format nil
;; 		  "~a"
;; 		  (smcl-get-char))))
(eval `(defun ,(make-symbol-with-security-suffix "raw-char") () ; security suffix protects the server from source code injection when getting requests to /next
	 (smcl-run-steps)
	 (smcl-get-char)))

(eval `(defun ,(make-symbol-with-security-suffix "zero-to-36-char") ()
	 (char-to-number-code (,(make-symbol-with-security-suffix "raw-char")))))

(eval `(defun ,(make-symbol-with-security-suffix "normalize-char") ()
	 (format-decimal-number (/ (,(make-symbol-with-security-suffix "zero-to-36-char"))
				   36)
				:round-magnitude -10)))

(setf *unknown-generator-app*
      (make-instance 'ningle:<app>))

;;(setf (ningle:route *unknown-generator-app* "/get-char/:format"))

(setf (ningle:route *unknown-generator-app* "/")
      #'(lambda (params)
	  (format nil
		  "~a"
		  (smcl-get-char))))

(setf (ningle:route *unknown-generator-app*
		    "/next"
		    :method :POST)
      #'(lambda (params)
	  (let ((data-count (parse-integer (or (cdr (assoc "count"
							 params
							 :test #'string=))
					       "1")
					   :junk-allowed t))
		(data-type (cdr (assoc "data-type"
				       params
				       :test #'string=)))
		(input-digits-single-string (cdr (assoc "input-digit-list"
							 params
							 :test #'string=))))
	    (handler-case
		(let ((input-digit-string-list (when input-digits-single-string
						 (split-sequence #\Comma
								 input-digits-single-string))))
		  (format nil
			  "~{~a~^,~}"
			  (loop for i from 0 below data-count
			     collect (prog1
					 (funcall (eval (read-from-string (format nil
										  "#'com.libgirl.unknown::~a-char~(~a~)"
										  (or data-type "raw")
										  (make-symbol-with-security-suffix "")))))
				       (when (< i (length input-digit-string-list))
					 (let ((char-to-set (aref (nth i
								       input-digit-string-list)
								  0)))
					   (char-to-number-code char-to-set) ; to raise error if input invalid
					   (smcl-set-char char-to-set)))))))
	      (character-range-error (mre)
		(format nil
			"There are invalid input characters"))
	      (type-error (te)
	      	(format nil
	      		"Invalid request data-count parameter. Not a valid integer."))
	      (undefined-function (uf)
		(format nil
			"Invalid request data-type parameter"))))))


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
