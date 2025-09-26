function(print_var VAR_NAME)
  if(NOT DEFINED ${VAR_NAME})
    return(message (STATUS "${VAR_NAME} = <undefined>"))
  endif()

  set(value "${${VAR_NAME}}")
  list(LENGTH value len)

  if(len GREATER 1)
    message(STATUS "${VAR_NAME} = [")
    foreach(item IN LISTS value)
      message(STATUS "    ${item}")
    endforeach()
    message(STATUS "]")
  else()
    message(STATUS "${VAR_NAME} = ${value}")
  endif()
endfunction()

function(set_if_undefined VAR_NAME VAR_VALUE)
  if(NOT DEFINED ${VAR_NAME})
    set(${VAR_NAME}
        ${VAR_VALUE}
        PARENT_SCOPE)
  endif()
endfunction()

function(delegate_call FUNCTION_NAME)
  if(NOT COMMAND ${FUNCTION_NAME})
    message(
      FATAL_ERROR "Function '${FUNCTION_NAME}' is not defined or available")
  endif()
  cmake_language(CALL ${FUNCTION_NAME} ${ARGN})
endfunction()

function(get_subdirectories DIR_PATH RESULT_VAR)
  file(GLOB ENTRIES "${DIR_PATH}/*")
  set(SUBDIRS)
  foreach(ENTRY ${ENTRIES})
    if(IS_DIRECTORY ${ENTRY})
      list(APPEND SUBDIRS ${ENTRY})
    endif()
  endforeach()
  set(${RESULT_VAR}
      ${SUBDIRS}
      PARENT_SCOPE)
endfunction()

function(get_cpp_sources RESULT_VAR DIR_PATH)
  if(NOT IS_DIRECTORY "${DIR_PATH}")
    message(FATAL_ERROR "Directory not found: ${DIR_PATH}")
  endif()

  file(
    GLOB_RECURSE
    sources
    "${DIR_PATH}/*.cpp"
    "${DIR_PATH}/*.cc"
    "${DIR_PATH}/*.cxx"
    "${DIR_PATH}/*.c++"
    "${DIR_PATH}/*.h"
    "${DIR_PATH}/*.hpp"
    "${DIR_PATH}/*.hxx"
    "${DIR_PATH}/*.h++")

  set(${RESULT_VAR}
      ${sources}
      PARENT_SCOPE)
endfunction()
