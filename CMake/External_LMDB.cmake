if (WIN32)

  # Build option for windows not yet generated
  message( FATAL_ERROR "LMDB on windows not yet supported" )

else()
  ExternalProject_Add(LMDB
    URL ${LMDB_url}
    URL_MD5 ${LMDB_md5}
    ${COMMON_EP_ARGS}
    ${COMMON_CMAKE_EP_ARGS}
    PATCH_COMMAND ${CMAKE_COMMAND}
      -DLMDB_patch:PATH=${fletch_SOURCE_DIR}/Patches/LMDB
      -DLMDB_source:PATH=${fletch_BUILD_PREFIX}/src/LMDB
      -P ${fletch_SOURCE_DIR}/Patches/LMDB/Patch.cmake
    CMAKE_ARGS
      ${COMMON_CMAKE_ARGS}
      -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
      -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
      )
endif()

fletch_external_project_force_install(PACKAGE LMDB)

set(LMDB_ROOT ${fletch_BUILD_INSTALL_PREFIX} CACHE STRING "")

file(APPEND ${fletch_CONFIG_INPUT} "
########################################
# LMDB
########################################
set(LMDB_ROOT    \${fletch_ROOT})
")
