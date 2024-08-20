;extends
(
(comment) @comment
(#match? @comment "^\\#\\|")
) @text.literal


(
(comment) @content
(#match? @content "^\\# ?\\%\\%")
) @class.outer @text.literal

