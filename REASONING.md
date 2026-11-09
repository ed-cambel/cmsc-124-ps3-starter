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
Replace this line with the rule behind this case's four fields.

## P02
Replace this line with the rule behind this case's four fields.

## P03
Replace this line with the rule behind this case's four fields.

## P04
Replace this line with the rule behind this case's four fields.

## P05
Replace this line with the rule behind this case's four fields.

## P06
Replace this line with the rule behind this case's four fields.

## P07
Replace this line with the rule behind this case's four fields.

## P08
Replace this line with the rule behind this case's four fields.

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
