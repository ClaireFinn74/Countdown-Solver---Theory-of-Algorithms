#lang racket

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
'numsAndOps numsAndOps