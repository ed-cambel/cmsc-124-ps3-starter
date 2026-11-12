;;;; evaluator.lisp -- Part 2. Write the eight functions below.
;;;;
;;;; The toy language is a Lisp-1. One namespace holds both variables and
;;;; functions, so a variable bound to a closure is callable in operator
;;;; position and (f 1) works with no FUNCALL. The CLISP hosting this file is a
;;;; Lisp-2, which is why the host needs FUNCALL and #' where the toy language
;;;; needs neither. ANALYSIS.md asks you about that difference.
;;;;
;;;; An environment is an association list: ((name . value) (name . value) ...).
;;;; The grader scores E1 to E4 separately, so finish them in order and keep
;;;; every group you get right.
;;;;
;;;; The grammar, in full:
;;;;
;;;;   expr := number
;;;;         | symbol
;;;;         | (+ expr expr) | (- expr expr) | (* expr expr)
;;;;         | (let ((name expr) ...) body)
;;;;         | (lambda (name ...) body)
;;;;         | (operator-expr argument-expr ...)

;;; E1 -- numbers and symbols.

(defun lookup (name env)
  "The value NAME is bound to in ENV.

The first match wins, so an inner binding shadows an outer one that shares its
name. Signal an error when NAME is not bound at all."
  (let ((binding (assoc name env)))
    (if binding 
      (cdr binding)
      (error "Unbound variable: ~S" name))))

;;; E2 -- prefix arithmetic.

(defun eval-operands (exprs env)
  "Every expression in EXPRS, evaluated in the same ENV, as a list.

MAPCAR and a LAMBDA do this in one line. Watch the arity: EVAL-EXPR takes two
arguments and MAPCAR hands its function one."
  ;; exprs - list of unevaluated expressions
  ;; env - environment to evaluate the expressions in

  ;; mapcar applies lambda to each element and returns list of results
  (mapcar (lambda (expr) 
          ;;  call eval-expr on each expr with the same env and evaluate them
            (eval-expr expr env)) 
          exprs))

(defun apply-op (op values)
  "Apply the arithmetic operator OP to the two numbers in VALUES.

OP is the symbol +, -, or *. Signal an error for anything else."
  ;; op - arithmetic operator symbol
  ;; values - list of two numbers to apply the operator to

  ;; separate and bind values into two variables for easier calling
  (let ((a (first values))
        (b (second values)))
    ;; check the operator first then apply it to the two numbers
    (cond ((eq op '+) (+ a b))
          ((eq op '-) (- a b))
          ((eq op '*) (* a b))
          (t (error "Unknown operator: ~a" op)))))

;;; E3 -- let.

(defun extend-env (params args env)
  "ENV with PARAMS bound to ARGS in front of it.

MAPCAR takes two lists and #'CONS pairs them. Build a new list. Do not modify
ENV, because the caller keeps using it after the extension goes out of scope."
  (append (mapcar #'cons params args) env))

(defun eval-let (expr env)
  "Evaluate (let ((name init) ...) body).

Every init is evaluated in ENV before any name is bound, so the bindings happen
in parallel and an init cannot see a name the same LET introduces."
  (let* ((bindings (second expr))
            (body (third expr))
            (names (mapcar #'first bindings))
            (values (eval-operands (mapcar #'second bindings) env)))
    (eval-expr body (extend-env names values env))))


;;; E4 -- lambda and application.

(defun make-closure (params body env)
  "A closure over ENV.

Return the list (:closure params body env). ENV is the environment the lambda
was written in, not the one it will later be called from. Saving the wrong one
is what makes the difference between 3 and 101 in the case the manual walks
through."
  ;; params - list of parametrs for closure
  ;; body - body of closure
  ;; env - environment where closure was created

  ;; returns list representing the closure
  (list :closure params body env))

(defun apply-closure (closure args)
  "Run CLOSURE on ARGS.

The parameters join the environment the closure captured. Signal an error when
CLOSURE is not a closure, and when the argument count does not match."
  ;; closure - closure to be used
  ;; args - list of arguments passed to closure

  ;; check if closure is a valid closure
  (if (not (and (listp closure) (eq (first closure) :closure)))
      (error "Not a closure: ~a" closure))

  ;; check if number of arguments = number parameters
  (let ((params (second closure)))
    (if (not (= (length params) (length args)))
        (error "Argument count mismatch: ~a" closure)) 

    ;; extend the environment with parameters and arguments
    (let ((env (extend-env params args (fourth closure))))
      ;; evaluate the body of the closure in the new environment
      (eval-expr (third closure) env))))
      
;;; The dispatcher.
(defun eval-expr (expr env)
  "The value of EXPR in ENV."
  (cond
    ;; atoms first
    ((numberp expr) expr)

    ((symbolp expr) (lookup expr env)) ; NIL goes here, unbound error
    ((not (consp expr)) (error "Bad expression: ~S" expr))
    ;; special forms and arithmetic
    ((member (first expr) '(+ - *))
     (apply-op (first expr) (eval-operands (rest expr) env)))
    ((eq (first expr) 'let)
     (eval-let expr env))
    ((eq (first expr) 'lambda)
      (make-closure (second expr) (third expr) env))
    ;; evaluate the operator
    (t (apply-closure (eval-expr (first expr) env)
                      (eval-operands (rest expr) env)))))



