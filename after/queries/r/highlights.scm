;extends
(
(comment) @comment
(#match? @comment "^\\#\\|")
) @text.literal


(
(comment) @codechunk
(#match? @codechunk "^\\#\\%\\%")
) @codechunk
