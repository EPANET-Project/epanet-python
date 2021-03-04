#
# CMakeLists.txt - CMake configuration file for epanet.toolkit python package
#
# Created:   Feb 20, 2020
# Modified:  May 4, 2020
#
# Author: Michael E. Tryby
#         US EPA ORD/CESER
#

################################################################################
################    CMAKELISTS FOR EPANET-TOOLKIT EXT BUILD    #################
################################################################################


set(CMAKE_SWIG_FLAGS -py3)

# Determine filename suffix for python extension
if(WIN32)
    set(LIB_EXT "pyd")
else()
    set(LIB_EXT "so")
endif()
set(PYTHON_SUFFIX ".${Python3_SOABI}.${LIB_EXT}")



# Location of package at runtime on MacOS/Linux
if(APPLE)
    set(LIB_ROOT "@loader_path")
else()
    set(LIB_ROOT "$ORIGIN")
endif()

# Set up rpath on MacOS and Linux
set(PACKAGE_RPATH
    "${LIB_ROOT}/../../epanet_toolkit/;${LIB_ROOT}/../../epanet_toolkit.libs/"


#############################################################
####################    OUTPUT TARGET    ####################
#############################################################

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

target_include_directories(output
    PUBLIC
        ${Python3_INCLUDE_DIRS}
)

target_link_libraries(output
    PUBLIC
        $<$<BOOL:$<C_COMPILER_ID:MSVC>>:Python3::Module>
        epanet-output
)

set_target_properties(output
    PROPERTIES
        SUFFIX ${PYTHON_SUFFIX}
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


#############################################################
####################    SOLVER TARGET    ####################
#############################################################


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
        $<$<BOOL:$<C_COMPILER_ID:MSVC>>:Python3::Module>
        epanet2
)

target_include_directories(solver
    PUBLIC
        ${Python3_INCLUDE_DIRS}
)

set_target_properties(solver
    PROPERTIES
        SUFFIX ${PYTHON_SUFFIX}
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
