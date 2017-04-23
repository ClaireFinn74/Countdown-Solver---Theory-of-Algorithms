# Countdown-Solver---Theory-of-Algorithms

__  ** DISCLAIMER: SKIP TO THE VERY BOTTOM IF YOU JUST WANT TO KNOW HOW TO RUN MY SCRIPTS BUT IT IS ADVISED TO READ THIS README AS IT EXPLAINS THE PROCESS/MY WAY OF THINKING **  __

## Description
1. Project undertaken during my *BSC (Hons) in Computing in Software Development* degree at GMIT for a **Theory of Algorithms** class.
2. The language used is **Scheme/Racket.**
3. An attempt to **solve Countdown**, the game show.

## Rules:
* A set of numbers are displayed:
* The numbers from **1-10 twice,** (for example 1, 1, 2, 2, 3, 3 etc up to 10) **25, 50, 75 and 100.**
* The user will then be presented with a **random number within the range 101-999.** Let's say for example the number turned out to be 436.
* The user will then have to use the above numbers **(1, 1, 2, 2, 3,3, 4, 4, 5,5, 6, 6, 7. 7, 8, 8, 9, 9, 10, 10, 25, 50, 75, 100)** to add up to the random number, in this case 436.
* The number, in the gameshow, doesn't have to exactly match the random number (436), it can be as close to it, above or below, as possible.
* In this case though, **an error message will be displayed** if its *impossible* to exactly add up to the random number, therefore making it easier to solve Countdown.


# Eventual Conclusion:
This project was challenging. I started out writing six random lists so that I could output six random numbers. I then defined my Target Number between 1 and 999. I started out optimistic, using recursion to recurse through my lists using the operands _+ / * and -._ This worked out fine, printing the _sum, multiplication, division and subtracion_ to the REPL. I then thought that I would be able to make a list of operands and apply those operands to these functions by _permutating through the list_ of random 6 numbers.

Unfortunately, the only output I was getting was the numbers themselves and the operands all displaying in different orders as permutation usually implies but there was no evaluation of the numbers with the operands. I could have used the _/ * + and - functions_ and applied those to the permutation of the list but this would result in me having to define exactly what to do at each stage of the permutation resulting ina long and complicated function.

I couldn't find a way to apply the math functions to the lists through permutation but I did think there had to be a faster way to do this. I then figured, what if I tested out the __Reader/Expander__ way of doing things and worked with a __'stack'__? Surely then I could just __pop__ and __push__ things to that stack within a function?


## Reader/Expander Explanation (Upon Research):
Within the __'Beautiful Racket'__ link I studied below in the __'References'__, there was talk about the idea of a __'Reader'__ script and an __'Expander' script.__ I had to __download__ Beautiful Racket in my __cmd__ window and once that was done I could use the 
_#lang br/quicklang._

__[For information on how to download Beautiful Racket, refer to my references below for a link.]__

The __'Reader'__, accourding to research, _'converts the source code of our language from a string of characters into Racket-style parenthesized forms, also known as S-expressions.'_ These 'S-Expressions' are treated as functions.
To create my own __Reader__ I created a 'stacker' file (As it's referred to in the __Beautiful Racket Link__), which acted as my __Reader__ and takes one instruction per line.

The Expander, _'Determines how these parenthesized forms correspond to real Racket expressions (and which are then evaluated to produce a result)'._ The Racket Script I was already working with acted as my __'Expander'__ when I changed the _#lang_ to the one mentioned above: _#lang br/quicklang._

With the __Reader__, we’re _'putting our program into the proper form'_ With our __Expander,__ we can _'give meaning to these forms'_.
I found that the __'Reader'__ and the __'Expander'__ literally _'co-exist',_ working together in _unison_ to produce results.

All I have to do is define the functions I want to use within my origional Racket Script, the __'Expander',__ and then I can use my __'Reader' script__ to produce _output_ that can actually be _evaluated._

Usually what happens in Racket is that Racket _passes the source code to the reader_ for the _language you specify_ at the top of your script. It does this by using __read-syntax,__ a function. Racket passes __two__ arguments to read-syntax: the __path__ to the source file, and a __port__ for reading data from the file. You specify these in your _Expander._

To make something you defined in your __Expander__ _public_ so the __Reader__ can see it, you use _'provide'_. To specify what script will act as your __'Expander'__ you create a __'Module'__ within the script you want to use as your __'Expander__ and point your _'path'_ to your script.

To convert that _'Module'_ code into a _'Syntax Object'_ to be read, we are essentially _'treating code as data'_. We can use a _Syntax Object'_ to __store source code__ so it can be __evaluated.__ First, we turn the expression into a _'datum'_, which is the raw code in the source, we use the quote/' symbol to acheive this. A _'datum'_ is like converting to a string, but it _'preserves the list structure of the expression.'_ We convert the _'Datum'_ into a _'Syntax Object.'_ using: 

`` datum->syntax ``

A _'syntax object'_ is a 'Datum' with it's _'context within a program.'_


# Eventual Conclusion (Continued):
So, having seen what __Reader__ and __Expander__ could do for me, I went about applying the _'stack'_ function talked about both in class dring _Theory of Algorithms_ and in the _Beautiful Racket link_ given to me as part of the module.


## Describing the Stack Function: (Adapted from Beautiful Racket):

1. With the stack, I could first create a stack that started out as the empty list:

`` (define stack empty) ``

2. I then defined my pop-stack function for popping elements off my stack:

``(define (pop-stack!)``

3. Then I defined 'arg', as the 'first' element in the stack/the car of the stack

  ``(define arg (first stack))``
  

`` (set! stack (rest stack))
  arg)``

5. I went on to define my 'push' function to 'push elements onto the stack:

``(define (push-stack! arg)

6. I set the stack to 'cons' or 'push' an element onto the stack

  ``(set! stack (cons arg stack)))``

7. I defined my handle function which inspects each instruc­tion and decides what to do

`(define (handle [arg #f])`

8. Now we write our condition for the stack:

  ;number? means is the argument, within the reader script that is being passed, a number?
  ;If the argument IS, in fact, a number then push this argument onto the stack.
  ;Or, is the argument being passed within the reader equal to a * + / or - operand?
  ;define 'op-result', whereby, two arguments already on the stack are popped off and evaluated with the operand passed
  ;push the result of the evaluation of the two elements popped off with the operand onto the stack.

`
(cond 

 [(number? arg) (push-stack! arg)]
 
[(or (equal? * arg) (equal? + arg) (equal? / arg) (equal? - arg))

(define op-result (arg (pop-stack!) (pop-stack!)))

(push-stack! op-result)

(equal? stack TargetNumber)])) `

9. Then all I had to do was make the functions I wanted to use within my reader (My random six numbers, my operands, the Handler funcion and my Target Number) public:

 ;make the 'handle' function available to the 'reader' script
 
 ;Also, make the operands available to the reader script
 
 ;Make my random 6 numbers available to the reader


(provide handle)

(provide TargetNumber)

(provide + * / -)

(provide RandomListFirstNumber)

(provide RandomListSecondNumber)

(provide RandomListThirdNumber)

(provide RandomListFourthNumber)

(provide RandomListFifthNumber)

(provide RandomListSixthNumber)


10. I also did a little check above to see is the number that the user enters in, evaluated with the operands, equal to the Target Number:

` (equal? stack TargetNumber ``




# How the user should go about playing the game:

Although this project was supposed to actually 'solve' the Countdown Numbers Game, I ended up actually making the user _play_ the game.
I couldn't get my program to solve the game, but I could allow the user to enter in some numbers and operands that they think would match the given Target Number using my Random Six Numbers that are generated and try to reach the Target Number themselves with those numbers.
My program, the reader, produces '#f' (false) if the user didn't reach the Target Number.

# How to run my two scripts:

To run this program, you can _'Clone or Dowmload'_ above, or simply just open two new Racket Scripts and call one of them _'stacker-test.rkt'_ which will act as the __'Reader'__, Call the other script _"Countdown-Solver---Theory-of-Algorithms.rkt"_ which will act as the _'Expander'_ and copy the code from the above script of the same name into your's.

## 'stacker-test.rkt' 
To use my program, you can input any number of operators (numbers) as long as they have some corresponding operands (+ / * -) in RPN Notation (Reverse Polish Notation - Two numbers first and then an operand). Ensure you always have two numbers and an operand or your equation will not be evaluated.

For Example, take this sample Reader:

``
#lang reader "Countdown-Solver---Theory-of-Algorithms.rkt"

RandomListFourthNumber

RandomListFifthNumber

' +'

RandomListFirstNumber

RandomListSecondNumber

' + '

RandomListThirdNumber

RandomListSixthNumber

' * '

' * '  ``

__PLEASE NOTE:__ Do not put quotation marks around the operands within Racket, they are only included here so Markdown will not render them as bullet points.

If I only had one multiplication symbol specified, the interpreter wouldn't evaluate the numbers on the stack together but, it would, rather, take RandomListFourthNumber and RandomListFifth number off the top of the 'stack' and evaluate them with the plus operand below, then it would take RandomListFirstNumber and RandomListSecondNumber and add them using the + operand below it and then it would take RandomListThirdNumber and RandomListSixthNumber and evaluate them using the * symbol below them leaving the three results on the stack. The program is designed to pop the first number off the stack which, in this case, would be your last result.

To counteract this and actually evaluate the results against each other you can add two more operators after the first multiplication symbol to evaluate the results.

As long as there are two or more numbers on the stack, any number of operaters can be used. It will not work with one number and one operand.
