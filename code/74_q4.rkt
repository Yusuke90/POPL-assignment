#lang racket/base

;; (my-length lst) = the number of top-level elements of lst
(define (my-length lst)
  ;; (loop remaining acc) = acc if remaining is empty,
  ;;   else (loop (cdr remaining) (+ acc 1))
  (let loop ((remaining lst) (acc 0))
    (if (null? remaining)
        acc
        (loop (cdr remaining) (+ acc 1)))))