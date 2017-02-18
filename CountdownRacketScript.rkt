#lang racket
; I will start by defining my lists for countdown:
; My Random list of numbers and my Target Number between the numbers 100-199 inclusive.
;The name of m yRandom list is RandomList.
; 6 of those numbers inside the list will be used to sum to a Target Number using the basic operands +. -, *, /
;Defining a list can be done as follows:

(define RandomList (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))

;This will be my Target number between 101 and 999 generated randomly
(random 101 999)