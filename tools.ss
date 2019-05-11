;; -*- Gerbil -*-
;;;; set of tools for lists

(export #t)

(defalias aλ alambda)

;; anaphoric lambda
;; factorial example: (map (alambda (n) (if (= n 1) 1 (* n (self (1- n))))) [1 2 3 4 5])
(defsyntax (alambda stx)
  (syntax-case stx ()
   ((macro args body)
    (with-syntax ((self-id (datum->syntax #'macro 'self)))
      #'(lambda (x) (letrec (self-id (lambda args body)) (self-id x)))))))

;; anaphopic if
(defsyntax (aif stx)
  (syntax-case stx ()
    ((macro case then else)
     (with-syntax ((it-id (datum->syntax #'macro 'it)))
       #'(let (it-id case) (if it-id then else))))
    ((macro case then)
     (with-syntax ((it-id (datum->syntax #'macro 'it)))
       #'(let (it-id case) (if it-id then))))))

;; nest macro
(defrules nest ()
  ((_ single)
   single)
  ((recur ... (outer ...) inner)
   (recur ... (outer ... inner))))

