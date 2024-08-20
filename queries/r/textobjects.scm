; block
; call
(call) @call.outer

(arguments) @call.inner

; class
; comment
(comment) @comment.outer

; conditional
(if_statement
  condition: (_)? @conditional.inner) @conditional.outer

; function
[
  (function_definition)
] @function.outer

(function_definition
  [
    (call)
    (binary_operator)
  ] @function.inner) @function.outer


; loop
[
  (while_statement)
  (for_statement)
  (repeat_statement)
] @loop.outer

(while_statement
  body: (_) @loop.inner)

(repeat_statement
  body: (_) @loop.inner)

(for_statement
  body: (_) @loop.inner)

; statement

(program
  (_) @statement.outer)

; number
(float) @number.inner

