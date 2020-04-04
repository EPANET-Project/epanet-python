# epanet-toolkit

`epanet-toolkit` contains SWIG generated Python wrappers for the epanet-solver and epanet-output libraries.


## Features

`epanet-toolkit` makes EPANET a fully fledged Python extension with:  

 - Python integration at the speed of C
 - Full access to library APIs
 - Pythonic naming, enums, exceptions, and return value handling


## Installation


## Basic Usage

Run an EPANET simulation.
```
from epanet.toolkit import solver

handle = solver.proj_create()

solver.proj_run(handle, 'input_file.inp', 'report_file.rpt', 'output_file.out', None)

solver.proj_delete(handle)
```
