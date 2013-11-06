if (uuid_CONFIG_INCLUDED)
  return()
endif()
set(uuid_CONFIG_INCLUDED TRUE)

set(uuid_INCLUDE_DIRS /home/chadrockey/cppndk/rosinstall/target/include)

foreach(lib uuid)
  set(onelib "${lib}-NOTFOUND")
  find_library(onelib ${lib}
    PATHS /home/chadrockey/cppndk/rosinstall/target/lib
    NO_DEFAULT_PATH
    )
  if(NOT onelib)
    message(FATAL_ERROR "Library '${lib}' in package uuid is not installed properly")
  endif()
  list(APPEND uuid_LIBRARIES ${onelib})
endforeach()

foreach(dep )
  if(NOT ${dep}_FOUND)
    find_package(${dep})
  endif()
  list(APPEND uuid_INCLUDE_DIRS ${${dep}_INCLUDE_DIRS})
  list(APPEND uuid_LIBRARIES ${${dep}_LIBRARIES})
endforeach()
