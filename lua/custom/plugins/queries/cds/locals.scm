; locals.scm
; See <https://tree-sitter.github.io/tree-sitter/syntax-highlighting#local-variables>
;
; We can use:
;  - @local.scope
;  - @local.definition
;  - @local.reference

; Scopes
;-------

(namespace) @local.scope
(context_definition) @local.scope
(service_definition) @local.scope


; Definitions
;------------

(parameter_definition
  (name) @local.definition)

(artifact_import
  alias: (_) @local.definition)

(entity_definition
  (name) @local.definition)

(view_definition
  (name) @local.definition)

(type_definition
  (name) @local.definition)

(event_definition
  (name) @local.definition)

(aspect_definition
  (name) @local.definition)


; References
;------------

(from_path . (identifier) @local.reference)
