;;
;; Copyright (c) 2005, Gigamonkeys Consulting All rights reserved.
;;

(in-package :com.gigamonkeys.macro-utilities)

;;; Exported

(defun gensyms (names)
  (mapcar (lambda (x) (gensym (string x))) names))

(defmacro mapticks (form &rest lists)
  `(mapcar (lambda (,@lists) ,form) ,@lists))

(defmacro with-gensyms ((&rest n) &body body)
  `(let ,(mapticks `(,n (gensym ,(string n))) n) ,@body))

(defmacro once-only ((&rest n) &body body &aux (g (gensyms n)))
  ``(let (,,@(mapticks ``(,',g ,,n) g n))
      ,(let (,@(mapticks `(,n ',g) n g)) ,@body)))

(defun spliceable (value)
  (if value (list value) nil))

(defun gensyms (names)
  (mapcar (lambda (x) (gensym (string x))) names))

;;; Unexported -- basically experimental.

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



