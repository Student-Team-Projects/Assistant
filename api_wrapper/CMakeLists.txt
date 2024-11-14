cmake_minimum_required(VERSION 3.10)
PROJECT(api_wrapper)

add_executable(api_wrapper src/main.cpp)

set(VCPKG_DIR $ENV{VCPKG_DIR})

file(GLOB SOURCES
     "include/*.h"
     "src/*.c"
     "src/*.cpp")

set(Boost_NO_BOOST_CMAKE ON)

find_package(Boost CONFIG REQUIRED COMPONENTS system container program_options filesystem date_time context coroutine chrono)
find_package(restc-cpp CONFIG REQUIRED)
find_package(nlohmann_json CONFIG REQUIRED)

target_link_libraries(api_wrapper PRIVATE Boost::system Boost::container Boost::program_options Boost::filesystem
	Boost::date_time Boost::context Boost::coroutine Boost::chrono)
target_link_libraries(api_wrapper PRIVATE restc-cpp)
target_link_libraries(api_wrapper PRIVATE nlohmann_json::nlohmann_json)
