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


%module(package="epanet.toolkit") output
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
%typemap(in,numinputs=0) ENR_Handle *p_handle (ENR_Handle temp) {
    $1 = &temp;
}
/* used for functions that take in an opaque pointer (or NULL)
and return a (possibly) different pointer */
%typemap(argout) ENR_Handle *p_handle {
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
        float *temp = *$1;
        PyObject *o = PyList_New(*$2);
        for(int i=0; i<*$2; i++) {
            PyList_SetItem(o, i, PyFloat_FromDouble((double)temp[i]));
        }
        $result = SWIG_Python_AppendOutput($result, o);
        ENR_freeMemory(*$1);
    }
}


/* TYPEMAPS FOR MEMORY MANAGEMENT OF INT ARRAYS */
%typemap(in, numinputs=0)int **int_out (int *temp), int *int_dim (int temp){
    $1 = &temp;
}
%typemap(argout) (int **int_out, int *int_dim) {
    if (*$1) {
        long *temp = (long *)*$1;
        PyObject *o = PyList_New(*$2);
        for(int i=0; i<*$2; i++) {
            PyList_SetItem(o, i, PyInt_FromLong(temp[i]));
        }
        $result = SWIG_Python_AppendOutput($result, o);
        ENR_freeMemory(*$1);
    }
}


/* TYPEMAP FOR ENUMERATED TYPE INPUT ARGUMENTS */
%typemap(in) EnumTypeIn {
    int value = 0;
    if (PyObject_HasAttrString($input, "value")) {
        PyObject *o = PyObject_GetAttrString($input, "value");
        SWIG_AsVal_int(o, &value);
    }
    $1 = ($1_basetype)(value);
}
%apply EnumTypeIn {
    ENR_ElementType,
    ENR_UnitTypes,
    ENR_Time,
    ENR_NodeAttribute,
    ENR_LinkAttribute
}


/* TYPEMAP SPECIFICALLY FOR ENR_getUnits */
%typemap(in, numinputs=0) int *enum_out (int temp) {
    $1 = &temp;
}
%typemap(argout) int *enum_out {
    char *units;
    PyObject *module = PyImport_ImportModule("epanet.toolkit.output_enum");
    if (arg2 == ENR_flowUnits)     units = "FlowUnits";
    else if(arg2 == ENR_presUnits) units = "PresUnits";
    else if(arg2 == ENR_qualUnits) units = "QualUnits";
    else units = NULL;
    PyObject *function = PyDict_GetItemString(PyModule_GetDict(module), units);
    if (PyCallable_Check(function)) {
        PyObject *units = PyObject_CallFunction(function, "i", *$1);
        %append_output(units);
    }
}


/* TYPEMAP FOR INTEGER OUTPUT */
%apply int *OUTPUT {
    int *version,
    int *link_index
}


/* RENAME FUNCTIONS PYTHON STYLE */
//%rename("%(regex:/^\w+_([a-zA-Z]+)/\L\\1/)s") "";
%include "output_rename.i"

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
