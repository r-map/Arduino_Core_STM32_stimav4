
set(CI_FOLDER ${CMAKE_CURRENT_LIST_DIR}/../CI)

function(external_library)
  cmake_parse_arguments(PARSE_ARGV 0 XLIB "FORCE" "PATH" "DEPENDS")

  if(DEFINED XLIB_UNPARSED_ARGUMENTS OR DEFINED XLIB_KEYWORDS_MISSING_VALUES)
    message(SEND_ERROR "Invalid call to external_library(); some arguments went unparsed")
  endif()

  if(NOT DEFINED XLIB_PATH)
    message(SEND_ERROR "Invalid call to external_library(); please specify a PATH")
    return()
  endif()

  if(NOT EXISTS ${XLIB_PATH}/CMakeLists.txt OR ${XLIB_FORCE})
    execute_process(
      COMMAND ${PYTHON3} ${CI_FOLDER}/update/cmake_libs.py -l ${XLIB_PATH} -d ${XLIB_DEPENDS}
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
  endif()
  get_filename_component(LIBNAME ${XLIB_PATH} NAME)
  add_subdirectory(${XLIB_PATH} ${LIBNAME})
endfunction()
