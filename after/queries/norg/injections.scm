; Injection for code blocks
(ranged_verbatim_tag (tag_name) @_tagname (tag_parameters .(tag_param) @injection.language) (ranged_verbatim_tag_content) @injection.content (#any-of? @_tagname "code" "embed"))
(ranged_verbatim_tag (tag_name) @_tagname (tag_parameters)? (ranged_verbatim_tag_content) @injection.content (#eq? @_tagname "math") (#set! injection.language "latex"))

(
    (inline_math) @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.language "latex")
)

(ranged_verbatim_tag (tag_name) @_tagname (ranged_verbatim_tag_content) @injection.content (#eq? @_tagname "document.meta") (#set! injection.language "norg_meta"))

