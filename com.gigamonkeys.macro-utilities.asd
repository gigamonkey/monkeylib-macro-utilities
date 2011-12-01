;;; Copyright (c) 2005-2011, Peter Seibel.
;;; All rights reserved. See COPYING for details.

(defsystem com.gigamonkeys.macro-utilities
  :author "Peter Seibel <peter@gigamonkeys.com>"
  :description "A few standard macro-writing macros. Deprecated. Use Alexandria instead."
  :components
  ((:file "packages")
   (:file "macro-utilities" :depends-on ("packages")))
  :depends-on ())
