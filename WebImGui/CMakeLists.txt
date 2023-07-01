project(WebImGui)
cmake_minimum_required(VERSION 3.4.1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17")

set(MAIN_SOURCE_DIR "./src")
set(IMGUI_BASE_DIR "/home/ha6ki/DEV/imgui")

set(IMGUI ${IMGUI_BASE_DIR})
set(IMGUI_BACKEND ${IMGUI_BASE_DIR}/backends)
set(BASE_HTML ${CMAKE_CURRENT_SOURCE_DIR}/src/web/imgui.html)
set(BASE_DATA ${CMAKE_CURRENT_SOURCE_DIR}/data/)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/build)

include_directories(${IMGUI})
include_directories(${IMGUI_BACKEND})

file(GLOB_RECURSE CPP_HEADERS ${MAIN_SOURCE_DIR}/*.hpp)
file(GLOB_RECURSE CPP_SOURCES ${MAIN_SOURCE_DIR}/*.cpp)

add_executable(
    WebImGui
    ${CPP_HEADERS}
    ${CPP_SOURCES}
)

target_sources(WebImGui PUBLIC ${IMGUI}/imgui.cpp)
target_sources(WebImGui PUBLIC ${IMGUI}/imgui_draw.cpp)
target_sources(WebImGui PUBLIC ${IMGUI}/imgui_demo.cpp)
target_sources(WebImGui PUBLIC ${IMGUI}/imgui_widgets.cpp)
target_sources(WebImGui PUBLIC ${IMGUI}/imgui_tables.cpp)

target_sources(WebImGui PUBLIC ${IMGUI_BACKEND}/imgui_impl_opengl3.cpp)
target_sources(WebImGui PUBLIC ${IMGUI_BACKEND}/imgui_impl_glfw.cpp)


set(CMAKE_EXECUTABLE_SUFFIX ".html")

set(CMAKE_EXE_LINKER_FLAGS "-lglfw -lGL --shell-file ${BASE_HTML} --preload-file ${BASE_DATA}@/data/")

set_target_properties(
    WebImGui
    PROPERTIES
    LINK_FLAGS
    "-O3 -s USE_WEBGL2=1 -s USE_GLFW=3 -s FULL_ES3=1"
)