#lang racket/base

(define (my-length lst)
  (let loop ((items lst) (count 0))
    (if (null? items)
        count
        (loop (cdr items) (+ count 1)))))

(define (my-reverse lst)
  (let loop ((items lst) (result '()))
    (if (null? items)
        result
        (loop (cdr items) (cons (car items) result)))))

(define (my-map f lst)
  (let loop ((items lst) (result '()))
    (if (null? items)
        (my-reverse result)
        (loop (cdr items) (cons (f (car items)) result)))))

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

(define (insert-if-short x lst n)
  ((make-inserter x (lambda (count) (< count n))) lst))

(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))
