#lang racket/base

(define (my-append a b)
  (if (null? a)
      b
      (cons (car a) (my-append (cdr a) b))))

;; (inorder-acc tree acc) is the inorder list of tree followed by acc.
;; Empty tree: just acc. Node: the inorder list of the left subtree, followed
;; by the node's value, followed by the inorder list of the right subtree and
;; then acc. The call on the left subtree is a tail call.
(define (inorder-acc tree acc)
  (if (null? tree)
      acc
      (inorder-acc (cadr tree)
                   (cons (car tree) (inorder-acc (caddr tree) acc)))))

;; (inorder tree) is the list of values in inorder: left, node, right.
(define (inorder tree)
  (inorder-acc tree '()))

;; (preorder-acc tree acc) is the preorder list of tree followed by acc.
;; Empty tree: just acc. Node: the node's value, followed by the preorder list
;; of the left subtree, followed by the preorder list of the right subtree and
;; then acc.
(define (preorder-acc tree acc)
  (if (null? tree)
      acc
      (cons (car tree)
            (preorder-acc (cadr tree) (preorder-acc (caddr tree) acc)))))

;; (preorder tree) is the list of values in preorder: node, left, right.
(define (preorder tree)
  (preorder-acc tree '()))

;; (postorder-acc tree acc) is the postorder list of tree followed by acc.
;; Empty tree: just acc. Node: the postorder list of the left subtree,
;; followed by the postorder list of the right subtree, followed by the node's
;; value and then acc. The call on the left subtree is a tail call.
(define (postorder-acc tree acc)
  (if (null? tree)
      acc
      (postorder-acc (cadr tree)
                     (postorder-acc (caddr tree) (cons (car tree) acc)))))

;; (postorder tree) is the list of values in postorder: left, right, node.
(define (postorder tree)
  (postorder-acc tree '()))

(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (max (tree-height (cadr tree))
                (tree-height (caddr tree))))))

(define (leaf-count tree)
  (cond
    ((null? tree) 0)
    ((and (null? (cadr tree)) (null? (caddr tree))) 1)
    (else (+ (leaf-count (cadr tree))
             (leaf-count (caddr tree))))))

(define (print-inorder tree)
  (begin
    (display (inorder tree))
    (newline)))

(define (print-all-traversals tree)
  (begin
    (display (inorder tree))
    (newline)
    (display (preorder tree))
    (newline)
    (display (postorder tree))
    (newline)))

(define (print-height-and-leaves tree)
  (begin
    (display (list (tree-height tree) (leaf-count tree)))
    (newline)))
