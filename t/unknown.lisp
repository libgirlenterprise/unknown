(in-package :cl-user)
(defpackage unknown-test
  (:use :cl
        :unknown
        :prove))
(in-package :unknown-test)

;; NOTE: To run this test file, execute `(asdf:test-system :unknown)' in your Lisp.

(plan nil)

;; blah blah blah.

(finalize)
