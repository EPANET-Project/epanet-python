# epanet-toolkit


`epanet-toolkit` is a SWIG generated Python wrapper for the epanet-solver and epanet-output libraries. 


## Features

`epanet-toolkit` makes EPANET a fully fledged Python extension with:  

 - full access to the epanet-solver and epanet-output library APIs
 - Python integration at the speed of C
 - EPANET warning and error codes thrown as Python exceptions
 - Pythonic naming and return value handling
 - enhanced support for enumerated types 
 

## Installation


## Basic Usage

```
from epanet.toolkit import solver

handle = solver.proj_create()

solver.proj_run(handle,  'input_file.inp', `report_file.rpt`, `output_file.out`, None)

solver.proj_delete(handle)
```
