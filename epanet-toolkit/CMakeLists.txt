#
# CMakeLists.txt - CMake configuration file for epanet-toolkit python package
#
# Created:   Feb 6, 2020
# Modified:  March 4, 2021
#
# Author: Michael E. Tryby
#         US EPA ORD/CESER
#

################################################################################
#################    CMAKELISTS FOR EPANET-TOOLKIT PROJECT    ##################
################################################################################

cmake_minimum_required (VERSION 3.17)

project(epanet-toolkit
    VERSION
        0.5.0
)


# Trick here is to perform build in a python virtual environment
set(Python_FIND_VIRTUALENV FIRST)
set(CMAKE_FIND_DEBUG_MODE TRUE)
if(NOT MSVC)
    find_package (Python3 ${PYTHON_VERSION_STRING} COMPONENTS Interpreter Development.Module REQUIRED)
else()
    find_package (Python3 ${PYTHON_VERSION_STRING} COMPONENTS Interpreter Development REQUIRED)
endif()
set(CMAKE_FIND_DEBUG_MODE FALSE)


find_package(SWIG REQUIRED)
cmake_policy(SET CMP0078 NEW)
cmake_policy(SET CMP0086 NEW)
include(${SWIG_USE_FILE})


add_subdirectory(epanet-solver)


add_subdirectory(src/epanet/toolkit)
