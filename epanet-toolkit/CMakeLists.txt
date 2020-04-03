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


set(Python_ROOT_DIR "user/local/anaconda3")
find_package(Python 3.7 COMPONENTS Interpreter Development)
message(STATUS "Python_VERSION: ${Python_VERSION}")

find_package(SWIG REQUIRED)
include(${SWIG_USE_FILE})


add_subdirectory(epanet-solver)


add_subdirectory(src/epanet/toolkit)
