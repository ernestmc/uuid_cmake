cmake_minimum_required(VERSION 2.8)
project(uuid)

if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

if(MSVC OR MSVC90 OR MSVC10)
  set(MSVC ON)
endif (MSVC OR MSVC90 OR MSVC10)

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_library(uuid clear.c compare.c copy.c gen_uuid.c isnull.c pack.c parse.c unpack.c unparse.c uuid_time.c)

install(TARGETS uuid
  DESTINATION lib/)

install(FILES include/uuid/uuid.h
  DESTINATION include/uuid)

set(PKG_NAME ${PROJECT_NAME})
set(PKG_LIBRARIES uuid)
set(cmake_conf_file "${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}-config.cmake")
configure_file("${cmake_conf_file}.in" "${cmake_conf_file}" @ONLY)
install(FILES ${cmake_conf_file} DESTINATION share/${PROJECT_NAME}/cmake/ COMPONENT cmake)

if (NOT MSVC)
  set(PKG_DESC "uuid")
  set(PKG_CB_LIBS "-luuid")
  set(pkg_conf_file "${CMAKE_CURRENT_SOURCE_DIR}/uuid.pc")
  configure_file("${pkg_conf_file}.in" "${pkg_conf_file}" @ONLY)
  install(FILES ${pkg_conf_file} DESTINATION lib/pkgconfig/ COMPONENT pkgconfig)
endif()

