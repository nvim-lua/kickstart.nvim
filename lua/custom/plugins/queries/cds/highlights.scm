; highlights.scm
; See https://tree-sitter.github.io/tree-sitter/syntax-highlighting>
; on how to install these queries to get `tree-sitter highlight file.cds`
; to work.

; Note: First matches apply

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ";"
  "."
  ","
] @punctuation.delimiter


[
  "*"
  "+"
  "-"
  "/"
  "||"
] @operator

[
  "true"
  "false"
  (null)
] @constant.builtin

[
  "all"
  "any"
  "as"
  "by"
  "case"
  "cast"
  "distinct"
  "exists"
  "extract"
  "false"
  "from"
  "in"
  "key"
  "new"
  "not"
  "of"
  "on"
  "select"
  "some"
  "when"
  "trim"
  "true"
  "where"
  "with"
  "abstract"
  "action"
  "actions"
  "and"
  "annotate"
  "annotation"
  "array"
  "asc"
  "aspect"
  "association"
  "between"
  "both"
  "composition"
  "context"
  "cross"
  "current"
  "day"
  "default"
  "define"
  "desc"
  "element"
  "else"
  "end"
  "entity"
  "enum"
  "event"
  "escape"
  "exact"
  "except"
  "excluding"
  "extend"
  "first"
  "floating"
  "following"
  "full"
  "function"
  "group"
  "having"
  "hour"
  "inner"
  "intersect"
  "into"
  "is"
  "join"
  "last"
  "leading"
  "left"
  "like"
  "limit"
  "localized"
  "many"
  "masked"
  "minus"
  "minute"
  "mixin"
  "month"
  "namespace"
  "nulls"
  "offset"
  "one"
  "or"
  "order"
  "outer"
  "over"
  "parameters"
  "partition"
  "preceding"
  "projection"
  "redirected"
  "returns"
  "right"
  "row"
  "rows"
  "second"
  "service"
  "then"
  "trailing"
  "to"
  "type"
  "union"
  "unbounded"
  "up"
  "using"
  "variable"
  "view"
  "virtual"
  "year"
] @keyword
"@" @attribute ; annotations

(from_path) @variable
(simple_path) @variable
(definition_reference) @variable
(element_reference) @variable

(identifier) @variable

(comment) @comment

(number) @number
(single_quote_string) @string
(backtick_string) @string
(text_block) @string

(parameter_definition type: (_ (_ (_ (identifier) @type))))
(parameter_definition (name) @variable.parameter)

(entity_definition (name) @function)
(aspect_definition (name) @function)
(type_definition (name) @function)
(view_definition (name) @function)
(event_definition (name) @function)
(annotation_definition (name) @function)
(context_definition (name) @function)
(service_definition (name) @function)
(action_definition (name) @function)
(function_definition (name) @function)


(annotation_path (identifier) @attribute)
