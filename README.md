# MiniLisp

- Read the language specifications of Mini-LISP.
- Read and run Mini-LISP program examples to understand the language behavior.
- Write an interpreter for Mini-LISP, implement features of the language.

## Compile

    $ ./compile.sh

This file can compile and link bison and flex. And then it will generate an executable file `fp`

## Test

    $ ./fp < test_data/"file name".lsp

## Features

|     | Feature              | Description                                      |
| --- | -------------------- | ------------------------------------------------ |
| 1   | Syntax Validation    | Print “syntax error” when parsing invalid syntax |
| 2   | Print                | implement print-num statement                    |
| 3   | Numerical Operations | Implement all numerical operations               |
| 4   | Logical Operations   | Implement all logical operations                 |
| 5   | if Expression        | Implement if expression                          |
| 6   | Variable Definition  | Able to define a variable                        |
| 7   | Function             | Not done                                         |
| 8   | Named Function       | Able to declare and call a named function        |
