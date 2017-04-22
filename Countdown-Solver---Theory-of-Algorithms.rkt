#lang br/quicklang

;defining 'read-syntax' with a path and a port so I can read in my 'reader' script
;which will allow the user to input values according to the functions I set out in this script.
;A reader, con­verts source code from a string of char­ac­ters into paren­the­sized expres­sions.
(define (read-syntax path port)
;defining port as a string to read in
  (define args (port->lines port))
;defining 'handle-datums' formatted to 'handle' ~a, the next arguments passed to 'handle-datums' 
  (define handle-datums (format-datums '(handle ~a) args))
;defining a 'module', which allows me to make my file an 'expander'.
;An expander, deter­mines how these expres­sions cor­re­spond to real Racket expres­sions, which are then eval­u­ated to pro­duce a result.
;First, why is it called an expander?
;Our reader con­sisted of a read-syntax func­tion that sur­rounded each line of the source file with (handle ...), in essence “expand­ing” it.
;The expander will per­form a sim­i­lar process on the rest of the code, with the help of 'macros'/functions.

;  ---- ADAPTED FROM: http://beautifulracket.com/stacker/the-expander.html ----
  
  (define module-datum `(module stacker-mod "Countdown-Solver----Theory-of-Algorithms.rkt"
                          ,@handle-datums))
  (datum->syntax #f module-datum))

;This allow the reader to read this expander
(provide read-syntax)

;defining a macro/function to 'begin' our module. All modules have to have a 'module-begin'
(define-macro (stacker-module-begin HANDLE-EXPR ...)
  #'(#%module-begin
     HANDLE-EXPR ...
;display the first element on the stack
     (display (first stack))))
;provide this module even if file renamed
(provide (rename-out [stacker-module-begin #%module-begin]))

#| I will start by defining my lists for countdown:
     #| My Random list of numbers and my Target Number between the numbers 100-199 inclusive.
     The name of my Random list is RandomList. |#
   6 of those numbers inside the list will be used to sum to a Target Number using the basic operands +. -, *, / |#

#| I have added randomisation of numbers within the list using the random function.
   However, I can only get one number generated from the list at a time so I may need to copy this function 5 more times to get the remaining numbers. |#
     #| list-ref allows me to reference the list at a given index.
     I have used (random 24) as my list has 24 numbers in it and I want to generate a random number using all 24 charactrs.
     If I wanted to use less numbers in the list and randomise them I would reduce this number. |#

(define RandomListFirstNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))
(define RandomListSecondNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))
(define RandomListThirdNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))
(define RandomListFourthNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))
(define RandomListFifthNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))
(define RandomListSixthNumber (list-ref(list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100) (random 24)))

'RandomListFirstNumber: RandomListFirstNumber
'RandomListSecondNumber: RandomListSecondNumber
'RandomListThirdNumber: RandomListThirdNumber
'RandomListFourthNumber: RandomListFourthNumber
'RandomListFifthNumber: RandomListFifthNumber
'RandomListSixthNumber: RandomListSixthNumber

; This will be my Target number between 101 and 999 generated randomly
(define TargetNumber (random 101 999))

; Calling my TargetNumber and naming it with a comment
 'TargetNumber: TargetNumber

#| I'm defining a simple function called Sum bound to RandomSixAdd to add the result of all of the Random Six numbers together.
 Checking for nulls in the first part of the if statement and if not null then add the car of the list to the cdr of the list recursively.
|#
(define(sum RandomSixAdd)
(if(null? RandomSixAdd)
   0
   (+ (car RandomSixAdd) (sum(cdr RandomSixAdd)))))

#| The function sum is now defined to recurse through a list up above and the RandomListFirstNumber...RandomListSixthNumber lists
   already pick out a random number each to display to the output window.
   Now I just have to sum the 6 random numbers together using the mechanism defined as sum. I do that below beside the comment 'AddRandomSix:
|#


'AddRandomSix: (define sumPrint (sum(list RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber)))

;Print out the result of the summation
sumPrint

; I now do the same for multiply. Note that I now use 1 instead of 0 as you cannot multiply by 0.
(define(mult RandomSixMultiply)
(if(null? RandomSixMultiply)
   1
   (* (car RandomSixMultiply) (mult(cdr RandomSixMultiply)))))

'MultiplyRandomSix: (define multPrint(mult(list RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber)))

;Print out the result of the multilication
multPrint

#| I'm now doing the same for subtract, although, this output will now start to produce negative numbers which I don't want.
   I think I have a mechanism for dealing with negative numbers below, by printing an error message if negative.
|#

(define(subt RandomSixSubtract)
(if(null? RandomSixSubtract)
   0
   (- (car RandomSixSubtract) (subt(cdr RandomSixSubtract)))))

#| I define a function called subtneg which prints true(#t) or false (#f) if the result of subt is negative.
   Now seeing #t or #f wouldn't really make much sense to a user so I chose not to use this function, instead I use the function below called subtPrint.
   Keeping subtneg incase I do need it at some stage though.
|#

(define subtneg(negative? (subt(list RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber))))


#| Using a function defined as subtPrint is where I deal with negative numbers. subtPrint is just doing the same thing as the subtraction
   of the six random numbers recursively would do but the key thing is that I'm giving this function itself a name, which I didn't do
   previously with  sum and mult. Naming the function allows me to use it later on to deal with negative numbers. 
|#
 (define subtPrint(subt(list RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber)))

;Print out the result of the subtraction
'SubtractRandomSix: subtPrint

#|  Now, using subtPrint defined previously, I check if subtPrint is less than (<) 0, print the result.
    Else, Print a message saying "Negative Numbers are not allowed!"
|#

         (define subtPrintHandler(if(< 0 subtPrint)
             subtPrint
             "Negative Numbers not allowed!"))


;Print out the result of the subtraction handler for negative numbers
'subtPrintHandler: subtPrintHandler

; Now onto divide, which will also start causing problems as it produces fractions and I want whole numbers to be output.
(define(div RandomSixDivide)
(if(null? RandomSixDivide)
   1
   (/ (car RandomSixDivide) (div(cdr RandomSixDivide)))))

;To deal with fractions I use the 'round' function to round the fraction up to the nearest whole number which will be 0 lots of the time.
'DivideRandomSix: (define divPrint (div(list(round(/ RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber)))))

;This prints out the division to the output
divPrint

#| Now that I have the six random numbers and the target number set up, sum,mult,subt,div functions and a way to deal with fractions while dividing and
   negative numbers while subtracting, I need to get to the most important part: Getting all possible permutations of the list (1-10, 25, 50, 75, 100)
   against the target number (101-999) so that I can apply the sum/mult/div/subt functions to try to reach the target number. (if possible)|#


#| First I'll set up the CartesianProduct of the Random Six Numbers lists and the operands + / * -.
   This allows me to take every element of the first list, and pair it with all the possible combinations from the second list that can be done.
   To do this I will have to take the random six number lists and put them into a list (RandomSixAll) so I can then
   sum,multiply,divide or subtract as necessary whenever 6 random numbers are generated.
|#

;Putting the six random numbers into a list
(define RandomSixAll (list RandomListFirstNumber RandomListSecondNumber RandomListThirdNumber RandomListFourthNumber RandomListFifthNumber RandomListSixthNumber))
;Now I'm defining a list of operands to use:
(define operandsList(list '+ '- '/ '*))

;Printing RandomSixAll
'RandomSixAll RandomSixAll
;Printing the operandsList
'operandsList: operandsList

;Now I can try to find the cartesian-product (as described above) of my 5 operands.
;I am using 5 operands as the Random Six Numbers will need to have an operand between them at all times.
(define operandsForSixNumbers (cartesian-product operandsList operandsList operandsList operandsList operandsList))

;Printing operandsForSixNumbers
;'operandsForSixNumbers operandsForSixNumbers

;Now I'm getting all of the permutations of my random six numbers list
(define rsaPerm(remove-duplicates(permutations RandomSixAll)))

;Now I'm putting the operators and numbers together, removing duplicates for optimization
(define numsAndOps(remove-duplicates (cartesian-product  rsaPerm  operandsForSixNumbers)))

;printing out he numbers and operators
;'numsAndOps numsAndOps

;Now I'm going to be working with a 'stack' to be able to'push' elements onto the stack, and 'pop' them off.
;First, I will start with the empty list:
(define stack empty)

;Now I will define my pop-stack function for popping elements off my stack
(define (pop-stack!)
;Now I will define 'arg', as the 'first' element in the stack/the car of the stack
  (define arg (first stack))
;I'm now 'set'ting the stack as the 'rest' of the stack/car of the stack, without the first element/car
  (set! stack (rest stack))
  arg)

;Now I'm defining my 'push' function to 'push elements onto the stack
(define (push-stack! arg)
;Now I set the stack to 'cons' or 'push' an element onto the stack
  (set! stack (cons arg stack)))

;Now I define my handle function which inspects each instruc­tion and decides what to do
(define (handle [arg #f])
 ;Now we write our condition for the stack:
  (cond
;number? means is the argument, within the reader script that is being passed, a number?
;If the argument IS, in fact, a number then push this argument onto the stack.
    [(number? arg) (push-stack! arg)]
;Or, is the argument being passed within the reader equal to a * + / or - operand?
    [(or (equal? * arg) (equal? + arg) (equal? / arg) (equal? - arg))
;define 'op-result', whereby, two arguments already on the stack ar popped off and evaluated with the operand passed
     (define op-result (arg (pop-stack!) (pop-stack!)))
;push the result of the evaluation of the two elements popped off with the operand onto the stack
     (push-stack! op-result)]))

;make the 'handle' function available ti the 'reader' script
(provide handle)

;Also, make the opeands available to the reader script
(provide + * / -)

