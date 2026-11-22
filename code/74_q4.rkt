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
;; (insert-if-short x lst n) = lst with every nested list processed first,
;;   then x consed on the front if the ORIGINAL length of lst is < n
(define (insert-if-short x lst n)
  (let ((processed
         ;; each element: a list (or ()) is processed recursively, an atom stays
         (my-map (lambda (e)
                   (if (or (pair? e) (null? e))
                       (insert-if-short x e n)
                       e))
                 lst)))
    (if (< (my-length lst) n)
        (cons x processed)
        processed)))                   