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
;; (postorder-acc tree acc) = acc if tree is empty, else
;;   the postorder of the left subtree, then the postorder of the
;;   right subtree, then the value, then acc
(define (postorder-acc tree acc)
  (if (null? tree)
      acc
      (postorder-acc (cadr tree)
                     (postorder-acc (caddr tree)
                                    (cons (car tree) acc)))))    
;; (print-all-traversals tree) = print the inorder line, then the preorder
;;   line, then the postorder line, each ending with a newline
(define (print-all-traversals tree)
  (begin
    (print-inorder tree)
    (display (preorder-acc tree '()))
    (newline)
    (display (postorder-acc tree '()))
    (newline)))                                                                              
;; (my-max a b) = a if a > b, else b
(define (my-max a b)
  (if (> a b) a b))

;; (tree-height tree) = 0 if tree is empty, else
;;   1 + the larger of the heights of its left and right subtrees
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (my-max (tree-height (cadr tree))
                   (tree-height (caddr tree))))))    
;; (leaf-count tree) = 0 if tree is empty, 1 if both subtrees are empty,
;;   else (leaf-count left) + (leaf-count right)
(define (leaf-count tree)
  (cond ((null? tree) 0)
        ((and (null? (cadr tree)) (null? (caddr tree))) 1)
        (else (+ (leaf-count (cadr tree))
                 (leaf-count (caddr tree))))))
;; (print-height-and-leaves tree) = display the list (height leaf-count)
;;   of tree, then a newline
(define (print-height-and-leaves tree)
  (begin
    (display (list (tree-height tree) (leaf-count tree)))
    (newline)))                                  