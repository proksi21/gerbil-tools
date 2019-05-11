;; -*- Gerbil -*-
;;;; set of tools for lists

(export #t)

(defalias aλ alambda)

(defsyntax (alambda stx)
  (syntax-case stx ()
   ((macro args body)
    (with-syntax ((self-id (datum->syntax #'macro 'self)))
      #'(lambda (x) (letrec (self-id (lambda args body)) (self-id x)))))))

(defsyntax (aif stx)
  (syntax-case stx ()
    ((macro case then else)
     (with-syntax ((it-id (datum->syntax #'macro 'it)))
       #'(let (it-id case) (if it-id then else))))))

(defrules nest ()
  ((_ single)
   single)
  ((recur ... (outer ...) inner)
   (recur ... (outer ... inner))))

