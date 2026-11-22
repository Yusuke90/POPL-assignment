;; builds the list (1 2 ... n) for the big test, using only allowed built-ins
(define (build n acc)
  (if (= n 0) acc (build (- n 1) (cons n acc))))

(display (my-length '())) (newline)
(display (my-length '(1))) (newline)
(display (my-length '(1 2 3))) (newline)
(display (my-length '((1 2) (3 4 5) (6) ()))) (newline)
(display (my-length (build 10000 '()))) (newline)
(display (my-map (lambda (x) (+ x 1)) '(1 2 3))) (newline)
(display (my-map (lambda (x) (+ x 1)) '())) (newline)
(display (my-map (lambda (x) (* x x)) '(1 2 3 4))) (newline)
(display (my-map my-length '((1 2) (3 4 5) (6) ()))) (newline)
(display (my-length (my-map (lambda (x) (+ x 1)) (build 10000 '())))) (newline)
(display (car (my-map (lambda (x) (+ x 1)) (build 10000 '())))) (newline)
;; wraps '() in d levels of lists
(define (nest d acc)
  (if (= d 0) acc (nest (- d 1) (list acc))))

;; counts how many levels in a (z (z (z ...))) chain start with z
(define (count-z t)
  (cond ((not (pair? t)) 0)
        ((eq? (car t) 'z) (+ 1 (if (null? (cdr t)) 0 (count-z (cadr t)))))
        (else 0)))

;; PDF examples
(display (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3)) (newline)
(display (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3)) (newline)
(display (insert-if-short 7 '() 3)) (newline)
(display (insert-if-short 7 '() 0)) (newline)
;; extras
(display (insert-if-short 'z '(a b c) 4)) (newline)
(display (insert-if-short 'z '(a b c) 3)) (newline)
(display (insert-if-short 'z '((a) ((b))) 2)) (newline)
;; depth 100 and 10,000 elements
(display (count-z (insert-if-short 'z (nest 100 '()) 2))) (newline)
(display (my-length (insert-if-short 'z (build 10000 '()) 10001))) (newline)
(display (my-length (insert-if-short 'z (build 10000 '()) 10000))) (newline)
(display ((make-inserter 'z (lambda (len) (= len 2))) '((a b) (c) (d e (f g))))) (newline)
(display ((make-inserter 0 (lambda (len) (>= len 0))) '(1 (2)))) (newline)
(display ((make-inserter 'e (lambda (len) (= len 0))) '(1 () (2 ())))) (newline)
(display ((make-inserter 'z (lambda (len) (< len 0))) '(1 ()))) (newline)