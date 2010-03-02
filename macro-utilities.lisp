;;
;; Copyright (c) 2005, Gigamonkeys Consulting All rights reserved.
;;

(in-package :com.gigamonkeys.macro-utilities)

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (make-symbol ,(string n))))
     ,@body))

(defmacro with-multiple-gensyms ((&rest names) value-producing-form &body body)
  `(with-gensyms (,@names)
     (multiple-value-bind (,@names) ,value-producing-form
       ,@body)))

(defmacro once-only ((&rest names) &body body)
  (let ((gensyms (loop for n in names collect (gensym (string n)))))
    `(let (,@(loop for g in gensyms collect `(,g (gensym))))
      `(let (,,@(loop for g in gensyms for n in names collect ``(,,g ,,n)))
        ,(let (,@(loop for n in names for g in gensyms collect `(,n ,g)))
           ,@body)))))

(defmacro with-clauses ((&rest pattern) list &body expansion)
  "Generate a list of clauses to be spliced into a macro expansion by
  looping over a list of input clauses, destructuring, and expanding."
  (once-only (list)
    (with-gensyms (item)
    `(loop for ,item in ,list collect
	  (destructuring-bind ,pattern ,item
	    ,@expansion)))))

(defun spliceable (value)
  (if value (list value) nil))

(defmacro ppme (form &environment env)
  (progn
    (write (macroexpand-1 form env)
           :length nil
           :level nil
           :circle nil
           :pretty t
           :gensym nil
           :right-margin 83
           :case :downcase)
    nil))

