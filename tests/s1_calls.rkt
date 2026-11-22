;; ---- trees from the PDF ----
(define t1 '(4 (2 (1 () ()) (3 () ()))
               (6 (5 () ()) (7 () ()))))
(define t2 '(1 () (2 () (3 () ()))))   ; right-leaning chain
(define t3 '(a (b () ()) (c () ())))   ; symbol values

;; ---- extra edge cases (ours) ----
(define t4 '(5 () ()))                 ; single node
(define t5 '(3 (2 (1 () ()) ()) ()))   ; left-leaning chain
(define t6 '(x (1 () ())               ; mixed numbers and symbols,
               (2 (y () ()) ())))      ; node 2 has only a left child

;; ---- print-inorder: 7 lines ----
(print-inorder t1)
(print-inorder t2)
(print-inorder t3)
(print-inorder '())
(print-inorder t4)
(print-inorder t5)
(print-inorder t6)

;; ---- print-all-traversals: 7 trees x 3 lines ----
(print-all-traversals t1)
(print-all-traversals t2)
(print-all-traversals t3)
(print-all-traversals '())
(print-all-traversals t4)
(print-all-traversals t5)
(print-all-traversals t6)

;; ---- print-height-and-leaves: 7 lines ----
(print-height-and-leaves t1)
(print-height-and-leaves t2)
(print-height-and-leaves t3)
(print-height-and-leaves '())
(print-height-and-leaves t4)
(print-height-and-leaves t5)
(print-height-and-leaves t6)