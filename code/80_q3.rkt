#lang racket/base

;; S1: binary tree traversals. A tree is () or a list (value left right).
;; Only the built-ins allowed by the assignment are used, and all state is
;; passed through function arguments.

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

;; (tree-height tree) is 0 for the empty tree, and for a node 1 plus the
;; larger of the heights of its two subtrees (so a single node has height 1).
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (max (tree-height (cadr tree))
                (tree-height (caddr tree))))))

;; (leaf-count-acc tree acc) is acc plus the number of leaves in tree.
;; Empty tree: acc (no leaves). Leaf (both subtrees empty): acc + 1.
;; Other node: count the right subtree into acc, then the left subtree
;; (a tail call).
(define (leaf-count-acc tree acc)
  (cond
    ((null? tree) acc)
    ((and (null? (cadr tree)) (null? (caddr tree))) (+ acc 1))
    (else (leaf-count-acc (cadr tree)
                          (leaf-count-acc (caddr tree) acc)))))

;; (leaf-count tree) is the number of leaves of tree.
(define (leaf-count tree)
  (leaf-count-acc tree 0))

;; Prints the inorder list of tree on one line.
(define (print-inorder tree)
  (begin
    (display (inorder tree))
    (newline)))

;; Prints the inorder, preorder and postorder lists of tree, one per line.
(define (print-all-traversals tree)
  (begin
    (display (inorder tree))
    (newline)
    (display (preorder tree))
    (newline)
    (display (postorder tree))
    (newline)))

;; Prints the list (height leaf-count) of tree on one line.
(define (print-height-and-leaves tree)
  (begin
    (display (list (tree-height tree) (leaf-count tree)))
    (newline)))
