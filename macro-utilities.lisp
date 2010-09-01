(in-package :com.gigamonkeys.macro-utilities)

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

