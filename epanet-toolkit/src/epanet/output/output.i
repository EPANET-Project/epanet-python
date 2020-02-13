/*
 *  epanet_output.i - SWIG interface description file for EPANET Output API
 *
 *  Created:    9/20/2017
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

//-DSWIG_PYTHON_SILENT_MEMLEAK
typedef struct Handle *ENR_Handle;


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

/* TYPEMAPS FOR INT ARGUMENT AS RETURN VALUE */
%typemap(in, numinputs=0) int* int_out (int temp) {
    $1 = &temp;
}
%typemap(argout) int* int_out {
    %append_output(PyInt_FromLong(*$1));
}

/* TYPEMAP FOR MEMORY MANAGEMENT AND ENCODING OF STRINGS */
%typemap(in, numinputs=0)char** string_out (char* temp), int* slen (int temp){
   $1 = &temp;
}
%typemap(argout)(char** string_out, int* slen) {
    if (*$1) {
        PyObject* o;
        o = PyUnicode_FromStringAndSize(*$1, *$2);

        $result = SWIG_Python_AppendOutput($result, o);
        free(*$1);
    }
}

/* TYPEMAPS FOR MEMORY MANAGEMNET OF FLOAT ARRAYS */
%typemap(in, numinputs=0)float** float_out (float* temp), int* int_dim (int temp){
   $1 = &temp;
}
%typemap(argout) (float** float_out, int* int_dim) {
    if (*$1) {
      PyObject *o = PyList_New(*$2);
      int i;
      float* temp = *$1;
      for(i=0; i<*$2; i++) {
        PyList_SetItem(o, i, PyFloat_FromDouble((double)temp[i]));
      }
      $result = SWIG_Python_AppendOutput($result, o);
      free(*$1);
    }
}

/* TYPEMAPS FOR MEMORY MANAGEMENT OF INT ARRAYS */
%typemap(in, numinputs=0)int** int_out (long* temp), int* int_dim (int temp){
   $1 = &temp;
}
%typemap(argout) (int** int_out, int* int_dim) {
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
        PyObject* o;
        o = PyObject_GetAttrString($input, "value");
        ecode = SWIG_AsVal_int(o, &val);
    }
    else {
        SWIG_exception_fail(SWIG_ArgError(ecode), "in method '" "$symname" "', argument " "$argnum"" of type '" "$ltype""'");
    }

    $1 = ($1_type)(val);
}
%apply EnumeratedType {ENR_ElementType, ENR_Units, ENR_Time, ENR_NodeAttribute, ENR_LinkAttribute}


/* TYPEMAP FOR STRING ALLOCATED IN EPANET AND RETURNED AS char ** */
%cstring_output_allocate(char **msg_buffer, ENR_freeMemory(*$1));


/* MARK FUNCTIONS AS ALLOCATING AND DEALLOCATING HANDLES */
%newobject ENR_createHandle;
%delobject ENR_deleteHandle;


/* RENAME FUNCTIONS PYTHON STYLE */
//%rename("%(regex:/^\w+_([a-zA-Z]+)/\L\\1/)s") "";
%include "rename.i"

/* GENERATES DOCUMENTATION */
%feature("autodoc", "2");


/* INSERTS CUSTOM EXCEPTION HANDLING IN WRAPPER */
%exception
{
    char* err_msg;

    ENR_clearError(arg1);
    $function
    if (ENR_checkError(arg1, &err_msg))
    {
        PyErr_SetString(PyExc_Exception, err_msg);
        ENR_freeMemory(err_msg);
    	SWIG_fail;
    }
}
/* INSERT EXCEPTION HANDLING FOR THESE FUNCTIONS */


int ENR_getVersion(ENR_Handle p_handle, int* int_out);
int ENR_getNetSize(ENR_Handle p_handle, int** int_out, int* int_dim);
int ENR_getUnits(ENR_Handle p_handle, ENR_Units t_enum, int* int_out);
int ENR_getTimes(ENR_Handle p_handle, ENR_Time t_enum, int* int_out);
int ENR_getElementName(ENR_Handle p_handle, ENR_ElementType t_enum,
		int elementIndex, char** string_out, int* slen);
int ENR_getEnergyUsage(ENR_Handle p_handle, int pumpIndex,
		int* int_out, float** float_out, int* int_dim);
int ENR_getNetReacts(ENR_Handle p_handle, float** float_out, int* int_dim);

int ENR_getNodeSeries(ENR_Handle p_handle_in, int nodeIndex, ENR_NodeAttribute t_enum,
    int startPeriod, int endPeriod, float** float_out, int* int_dim);
int ENR_getLinkSeries(ENR_Handle p_handle_in, int linkIndex, ENR_LinkAttribute t_enum,
    int startPeriod, int endPeriod, float** float_out, int* int_dim);

int ENR_getNodeAttribute(ENR_Handle p_handle, int periodIndex,
    ENR_NodeAttribute t_enum, float** float_out, int* int_dim);
int ENR_getLinkAttribute(ENR_Handle p_handle, int periodIndex,
    ENR_LinkAttribute t_enum, float** float_out, int* int_dim);

int ENR_getNodeResult(ENR_Handle p_handle_in, int periodIndex,
    int nodeIndex, float** float_out, int* int_dim);
int ENR_getLinkResult(ENR_Handle p_handle_in, int periodIndex,
    int linkIndex, float** float_out, int* int_dim);

%exception;

/* NO EXCEPTION HANDLING FOR THESE FUNCTIONS */
int ENR_createHandle(ENR_Handle *p_handle_out);
int ENR_openFile(ENR_Handle p_handle, const char* path);

int ENR_closeFile(ENR_Handle p_handle);
int ENR_deleteHandle(ENR_Handle p_handle);

void ENR_freeMemory(void *memory);

void ENR_clearError(ENR_Handle p_handle);
int ENR_checkError(ENR_Handle p_handle, char **msg_buffer);


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
