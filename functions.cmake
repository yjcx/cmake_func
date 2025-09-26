function(print_var VAR_NAME)
  if(DEFINED ${VAR_NAME})
    message(STATUS "${VAR_NAME} = ${${VAR_NAME}}")
  else()
    message(STATUS "${VAR_NAME} = <undefined>")
  endif()
endfunction()

function(set_if_undefined VAR_NAME VAR_VALUE)
  if(NOT DEFINED ${VAR_NAME})
    set(${VAR_NAME}
        ${VAR_VALUE}
        PARENT_SCOPE)
  endif()
endfunction()
