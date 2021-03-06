#
# CMakeLists.txt - CMake configuration file for epanet.toolkit python package
#
# Created:   Feb 20, 2020
# Modified:  May 4, 2020
#
# Author: Michael E. Tryby
#         US EPA ORD/CESER
#


set(CMAKE_SWIG_FLAGS -py3)

# Determine filename suffix for python extension
if(WIN32)
    set(Python_EXTENSION ".${Python_SOABI}.pyd")
else()
    set(Python_EXTENSION ".${Python_SOABI}.so")
endif()


# Location of package at runtime on Linux/MacOS
if(APPLE)
    set(PACKAGE_RPATH "@loader_path/../../../..")
else()
    set(PACKAGE_RPATH "$ORIGIN/../../../..")
endif()


#######   OUTPUT TARGET   #######

set_property(SOURCE output.i
    PROPERTY
        USE_TARGET_INCLUDE_DIRECTORIES ON
)

swig_add_library(output
    TYPE
        MODULE
    LANGUAGE
        python
    SOURCES
        output.i
)

target_link_options(output
    PUBLIC
        $<$<BOOL:${APPLE}>:-undefineddynamic_lookup>
)

target_link_libraries(output
    PUBLIC
        Python::Module
        epanet-output
)

set_target_properties(output
    PROPERTIES
        SUFFIX ${Python_EXTENSION}
        SWIG_COMPILE_DEFINITIONS EXPORT_OUT_API
        MACOSX_RPATH TRUE
        SKIP_BUILD_RPATH FALSE
        BUILD_WITH_INSTALL_RPATH FALSE
        INSTALL_RPATH ${PACKAGE_RPATH}
        INSTALL_RPATH_USE_LINK_PATH TRUE
)

install(
    FILES
        "__init__.py"
        "output_enum.py"
        "output_metadata.py"
        "${CMAKE_CURRENT_BINARY_DIR}/output.py"
    DESTINATION
        "src/epanet/toolkit"
)

install(
    TARGETS
        output
    DESTINATION
        "src/epanet/toolkit"
)


#######   SOLVER TARGET   #######

set_property(SOURCE solver.i
    PROPERTY
        USE_TARGET_INCLUDE_DIRECTORIES ON
)

SWIG_ADD_LIBRARY(solver
    LANGUAGE
        python
    SOURCES
        solver.i
)

target_link_options(solver
    PUBLIC
        $<$<BOOL:${APPLE}>:-undefineddynamic_lookup>
)

target_link_libraries(solver
    PUBLIC
        Python::Module
        epanet2
)

set_target_properties(solver
    PROPERTIES
        SUFFIX ${Python_EXTENSION}
        SWIG_COMPILE_DEFINITIONS EXPORT_OUT_API
        MACOSX_RPATH TRUE
        SKIP_BUILD_RPATH FALSE
        BUILD_WITH_INSTALL_RPATH FALSE
        INSTALL_RPATH ${PACKAGE_RPATH}
        INSTALL_RPATH_USE_LINK_PATH TRUE
)

install(
    FILES
        "solver_enum.py"
        "${CMAKE_CURRENT_BINARY_DIR}/solver.py"
    DESTINATION
        "src/epanet/toolkit"
)

install(
    TARGETS
        solver
    DESTINATION
        "src/epanet/toolkit"
)
