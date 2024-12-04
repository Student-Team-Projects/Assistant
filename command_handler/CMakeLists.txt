cmake_minimum_required(VERSION 3.10)
project(command_handler)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

add_executable(menu_prompt menu_prompt.cpp)
install(TARGETS menu_prompt DESTINATION /usr/bin)
