;;
;; Copyright (c) 2005-2010, Peter Seibel. All rights reserved.
;;

(defsystem com.gigamonkeys.macro-utilities
  :author "Peter Seibel <peter@gigamonkeys.com>"
  :components
  ((:file "packages")
   (:file "macro-utilities" :depends-on ("packages")))
  :depends-on ())

        
