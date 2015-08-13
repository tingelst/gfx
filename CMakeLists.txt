cmake_minimum_required(VERSION 2.8.3)

project(gfx)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -U__STRICT_ANSI__")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ftemplate-depth-1200")
set(CMAKE_CXX_FLAGS 
      "${CMAKE_CXX_FLAGS} -Wno-switch -Wno-deprecated-declarations -Wno-int-to-pointer-cast")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -U__STRICT_ANSI__")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-switch -Wno-int-to-pointer-cast") 

set(GFX_INCLUDE_DIRS 
  include 
  include/gfx)

include_directories(${GFX_INCLUDE_DIRS})

option(BUILD_EXAMPLES OFF "Build the examples")
if(BUILD_EXAMPLES)

  find_package(OpenGL REQUIRED)
  find_package(Glew REQUIRED)
  find_package(GLUT REQUIRED)
  find_package(GLV REQUIRED)

  set(GFX_INCLUDE_DIRS 
    ${GFX_INCLUDE_DIRS} 
    ${GLV_INCLUDE_DIR}
    ${GFX_INCLUDE_DIRS}
    ${GLEW_INCLUDE_DIR})
  include_directories(${GFX_INCLUDE_DIRS})

  list(APPEND GFX_LIBRARY_DEPENDENCIES ${GLV_LIBRARY})
  list(APPEND GFX_LIBRARY_DEPENDENCIES ${GLUT_LIBRARY})
  list(APPEND GFX_LIBRARY_DEPENDENCIES ${OPENGL_LIBRARY})
  list(APPEND GFX_LIBRARY_DEPENDENCIES ${GLEW_LIBRARY})

  file(GLOB EXAMPLE_SRCS examples/GL/*.cpp)
  foreach(EXAMPLE_SRC ${EXAMPLE_SRCS})
    get_filename_component(TARGET ${EXAMPLE_SRC} NAME_WE)
    add_executable(${TARGET} ${EXAMPLE_SRC} )
    target_link_libraries(${TARGET} ${GFX_LIBRARY_DEPENDENCIES} )
  endforeach()

endif(BUILD_EXAMPLES)

install(DIRECTORY include/gfx 
  DESTINATION "${CMAKE_INSTALL_PREFIX}/include")
export(PACKAGE gfx)
configure_file(gfx-config.cmake.in
    ${PROJECT_BINARY_DIR}/gfx-config.cmake @ONLY)
install(FILES ${PROJECT_BINARY_DIR}/gfx-config.cmake DESTINATION share/gfx)
install(FILES package.xml DESTINATION share/gfx)
