#!/usr/bin/env sh
#|
exec racket -u "$0" $@
|#
#lang racket

;; Parameters are racket optimized dynamic binding.
(define filename (make-parameter "testfile"))

;; Accept -f <file> optionally on cmd line optionally.
(define file-form
  (command-line
   #:once-any
   [("-f") f "Filename" (filename f)]))

;; Racket Stdlib does not do "1" -> 1 (converts to ascii)
(define (char->number c)
  (- (char->integer c) (char->integer #\0)))

(define (stringify f)
  (file->string f))

;; Split file on newlines, get numeric elements as a list
(define (get-digits s)
  (let ((l (string-split s "\n")))
    (map (lambda (line)
           (filter char-numeric?
                   (string->list line))) l)))

;; Get only the first and last element of each line and
;; combine into number
(define (get-numbers digit-cell)
  (string->number (list->string
                   (list (first digit-cell) (last digit-cell)))))

(define (solve nums)
  (foldl + 0 nums))

;; Get a list of digits per line
(define digits (get-digits (stringify (filename))))

;; Convert into desired number.
(define numbers
  (map get-numbers digits))

;; Output the answer.
(display (solve numbers))
