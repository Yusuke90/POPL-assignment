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
;; (print-inorder tree) = display the inorder list of tree, then a newline
(define (print-inorder tree)
  (begin
    (display (inorder-acc tree '()))
    (newline)))    
;; (preorder-acc tree acc) = acc if tree is empty, else
;;   the value, then the preorder of the left subtree,
;;   then (the preorder of the right subtree, then acc)
(define (preorder-acc tree acc)
  (if (null? tree)
      acc
      (cons (car tree)
            (preorder-acc (cadr tree)
                          (preorder-acc (caddr tree) acc)))))                         