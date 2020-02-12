#
# CMakeLists.txt - CMake configuration file for epanet.solver python package
#
# Created:   Feb 6, 2020
# Modified:
#
# Author: Michael E. Tryby
#         US EPA ORD/CESER
#


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
        "__init__.py"
        "$<TARGET_FILE:solver>"
        "${CMAKE_CURRENT_BINARY_DIR}/solver.py"
    DESTINATION
        "epanet/solver"
)

install(
    TARGETS
        epanet2 RUNTIME
    DESTINATION
        "epanet/solver"
)


set(CMAKE_INSTALL_SYSTEM_RUNTIME_DESTINATION "epanet/solver")
include(InstallRequiredSystemLibraries)
