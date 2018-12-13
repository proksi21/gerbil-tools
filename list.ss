;; -*- Gerbil -*-
;;;; set of tools for lists

(import :std/iter)

(export #t)

(def (build-list n proc)
  (let ((result []))
    (for ((i (in-range n)))
      (set! result (cons (proc i) result)))
    (reverse result)))

(def (list* . args)
  (let ((result []))
    (for (i (in-range (length args)))
      (if (list? (list-ref args i))
	(set! result (append result (list-ref args i)))
	(set! result (append result [(list-ref args i)]))))
    result))

(def (empty? lst)
  (and (list? lst) (equal? (length lst) 0)))

(def (last lst)
  (list-ref lst (1- (length lst))))

(def (take lst pos)
  (reverse (list-tail (reverse lst) (- (length lst) pos))))

(def (split-at lst pos)
  (values (take lst pos) (list-tail lst pos)))

(defsyntax (nest stx)
  (def nest-list (cdr (syntax->datum stx)))
  (foldl (lambda (x y) (reverse (cons y (reverse x))))
	 (car (reverse nest-list))
	 (cdr (reverse nest-list))))