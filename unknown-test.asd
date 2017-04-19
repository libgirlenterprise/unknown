#|
  This file is a part of unknown project.
|#

(in-package :cl-user)
(defpackage unknown-test-asd
  (:use :cl :asdf))
(in-package :unknown-test-asd)

(defsystem unknown-test
  :author ""
  :license ""
  :depends-on (:unknown
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "unknown"))))
  :description "Test system for unknown"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
