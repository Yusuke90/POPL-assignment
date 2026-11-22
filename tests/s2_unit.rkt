;; builds the list (1 2 ... n) for the big test, using only allowed built-ins
(define (build n acc)
  (if (= n 0) acc (build (- n 1) (cons n acc))))

(display (my-length '())) (newline)
(display (my-length '(1))) (newline)
(display (my-length '(1 2 3))) (newline)
(display (my-length '((1 2) (3 4 5) (6) ()))) (newline)
(display (my-length (build 10000 '()))) (newline)