# MiniLisp

- Read the language specifications of Mini-LISP.
- Read and run Mini-LISP program examples to understand the language behavior.
- Write an interpreter for Mini-LISP, implement features of the language.

## Compile

    $ ./compile.sh

This file can compile and link bison and flex. And then it will generate an executable file `fp`.

## Test

    $ ./fp < test_data/"file name".lsp

You can also input by yourself.

    $ ./fp

## Features

|     | Feature              | Description                                      | Done |
| --- | -------------------- | ------------------------------------------------ | ---- |
| 1   | Syntax Validation    | Print “syntax error” when parsing invalid syntax | ✓    |
| 2   | Print                | implement print-num statement                    | ✓    |
| 3   | Numerical Operations | Implement all numerical operations               | ✓    |
| 4   | Logical Operations   | Implement all logical operations                 | ✓    |
| 5   | If Expression        | Implement if expression                          | ✓    |
| 6   | Variable Definition  | Able to define a variable                        | ✓    |
| 7   | Function             | Able to declare and call an anonymous function   | ✗    |
| 8   | Named Function       | Able to declare and call a named function        | ✗    |

### Print

    PRINT-STMT ::= (print-num EXP)

Behavior: Print exp in decimal.

    PRINT-STMT ::= (print-bool EXP)

Behavior: Print #t if EXP is true. Print #f, otherwise.

### Numerical Operations

    PLUS ::= (+ EXP EXP+)

Behavior: return sum of all EXP inside.  
Example: (+ 1 2 3 4) → 10

    MINUS ::= (- EXP EXP)

Behavior: return the result that the 1st EXP minus the 2nd EXP.  
Example: (- 2 1) → 1

    MULTIPLY ::= (* EXP EXP+)

Behavior: return the product of all EXP inside.  
Example: (\* 1 2 3 4) → 24

    DIVIDE ::= (/ EXP EXP)

Behavior: return the result that 1st EXP divided by 2nd EXP.  
Example:  
(/ 10 5) → 2  
(/ 3 2) → 1 (just like C++)

    MODULUS ::= (mod EXP EXP)

Behavior: return the modulus that 1st EXP divided by 2nd EXP.  
Example: (mod 8 5) → 3

    GREATER ::= (> EXP EXP)

Behavior: return #t if 1st EXP greater than 2nd EXP. #f otherwise.  
Example: (> 1 2) → #f

    SMALLER ::= (< EXP EXP)

Behavior: return #t if 1st EXP smaller than 2nd EXP. #f otherwise.  
Example: (< 1 2) → #t

    EQUAL ::= (= EXP EXP+)

Behavior: return #t if all EXPs are equal. #f otherwise.  
Example: (= (+ 1 1) 2 (/6 3)) → #t

### Logical Operations

    AND-OP ::= (and EXP EXP+)

Behavior: return #t if all EXPs are true. #f otherwise.  
Example: (and #t (> 2 1)) → #t

    OR-OP ::= (or EXP EXP+)

Behavior: return #t if at least one EXP is true. #f otherwise.  
Example: (or (> 1 2) #f) → #f

    NOT-OP ::= (not EXP)

Behavior: return #t if EXP is false. #f otherwise.  
Example: (not (> 1 2)) → #t

### If Expression

    IF-EXP ::= (if TEST-EXP THEN-EXP ELSE-EXP)
    TEST-EXP ::= EXP
    THEN-EXP ::= EXP
    ELSE-EXP ::= EXP

Behavior: When TEST-EXP is true, returns THEN-EXP. Otherwise, returns ELSE-EXP.  
Example:  
(if (= 1 0) 1 2) → 2  
(if #t 1 2) → 1

### Variable Definition

    DEF-STMT ::= (define id EXP)
    VARIABLE ::= id

Behavior: Define a variable named id whose value is EXP.  
Example:  
(define x 5)  
(+ x 1) → 6

### Function

    FUN-EXP ::= (fun FUN-IDs FUN-BODY)
    FUN-IDs ::= (id*)
    FUN-BODY ::= EXP
    FUN-CALL ::= (FUN-EXP PARAM*) | (FUN-NAME PARAM*)
    PARAM ::= EXP
    LAST-EXP ::= EXP
    FUN-NAME ::= id

Behavior:  
FUN-EXP defines a function. When a function is called, bind FUN-IDs to PARAMs, just like the define statement. If an id has been defined outside this function, prefer the definition inside the FUN-EXP. The variable definitions inside a function should not affect the outer scope. A FUN-CALL returns the evaluated result of FUN-BODY Note that variables used in FUN-BODY should be bound to PARAMs.

Examples:  
((fun (x) (+ x 1)) 2) → 3

(define foo (fun () 0))  
(foo) → 0

(define x 1)  
(define bar (fun (x y) (+ x y)))  
(bar 2 3) → 5  
x → 1
