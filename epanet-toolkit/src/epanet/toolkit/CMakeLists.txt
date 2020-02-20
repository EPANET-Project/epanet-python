#
# CMakeLists.txt - CMake configuration file for epanet.toolkit python package
#
# Created:   Feb 20, 2020
# Modified:
#
# Author: Michael E. Tryby
#         US EPA ORD/CESER
#

################################################################################
################################  OUTPUT TARGET   ##############################
################################################################################

set_property(SOURCE output.i
    PROPERTY
        USE_TARGET_INCLUDE_DIRECTORIES ON
    )

SWIG_ADD_LIBRARY(output
    LANGUAGE
        python
    SOURCES
        output.i
    )

set_property(TARGET output
    PROPERTY
        SWIG_COMPILE_DEFINITIONS EXPORT_OUT_API
    )

target_link_libraries(output
    PUBLIC
        Python::Python
        epanet-output
    )

install(
    FILES
        "__init__.py"
        "output_enum.py"
        "output_metadata.py"
        "$<TARGET_FILE:output>"
        "${CMAKE_CURRENT_BINARY_DIR}/output.py"
    DESTINATION
        "epanet/toolkit"
)

install(
    TARGETS
        epanet-output RUNTIME
    DESTINATION
        "epanet/toolkit"
)



################################################################################
################################  SOURCE TARGET   ##############################
################################################################################



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

target_link_libraries(solver
    PUBLIC
        Python::Python
        epanet2
    )

install(
    FILES
        "solver_enum.py"
        "$<TARGET_FILE:solver>"
        "${CMAKE_CURRENT_BINARY_DIR}/solver.py"
    DESTINATION
        "epanet/toolkit"
)

install(
    TARGETS
        epanet2 RUNTIME
    DESTINATION
        "epanet/toolkit"
)


set(CMAKE_INSTALL_SYSTEM_RUNTIME_DESTINATION "epanet/toolkit")
include(InstallRequiredSystemLibraries)
