#
# CMakeLists.txt - CMake configuration file for epanet.output python package
#
# Created:   Feb 6, 2020
# Modified:
#
# Author: Michael E. Tryby
#         US EPA ORD/CESER
#


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
        "$<TARGET_FILE:output>"
        "${CMAKE_CURRENT_BINARY_DIR}/output.py"
    DESTINATION
        "epanet/output"
)

install(
    TARGETS
        epanet-output RUNTIME
    DESTINATION
        "epanet/output"
)


set(CMAKE_INSTALL_SYSTEM_RUNTIME_DESTINATION "epanet/output")
include(InstallRequiredSystemLibraries)
