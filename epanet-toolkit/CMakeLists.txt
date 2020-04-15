#
# CMakeLists.txt - CMake configuration file for epanet-toolkit python package
#
# Created:   Feb 6, 2020
# Modified:  Feb 20, 2020
#
# Author: Michael E. Tryby
#         US EPA ORD/CESER
#


cmake_minimum_required (VERSION 3.13)

project(epanet-toolkit)


set(Python_FIND_VIRTUALENV FIRST)
set(Python_ROOT_DIR "/usr/local/anaconda3")
find_package(Python 3.7 COMPONENTS Development Interpreter)
message(STATUS "Python_VERSION: ${Python_VERSION}")


find_package(SWIG REQUIRED)
cmake_policy(SET CMP0078 NEW)
cmake_policy(SET CMP0086 NEW)
include(${SWIG_USE_FILE})


add_subdirectory(epanet-solver)


add_subdirectory(src/epanet/toolkit)
