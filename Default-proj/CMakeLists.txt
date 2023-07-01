project(Default-proj)
cmake_minimum_required(VERSION 3.4.1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17")

set(MAIN_SOURCE_DIR "./src")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/build)

file(GLOB_RECURSE CPP_HEADERS ${MAIN_SOURCE_DIR}/*.hpp)
file(GLOB_RECURSE CPP_SOURCES ${MAIN_SOURCE_DIR}/*.cpp)

include_directories(/home/ha6ki/DEV/imgui)

set(CMAKE_EXECUTABLE_SUFFIX ".html")

add_executable(
    default-proj
    ${CPP_HEADERS}
    ${CPP_SOURCES}
)

set_target_properties(
    default-proj
    PROPERTIES
    LINK_FLAGS
    "-O3 -s USE_WEBGL2=1 --shell-file /home/ha6ki/CDEV/WebCPPMadness/Default-proj/src/web/index.html"
)