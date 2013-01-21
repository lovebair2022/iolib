;;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-

(asdf:defsystem :iolib.common-lisp
  :description "Slightly modified Common Lisp."
  :maintainer "Stelian Ionescu <sionescu@cddr.org>"
  :version (:read-file-form "../version.lisp-expr")
  :licence "MIT"
  :defsystem-depends-on (:iolib.asdf :iolib.conf)
  :depends-on (:alexandria)
  :around-compile "iolib.asdf:compile-wrapper"
  :pathname "new-cl/"
  :components
  ((:file "conduits")
   #+scl (:file "scl-gray-streams")
   (:file "pkgdcl" :depends-on ("conduits" #+scl "scl-gray-streams")
    :perform
    (asdf:compile-op :before (o c)
      (asdf/package:symbol-call :iolib.conf '#:load-gray-streams))
    :perform
    (asdf:load-op :before (o c)
      (asdf/package:symbol-call :iolib.conf '#:load-gray-streams))
    :perform
    (asdf:load-source-op :before (o c)
      (asdf/package:symbol-call :iolib.conf '#:load-gray-streams)))
   (:file "gray-streams"
    :depends-on ("pkgdcl" #+scl "scl-gray-streams"))
   (:file "definitions" :depends-on ("pkgdcl"))
   (:file "types" :depends-on ("pkgdcl"))))

(asdf:defsystem :iolib.base
  :description "Base IOlib package, used instead of CL."
  :author "Stelian Ionescu <sionescu@cddr.org>"
  :maintainer "Stelian Ionescu <sionescu@cddr.org>"
  :version (:read-file-form "../version.lisp-expr")
  :licence "MIT"
  :defsystem-depends-on (:iolib.asdf :iolib.conf)
  :depends-on (:iolib.common-lisp :alexandria :split-sequence)
  :around-compile "iolib.asdf:compile-wrapper"
  :pathname "base/"
  :components
  ((:file "pkgdcl")
   (:file "return-star" :depends-on ("pkgdcl"))
   (:file "types" :depends-on ("pkgdcl" "return-star"))
   (:file "debug" :depends-on ("pkgdcl" "return-star"))
   (:file "conditions" :depends-on ("pkgdcl" "return-star"))
   (:file "defalias" :depends-on ("pkgdcl" "return-star"))
   (:file "deffoldable" :depends-on ("pkgdcl" "return-star"))
   (:file "defobsolete" :depends-on ("pkgdcl" "return-star"))
   (:file "reader" :depends-on ("pkgdcl" "return-star" "conditions"))
   (:file "sequence" :depends-on ("pkgdcl" "return-star"))
   (:file "matching" :depends-on ("pkgdcl" "return-star"))
   (:file "time" :depends-on ("pkgdcl" "return-star"))
   (:file "dynamic-buffer" :depends-on ("pkgdcl" "return-star" "sequence"))))
