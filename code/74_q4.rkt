#lang racket/base

;; (my-length lst) = the number of top-level elements of lst
(define (my-length lst)
  ;; (loop remaining acc) = acc if remaining is empty,
  ;;   else (loop (cdr remaining) (+ acc 1))
  (let loop ((remaining lst) (acc 0))
    (if (null? remaining)
        acc
        (loop (cdr remaining) (+ acc 1)))))
;; (my-map f lst) = () if lst is empty,
;;   else (cons (f (car lst)) (my-map f (cdr lst)))
(define (my-map f lst)
  (if (null? lst)
      '()
      (cons (f (car lst))
            (my-map f (cdr lst))))) 
;; (make-inserter x len-ok?) =  a function that conses x onto every list, at every level, whose original length passes len-ok?
(define (make-inserter x len-ok?)
  (letrec ((insert
            ;; (insert lst) = process the elements of lst, then cons x on the
            ;;   front if (len-ok? (my-length lst)) holds
            (lambda (lst)
              (let ((processed
                     (my-map (lambda (e)
                               (if (or (pair? e) (null? e))
                                   (insert e)
                                   e))
                             lst)))
                (if (len-ok? (my-length lst))
                    (cons x processed)
                    processed)))))
    insert))

;; (insert-if-short x lst n) = insert x into every list shorter than n
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))

;; (print-insert-result) = read x, then lst, then n from standard input,
;;   display (insert-if-short x lst n), then a newline
(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))
                