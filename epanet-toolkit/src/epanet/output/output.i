/*
 *  epanet_output.i - SWIG interface description file for EPANET Output API
 *
 *  Created:    9/20/2017
 *  Updated:    2/13/2020
 *
 *  Author:     Michael E. Tryby
 *              US EPA - ORD/NRMRL
 *
*/


%include "typemaps.i"
%include "cstring.i"


%module(package="epanet") output
%{
#define SWIG_FILE_WITH_INIT

#include "epanet_output_enums.h"
#include "epanet_output.h"
%}


/* MARK FUNCTIONS FOR ALLOCATING AND DEALLOCATING HANDLES */
%newobject ENR_createHandle;
%delobject ENR_deleteHandle;

/* TYPEMAPS FOR HANDLE POINTER */
/* Used for functions that output a new opaque pointer */
%typemap(in,numinputs=0) ENR_Handle *p_handle_out (ENR_Handle temp) {
    $1 = &temp;
}
/* used for functions that take in an opaque pointer (or NULL)
and return a (possibly) different pointer */
%typemap(argout) ENR_Handle *p_handle_out {
    %append_output(SWIG_NewPointerObj(*$1, SWIGTYPE_p_Handle, SWIG_POINTER_NEW));
}


/* TYPEMAP FOR IGNORING INT ERROR CODE RETURN VALUE */
%typemap(out) int {
    $result = Py_None;
    Py_INCREF($result);
}


/* TYPEMAP FOR MEMORY MANAGEMENT AND ENCODING OF STRINGS */
%cstring_output_allocate_size(char **string_out, int *slen, ENR_freeMemory(*$1));
%cstring_output_allocate(char **msg_buffer, ENR_freeMemory(*$1));


/* TYPEMAPS FOR MEMORY MANAGEMNET OF FLOAT ARRAYS */
%typemap(in, numinputs=0)float **float_out (float *temp), int *int_dim (int temp){
   $1 = &temp;
}
%typemap(argout) (float **float_out, int *int_dim) {
    if (*$1) {
      PyObject *o = PyList_New(*$2);
      int i;
      float *temp = *$1;
      for(i=0; i<*$2; i++) {
        PyList_SetItem(o, i, PyFloat_FromDouble((double)temp[i]));
      }
      $result = SWIG_Python_AppendOutput($result, o);
      free(*$1);
    }
}


/* TYPEMAPS FOR MEMORY MANAGEMENT OF INT ARRAYS */
%typemap(in, numinputs=0)int **int_out (long *temp), int *int_dim (int temp){
   $1 = &temp;
}
%typemap(argout) (int **int_out, int *int_dim) {
    if (*$1) {
      PyObject *o = PyList_New(*$2);
      int i;
      long* temp = *$1;
      for(i=0; i<*$2; i++) {
        PyList_SetItem(o, i, PyInt_FromLong(temp[i]));
      }
      $result = SWIG_Python_AppendOutput($result, o);
      free(*$1);
    }
}


/* TYPEMAP FOR ENUMERATED TYPES */
%typemap(in) EnumeratedType (int val, int ecode = 0) {
    if (PyObject_HasAttrString($input,"value")) {
        PyObject *o;
        o = PyObject_GetAttrString($input, "value");
        ecode = SWIG_AsVal_int(o, &val);
    }
    else {
        SWIG_exception_fail(SWIG_ArgError(ecode), "in method '" "$symname" "', argument " "$argnum"" of type '" "$ltype""'");
    }

    $1 = ($1_type)(val);
}
%apply EnumeratedType {
    ENR_ElementType,
    ENR_Units,
    ENR_Time,
    ENR_NodeAttribute,
    ENR_LinkAttribute
}


/* RENAME FUNCTIONS PYTHON STYLE */
//%rename("%(regex:/^\w+_([a-zA-Z]+)/\L\\1/)s") "";
%include "rename.i"

/* GENERATES DOCUMENTATION */
%feature("autodoc", "2");


/* INSERTS CUSTOM EXCEPTION HANDLING IN WRAPPER */
%exception ENR_createHandle
{
    char *err_msg = NULL;
    $function
    ENR_getError(result, &err_msg);
    if (err_msg)
        PyErr_SetString(PyExc_Exception, err_msg);
    ENR_freeMemory(err_msg);
}

%exception ENR_deleteHandle
{
    char *err_msg = NULL;
    $function
    ENR_getError(result, &err_msg);
    if (err_msg)
        PyErr_SetString(PyExc_Exception, err_msg);
    ENR_freeMemory(err_msg);
}

%exception
{
    char *err_msg = NULL;

    $function

    ENR_getError(result, &err_msg);

    if (result > 10)
        PyErr_SetString(PyExc_Exception, err_msg);
    else if (result > 0)
        PyErr_WarnEx(PyExc_Warning, err_msg, 2);

    ENR_freeMemory(err_msg);
}
/* INSERT EXCEPTION HANDLING FOR THESE FUNCTIONS */

%ignore ENR_getError;
%ignore ENR_freeMemory;

%include "epanet_output.h"

%exception;


/* CODE ADDED DIRECTLY TO SWIGGED INTERFACE MODULE */
%pythoncode%{

from aenum import Enum

class ElementType(Enum, start = 1):
    NODE
    LINK

class Units(Enum, start = 1):
    FLOW
    PRESS
    QUAL

class FlowUnits(Enum, start = 0):
    CFS
    GPM
    MGD
    IMGD
    AFD
    LPS
    LPM
    MLD
    CMH
    CMD

class PressUnits(Enum, start = 0):
    PSI
    MTR
    KPA

class QualUnits(Enum, start = 0):
    NONE
    MGL
    UGL
    HOURS
    PRCNT

class Time(Enum, start = 1):
    REPORT_START
    REPORT_STEP
    SIM_DURATION
    NUM_PERIODS

class NodeAttribute(Enum, start = 1):
    DEMAND
    HEAD
    PRESSURE
    QUALITY

class LinkAttribute(Enum, start = 1):
    FLOW
    VELOCITY
    HEADLOSS
    AVG_QUALITY
    STATUS
    SETTING
    RX_RATE
    FRCTN_FCTR
%}
