; extends
((call
  function: (identifier) @function_name (#eq? @function_name "Style")
  arguments: (argument_list
    (string
      (string_content) @injection.content)))

  (#set! injection.language "css"))

((call
  function: (identifier) @function_name (#eq? @function_name "Script")
  arguments: (argument_list
    (string
      (string_content) @injection.content)))

  (#set! injection.language "javascript"))

((call
  function: (identifier) @function_name (#eq? @function_name "On")
  arguments: (argument_list

    (string
      (string_content) @injection.content))

  (#set! injection.language "javascript")))
