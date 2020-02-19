/*
 *  solver.i - SWIG interface description file for EPANET toolkit
 *
 *  Created:    11/27/2017
 *  Modified:   2/12/2020
 *
 *  Author:     Michael E. Tryby
 *              US EPA - ORD/NRMRL
 *
 *  Build command:
 *    $ swig -I../include -python -py3 solver.i
 *
*/


%include "typemaps.i"
%include "cstring.i"


%module(package="epanet") solver
%{

#define SWIG_FILE_WITH_INIT

#include "epanet2_enums.h"
#include "epanet2_2.h"

%}


/* MARK FUNCTIONS AS ALLOCATING AND DEALLOCATING MEMORY */
%newobject EN_createproject;
%delobject EN_deleteproject;

/* TYPEMAPS FOR PROJECT POINTER */
%typemap(in,numinputs=0) EN_Project* (EN_Project temp) {
    $1 = &temp;
}
%typemap(argout) EN_Project* {
  %append_output(SWIG_NewPointerObj(*$1, SWIGTYPE_p_Project, SWIG_POINTER_NEW));
}


/* TYPEMAP FOR IGNORING INT ERROR CODE RETURN VALUE */
%typemap(out) int {
    $result = Py_None;
    Py_INCREF($result);
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
%apply EnumeratedType {
    EN_NodeProperty,
    EN_LinkProperty,
    EN_TimeParameter,
    EN_AnalysisStatistic,
    EN_CountType,
    EN_NodeType,
    EN_LinkType,
    EN_QualityType,
    EN_SourceType,
    EN_HeadLossType,
    EN_FlowUnits,
    EN_DemandModel,
    EN_Option,
    EN_ControlType,
    EN_StatisticType,
    EN_MixingModel,
    EN_InitHydOption,
    EN_PumpType,
    EN_CurveType,
    EN_ActionCodeType,
    EN_RuleObject,
    EN_RuleVariable,
    EN_RuleOperator,
    EN_RuleStatus,
    EN_StatusReport
};


/* APPLY MACROS FOR OUTPUT VARIABLES */
%apply int *OUTPUT {
    int *count,
    int *version,
    int *units,
    int *qualType,
    int *traceNode,
    int *index,
    int *nodeType,
    int *type,
    int *demandIndex,
    int *numDemands,
    int *patIndex,
    int *linkType,
    int *node1,
    int *node2,
    int *pumpType,
    int *curveIndex,
    int *len,
    int *nPoints,
    int *nodeIndex,
    int *linkIndex,
    int *nPremises,
    int *nThenActions,
    int *nElseActions,
    int *logop,
    int *object,
    int *objIndex,
    int *variable,
    int *relop,
    int *status
};

%apply double *OUTPUT {
    double *value,
    double *x,
    double *y,
    double *baseDemand,
    double *pmin,
    double *preq,
    double *pexp,
    double *setting,
    double *level,
    double *priority
};

%apply long *OUTPUT {
    long *value,
    long *currentTime,
    long *tStep,
    long *timeLeft
};

%cstring_bounded_output(char *OUTCHAR, EN_MAXMSG);

%apply char *OUTCHAR {
    char *out_line1,
    char *out_line2,
    char *out_line3,
    char *out_comment,
    char *out_errmsg,
    char *out_chemName,
    char *out_chemUnits,
    char *out_id,
    char *out_demandName
};

%apply int *INOUT {
    int *inout_index
}


%include "rename.i"


/* GENERATES DOCUMENTATION */
%feature("autodoc", "2");


/* INSERTS CUSTOM EXCEPTION HANDLING IN WRAPPER */
%exception
{
    $function

    if ( result > 10)
    {
        char errmsg[EN_MAXMSG];
        EN_geterror(result, errmsg, EN_MAXMSG);
        PyErr_SetString(PyExc_Exception, errmsg);

    }
    else if (result > 0)
    {
        char errmsg[EN_MAXMSG];
        EN_geterror(result, errmsg, EN_MAXMSG);
        PyErr_WarnEx(PyExc_Warning, errmsg, 2);
    }
}

/* INSERT EXCEPTION HANDLING FOR THESE FUNCTIONS */

%include "epanet2_2.h"

%exception;
