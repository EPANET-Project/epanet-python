#
# CMakeLists.txt - CMake configuration file for epanet-toolkit python package
#
# Created:   Feb 6, 2020
# Modified:  Feb 20, 2020
#
# Author: Michael E. Tryby
#         US EPA ORD/CESER
#


cmake_minimum_required (VERSION 3.17)

project(epanet-toolkit
    VERSION
        0.5.0
)


set(Python_EXECUTABLE ${PYTHON_EXECUTABLE})
set(Python_INCLUDE_DIRS ${PYTHON_INCLUDE_DIR})
set(Python_LIBRARY ${PYTHON_LIBRARY})
find_package (Python ${PYTHON_VERSION_STRING} COMPONENTS Interpreter Development)


find_package(SWIG REQUIRED)
cmake_policy(SET CMP0078 NEW)
cmake_policy(SET CMP0086 NEW)
include(${SWIG_USE_FILE})


add_subdirectory(epanet-solver)


add_subdirectory(src/epanet/toolkit)
