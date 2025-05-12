cmake_minimum_required(VERSION 3.29)
project(%name%)
set(CMAKE_CXX_STANDARD 26)

# set(Boost_DEBUG ON)
set(BOOST_ROOT "C:\\boost")
add_library(%name% SHARED "%name%.cpp" )
target_include_directories(%name% PRIVATE "${PROJECT_SOURCE_DIR}/kdb")
find_package(Boost REQUIRED)

include(FetchContent)
FetchContent_Declare(chk
        GIT_REPOSITORY https://github.com/KxSystems/kdb.git
)

FetchContent_MakeAvailable(chk)

set(CMAKE_VS_INCLUDE_INSTALL_TO_DEFAULT_BUILD 1)


include(FetchContent)
FetchContent_Declare(kpi
        GIT_REPOSITORY https://github.com/kimtang/kpi.git
        GIT_TAG        main
)
FetchContent_MakeAvailable(kpi)
include_directories("${CMAKE_BINARY_DIR}/_deps/kpi-src/qlib/kpi/cpp")

message(PROJECT_SOURCE_DIR="${PROJECT_SOURCE_DIR}")
include_directories("${PROJECT_SOURCE_DIR}")

include_directories("${Boost_INCLUDE_DIRS}")
# target_include_directories(%name% SYSTEM PUBLIC ${Boost_INCLUDE_DIR})

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    set_source_files_properties(%name% PROPERTIES COMPILE_OPTIONS "/bigobj")
    target_link_options(%name% PRIVATE 
        /DEF:${CMAKE_CURRENT_SOURCE_DIR}/%name%.def
    )

    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        target_link_libraries(%name% PRIVATE "${CMAKE_BINARY_DIR}/_deps/chk-src/w64/q.lib")
        install(TARGETS %name% DESTINATION "${PROJECT_SOURCE_DIR}/bin/w64/${CMAKE_BUILD_TYPE}")
    else()
        target_link_libraries(%name% PRIVATE "${CMAKE_BINARY_DIR}/_deps/chk-src/w32/q.lib")
        install(TARGETS %name% DESTINATION "${PROJECT_SOURCE_DIR}/bin/w32/${CMAKE_BUILD_TYPE}")
    endif()
endif()


# target_link_libraries(%name% PUBLIC Boost::headers Boost::system Boost::filesystem)
