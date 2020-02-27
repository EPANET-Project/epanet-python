# epanet-toolkit


`epanet-toolkit` is a SWIG generated Python wrapper for the epanet-solver and epanet-output libraries. 


## Features

`epanet-toolkit` makes EPANET a fully fledged Python extension. 

 - Full access to the epanet-solver and epanet-output library APIs
 - Python integration at the speed of C
 - Pythonic warnings and exceptions
 - Enhanced support for enumerated types 
 
## Installation


## Basic Usage

```
from epanet.toolkit import solver

handle = solver.proj_create()

solver.proj_open(handle, 'input_file.inp', `report_file.rpt`, `output_file.out`)
solver.proj_close(handle)

solver.proj_delete(handle)
```
