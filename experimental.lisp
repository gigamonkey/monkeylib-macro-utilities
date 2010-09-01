(in-package :com.gigamonkeys.macro-utilities)

;;; Experimental macros. Not exported.

(defmacro with-multiple-gensyms ((&rest names) value-producing-form &body body)
  `(with-gensyms (,@names)
     (multiple-value-bind (,@names) ,value-producing-form
       ,@body)))

(defmacro with-clauses ((&rest pattern) list &body expansion)
  "Generate a list of clauses to be spliced into a macro expansion by
  looping over a list of input clauses, destructuring, and expanding."
  (once-only (list)
    (with-gensyms (item)
    `(loop for ,item in ,list collect
	  (destructuring-bind ,pattern ,item
	    ,@expansion)))))



