
(in-package :cl-user)

(defpackage com.libgirl.unknown-api
  (:use :cl)
  (:export :next :unknown :copy))

(in-package :com.libgirl.unknown-api)

(defclass unknown ()
  ()
  (:documentation "An unknown digit generator as a statefull object. "))
  
(defgeneric next (unknown &optional count input-digit-listn))

(defgeneric copy (unknown))

(defmethod next ((unknown unknown) &optional (count 1) input-digit-list)
  #.(format nil "Get next hex base unknown digit(s) counted by @cl:param(count) and go to the next @cl:param(count) -many further state. The same state always gives the same single digit.~%~%If @cl:param(input-digit-list) is present, @begin(list) @item(after generating each unknown digit, each digit in @cl:param(input-digit-list) is respectively consumed to change the state of @cl:param(unknown).) @item(The same state with the same input always goes to the same next state.) @item(If all @cl:param(input-digit-list) is consumed and unknown digit generation is still going on, state change will continue without input inteference.) @item(Surplus digits given in @cl:param(input-digit-list) will be just discarded.) @end(list)"))

(defmethod copy ((unknown unknown))
  "Get a copy of @cl:param(unknown) with the same state.")



;;  "@begin(list) @item(Set @cl:param(digit-to-set) into the generator which changes the current state.) @end(list)"

;;  "@begin(list) @item(Return current version and current state of the generator.) @end(list)")

;; (defun load-unknown-state (state-representation &key (by-some-random nil) (by-unknown-init nil))
  ;; "@begin(list) @item(Set the generator to the state by @cl:param(state-representation).) @item(Set the state as a random state if @cl:param(by-some-random) is @c(t).) @item(Set the state as a Libgirl system decided state if @cl:param(by-libgirl-unknown-system) is @c(t).) @item(Error will be raised if both of above two are @c(t).) @end(list)")
