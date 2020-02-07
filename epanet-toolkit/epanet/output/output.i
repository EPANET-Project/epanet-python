/*
 *  output.i - SWIG interface description file for epanet.output package
 *
 *  Created:    9/20/2017
 *
 *  Author:     Michael E. Tryby
 *              US EPA - ORD/NRMRL
 *
*/


%module(package="epanet") output


%include "typemaps.i"


%{
#define SWIG_FILE_WITH_INIT
#include "epanet_output.h"
%}


// RENAME FUNCTIONS ACCORDING TO PEP8
%rename(create_handle)      ENR_createHandle;
%rename(delete_handle)      ENR_deleteHandle;
%rename(close_file)         ENR_closeFile;
%rename(open_file)          ENR_openFile;

%rename(get_version)        ENR_getVersion;
%rename(get_net_size)       ENR_getNetSize;
%rename(get_units)          ENR_getUnits;
%rename(get_times)          ENR_getTimes;
//%rename(get_chem_data)    ENR_getChemData;
%rename(get_elem_name)      ENR_getElementName;
%rename(get_energy_usage)   ENR_getEnergyUsage;
%rename(get_net_reacts)     ENR_getNetReacts;

%rename(node_get_series)    ENR_getNodeSeries;
%rename(link_get_series)    ENR_getLinkSeries;

%rename(node_get_attribute) ENR_getNodeAttribute;
%rename(link_get_attribute) ENR_getLinkAttribute;

%rename(node_get_result)    ENR_getNodeResult;
%rename(link_get_result)    ENR_getLinkResult;

%rename(output_free)        ENR_freeMemory;


/* DEFINE AND TYPEDEF MUST BE INCLUDED */
//typedef struct Handle *ENR_Handle;


%typemap(in,numinputs=0) ENR_Handle* (EN_Project temp) {
    $1 = &temp;
}

%typemap(argout) ENR_Handle* {
  %append_output(SWIG_NewPointerObj(*$1, SWIGTYPE_p_Project, SWIG_POINTER_NEW));
}


/* TYPEMAP FOR IGNORING INT ERROR CODE RETURN VALUE */
%typemap(out) int {
    $result = Py_None;
    Py_INCREF($result);
}

%apply int *OUTPUT{
    int *version,
    int *flag,
    int *value
};


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

%apply (char **string_out, int *slen) {
    (char **name, int *length)
};


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

%apply (float **float_out, int *int_dim) {
    (float **values, int *size),
    (float **series, int *length)
};


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

%apply (int **int_out, int *int_dim) {
    (int **count, int *size)
};


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



/* GENERATES DOCUMENTATION */
%feature("autodoc", "2");


/* INSERTS CUSTOM EXCEPTION HANDLING IN WRAPPER */
%exception
{
    $function
}
/* INSERT EXCEPTION HANDLING FOR THESE FUNCTIONS */

%include "epanet_output.h"

%exception;


/* DEFINE ENUM TYPES */
%include "epanet_output_enums.h"

/* CODE ADDED DIRECTLY TO SWIGGED INTERFACE MODULE */
%pythoncode%{
import enum

class ElementType(enum.Enum):
    NODE         = ENR_node
    LINK         = ENR_link

class Units(enum.Enum):
    FLOW         = ENR_flowUnits
    PRESS        = ENR_pressUnits
    QUAL         = ENR_qualUnits

class FlowUnits(enum.Enum):
    CFS          = ENR_CFS
    GPM          = ENR_GPM
    MGD          = ENR_MGD
    IMGD         = ENR_IMGD
    AFD          = ENR_AFD
    LPS          = ENR_LPS
    LPM          = ENR_LPM
    MLD          = ENR_MLD
    CMH          = ENR_CMH
    CMD          = ENR_CMD

class PressUnits(enum.Enum):
    PSI          = ENR_PSI
    MTR          = ENR_MTR
    KPA          = ENR_KPA

class QualUnits(enum.Enum):
    NONE         = ENR_NONE
    MGL          = ENR_MGL
    UGL          = ENR_UGL
    HOURS        = ENR_HOURS
    PRCNT        = ENR_PRCNT

class Time(enum.Enum):
    REPORT_START = ENR_reportStart
    REPORT_STEP  = ENR_reportStep
    SIM_DURATION = ENR_simDuration
    NUM_PERIODS  = ENR_numPeriods

class NodeAttribute(enum.Enum):
    DEMAND       = ENR_demand
    HEAD         = ENR_head
    PRESSURE     = ENR_pressure
    QUALITY      = ENR_quality

class LinkAttribute(enum.Enum):
    FLOW         = ENR_flow
    VELOCITY     = ENR_velocity
    HEADLOSS     = ENR_headloss
    AVG_QUALITY  = ENR_avgQuality
    STATUS       = ENR_status
    SETTING      = ENR_setting
    RX_RATE      = ENR_rxRate
    FRCTN_FCTR   = ENR_frctnFctr
%}
