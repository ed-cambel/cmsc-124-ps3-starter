# Reasoning for the Predictions Table

Write one entry under every heading below, then commit this file together with
`predictions.tsv`, before you run a case or open `tests/expected.tsv`.

Each entry names the rule that produces the four predicted fields for that
case. One to three sentences is enough. The grader checks structure only. It
does not judge quality, and it sets no word minimum.

After you run the cases, add a short correction under each case you predicted
wrongly. Say what you predicted, what CLISP printed, and which rule you
misread. Those entries belong in the correction commits.

## P01

The case starts with `+`, a function thus it will evaluate every argument in its case before it runs. 
Before adding, it will first evaluate the inner function `(* 2 3)` which results in 6 then the `+` will then be executed, and the final value is `7`, an integer. As the value is an integer, and not a sequence then it would have a length of none. The case has a function as its operator as `+` is the head of the case. 

## P02

Despite its seeming similarity to P01, it does not evaluate like P01 as its head is `quote`, thus P02 case’s operator is special-operator, which does not evaluate its subform unlike a function. As for its kind, it is `cons` as it is a list with at least one element. As for how it is written, the value is  `(+,1,2)` in the grader’s notation, with elements separated with commas, and no spaces. The value has a length of 3, counting the number of elements inside the list. 

## P03

The form is the atom `nil` thus it has no head, and the operator is none. As nil is the empty list, symbol, and false at the same time, its kind is null. And it is an empty sequence thus it has a length of 0 instead of none. 
  
## P04

The form is the atom `t`, so it has no head and the operator is none. `t` evaluates to itself thus the value is `t`. As it is a symbol that is not `nil`, then the kind is symbol. It would have none as its length as it is not a sequence. 

## P05

`symbolp` is a function thus it evaluates its argument, `nil`, then tests whether it is a symbol, and given that `nil` is a symbol then the predicate returns true, `t`. The value return, `t`, is not `nil`, so the kind is `symbol`, and it is not a sequence thus the length is `none`. 
    
## P06

`car` is a function, so it evaluates its argument. The argument `'()` is read as `(quote ())`, which returns the empty list `nil`, and `car` of the empty list would return `nil`. Thus, the value is `nil`, which makes `null` as its kind, while the length is 0 as `nil` is an empty sequence. 

## P07

`cons` is a function, so the operator is a function, which evaluates both arguments, `1` evaluates to itself, and `'(2,3)` which is `(quote (2 3))`, that returns the list `(2 3)`. `cons` will then build a new list with `1` in front, which gives the `(1 2 3)` that would be written as `(1,2,3)` in grader’s notation. As a list with at least one element is `cons`, and the list contains 3 elements, then the length is 3.

## P08

The case starts with `if` so the operator is `special-operator`, and it decides which subforms to evaluate. Firstly, it will evaluate the `if` condition then chooses one branch according to the result of the condition. Given that `(null '())` is true, it will then proceed to evaluate empty, and will no longer continue with full, and return the value `empty`. As for its kind, P08’s kind is symbol, and as it is a symbol that is not nil, then the length is none. 


## P09

`and` is a macro that evaluates its arguments left to right and stops at the first `nil`. It first evaluates `1`, which is not a nil, so it continues to the next argument `nil`, where it stops and returns `nil` without evaluating `3` at all. The value is `nil`, with kind `null` and length 0.

## P10

`progn` is a special operator that runs its forms in order and returns the value of the last one. `defvar` defines a global variable `*ps3-rate*` with initial value 2, and `defun` defines `ps3-scale` with parameter `n` and body `(* n *ps3-rate*)`. The `let` temporarily binds `*ps3-rate*` to 10, so when `(ps3-scale 3)` runs, the function sees 10 and returns 30, with kind `integer` and no length.

## P11

`defun` defines a global function named `ps3-twice` with parameter `n`, whose body multiplies `n` by 2. No call is ever made, so the body `(* n 2)` never runs. Evaluating the `defun` form returns the function's name as a symbol, `ps3-twice`, with kind `symbol`, no length, and operator `macro`.

## P12

`labels` is a special-operator that defines a local recursive function `down` with parameter `n`. Inside the `if`, `(= n 0)` tests the base case and returns an empty list when `n` is 0; otherwise, `(cons n (down (- n 1)))` is the recursive call, which conses `n` onto the result of `down` with `n - 1`. This results `(3 2 1)`, with kind `cons` and length 3.

## P13

`mapcar` applies `#'length` and `((1 2) () (3))` returns as one unevaluated list containing three lists. So, `mapcar` calls `#'length` on each list element in order: `(1 2)` has length 2, `()` is empty with length 0, `(3)` has length 1. The results are then returned as a new list, with kind cons, and length 3.

## P14

`mapcar` applies `(lambda (n) (* n n))`, its first argument, and `'(1 2 3)` returns an unevaluated list. So, `mapcar` calls lambda, which takes each number in the list as `n` and multiplies it by itself, resulting in `(1, 4, 9)` with type cons and length 3.

## P15

`'(lambda (n) (* n 2))` is headed by a macro `lambda`, a special type of that rewrites arguments passed to it. For this case, it simply creates an anonymous function that will take a number `n` and multiply it by `2`. It has no length since it is an obejct.

## P16

The first `let` binds `factor` to `2`. The second `let` binds the lambda `(lambda (n) (* n factor))` to `f`, and the lambda captures that `factor (2)`. The third `let` doesn’t overwrite `factor`, but rather creates a new variable `factor = 10` that is visible only inside the third `let`’s body, and the lambda can’t see it. When `(funcall f 3)` runs, the lambda uses `factor = 2` and `n = 3`, so it returns `6`.
