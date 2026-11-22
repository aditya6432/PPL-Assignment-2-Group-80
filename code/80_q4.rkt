#lang racket/base

;; S2: insert x at the front of every list shorter than n, at every level.
;; Only the built-ins allowed by the assignment (plus read) are used.

;; (my-length lst) is the number of top-level elements of lst. The named let
;; counts elements into an accumulator: () gives the count so far,
;; otherwise count the rest with count + 1 (a tail call).
(define (my-length lst)
  (let loop ((items lst) (count 0))
    (if (null? items)
        count
        (loop (cdr items) (+ count 1)))))

;; (my-reverse lst) is lst in reverse order, built by moving each element onto
;; an accumulator (tail-recursive).
(define (my-reverse lst)
  (let loop ((items lst) (result '()))
    (if (null? items)
        result
        (loop (cdr items) (cons (car items) result)))))

;; (my-map f lst) is the list of (f e) for each element e of lst, in order.
;; Results are collected in reverse on an accumulator (tail-recursive), then
;; reversed once, so long lists take linear time.
(define (my-map f lst)
  (let loop ((items lst) (result '()))
    (if (null? items)
        (my-reverse result)
        (loop (cdr items) (cons (f (car items)) result)))))

;; (make-inserter x len-ok?) returns a function visit. (visit lst) processes
;; every element (sublists, including (), are visited recursively; atoms are
;; kept), and then puts x in front if len-ok? holds for the length of the
;; original lst, measured before any insertion.
(define (make-inserter x len-ok?)
  (letrec ((visit
            (lambda (lst)
              (let* ((original-length (my-length lst))
                     (updated-elements
                       (my-map
                         (lambda (item)
                           (if (or (pair? item) (null? item))
                               (visit item)
                               item))
                         lst)))
                (if (len-ok? original-length)
                    (cons x updated-elements)
                    updated-elements)))))
    visit))

;; (insert-if-short x lst n) inserts x into every list whose length is < n.
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (count) (< count n))) lst))

;; (print-insert-result) reads x, lst and n from standard input, in that
;; order, and displays the result followed by a newline.
(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))
