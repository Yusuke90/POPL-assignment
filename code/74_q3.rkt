#lang racket/base

;; (inorder-acc tree acc) = acc if tree is empty, else
;;   the inorder of the left subtree, then the value,
;;   then (the inorder of the right subtree, then acc)
(define (inorder-acc tree acc)
  (if (null? tree)
      acc
      (inorder-acc (cadr tree)
                   (cons (car tree)
                         (inorder-acc (caddr tree) acc)))))