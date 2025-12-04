cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)

project(firmware C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

add_executable(${PROJECT_NAME})

file(GLOB_RECURSE SOURCES
    "${CMAKE_CURRENT_LIST_DIR}/src/*.c"
)

target_sources(${PROJECT_NAME} PUBLIC ${SOURCES})

# Make sure TinyUSB can find tusb_config.h
target_include_directories(${PROJECT_NAME} PUBLIC
    "${CMAKE_CURRENT_LIST_DIR}/src"
)

target_link_libraries(${PROJECT_NAME} PUBLIC
    pico_stdlib
    tinyusb_device
    tinyusb_board
)

pico_add_extra_outputs(${PROJECT_NAME})
