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


/* DECLARE EPANET PROJECT POINTER */
typedef struct Project *EN_Project;


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


/* MARK FUNCTIONS AS ALLOCATING AND DEALLOCATING MEMORY */
%newobject EN_createproject;
%delobject EN_deleteproject;


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


/* CODE ADDED DIRECTLY TO SWIGGED INTERFACE MODULE */
%pythoncode%{

from aenum import IntEnum

class NodeProperty(IntEnum, start = 0):
    ELEVATION
    BASEDEMAND
    PATTERN
    EMITTER
    INITQUAL
    SOURCEQUAL
    SOURCEPAT
    SOURCETYPE
    TANKLEVEL
    DEMAND
    HEAD
    PRESSURE
    QUALITY
    SOURCEMASS
    INITVOLUME
    MIXMODEL
    MIXZONEVOL
    TANKDIAM
    MINVOLUME
    VOLCURVE
    MINLEVEL
    MAXLEVEL
    MIXFRACTION
    TANK_KBULK
    TANKVOLUME
    MAXVOLUME


class LinkProperty(IntEnum, start = 0):
    DIAMETER
    LENGTH
    ROUGHNESS
    MINORLOSS
    INITSTATUS
    INITSETTING
    KBULK
    KWALL
    FLOW
    VELOCITY
    HEADLOSS
    STATUS
    SETTING
    ENERGY
    LINKQUAL
    LINKPATTERN
    PUMP_STATE
    PUMP_EFFIC
    PUMP_POWER
    PUMP_HCURVE
    PUMP_ECURVE
    PUMP_ECOST
    PUMP_EPAT


class TimeParameter(IntEnum, start = 0):
    DURATION
    HYDSTEP
    QUALSTEP
    PATTERNSTEP
    PATTERNSTART
    REPORTSTEP
    REPORTSTART
    RULESTEP
    STATISTIC
    PERIODS
    STARTTIME
    HTIME
    QTIME
    HALTFLAG
    NEXTEVENT
    NEXTEVENTTANK


class AnalysisStatistic(IntEnum, start = 0):
    ITERATIONS
    RELATIVEERROR
    MAXHEADERROR
    MAXFLOWCHANGE
    MASSBALANCE
    DEFICIENTNODES
    DEMANDREDUCTION


class ObjectType(IntEnum, start = 0):
    NODE
    LINK
    TIMEPAT
    CURVE
    CONTROL
    RULE


class CountType(IntEnum, start = 0):
    NODECOUNT
    TANKCOUNT
    LINKCOUNT
    PATCOUNT
    CURVECOUNT
    CONTROLCOUNT
    RULECOUNT


class NodeType(IntEnum, start = 0):
    JUNCTION
    RESERVOIR
    TANK


class LinkType(IntEnum, start = 0):
    CVPIPE
    PIPE
    PUMP
    PRV
    PSV
    PBV
    FCV
    TCV
    GPV


class LinkStatusType(IntEnum, start = 0):
    CLOSED
    OPEN


class PumpStatusType(IntEnum):
    PUMP_XHEAD      = 0
    PUMP_CLOSED     = 2
    PUMP_OPEN       = 3
    PUMP_XFLOW      = 5


class QualityType(IntEnum, start = 0):
    NONE
    CHEM
    AGE
    TRACE


class SourceType(IntEnum, start = 0):
    CONCEN
    MASS
    SETPOINT
    FLOWPACED


class HeadLossType(IntEnum, start = 0):
    HW
    DW
    CM


class FlowUnits(IntEnum, start = 0):
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


class DemandModel(IntEnum, start = 0):
    DDA
    PDA


class Option(IntEnum, start = 0):
    TRIALS
    ACCURACY
    TOLERANCE
    EMITEXPON
    DEMANDMULT
    HEADERROR
    FLOWCHANGE
    HEADLOSSFORM
    GLOBALEFFIC
    GLOBALPRICE
    GLOBALPATTERN
    DEMANDCHARGE
    SP_GRAVITY
    SP_VISCOS
    UNBALANCED
    CHECKFREQ
    MAXCHECK
    DAMPLIMIT
    SP_DIFFUS
    BULKORDER
    WALLORDER
    TANKORDER
    CONCENLIMIT


class ControlType(IntEnum, start = 0):
    LOWLEVEL
    HILEVEL
    TIMER
    TIMEOFDAY


class StatisticType(IntEnum, start = 0):
    SERIES
    AVERAGE
    MINIMUM
    MAXIMUM
    RANGE


class MixingModel(IntEnum, start = 0):
    MIX1
    MIX2
    FIFO
    LIFO


class InitHydOption(IntEnum):
    NOSAVE        = 0
    SAVE          = 1
    INITFLOW      = 10
    SAVE_AND_INIT = 11


class PumpType(IntEnum, start = 0):
    CONST_HP
    POWER_FUNC
    CUSTOM
    NOCURVE


class CurveType(IntEnum, start = 0):
    VOLUME_CURVE
    PUMP_CURVE
    EFFIC_CURVE
    HLOSS_CURVE
    GENERIC_CURVE


class ActionCodeType(IntEnum, start = 0):
    UNCONDITIONAL
    CONDITIONAL


class StatusReport(IntEnum, start = 0):
    NO_REPORT
    NORMAL_REPORT
    FULL_REPORT


class RuleObject(IntEnum):
    R_NODE      = 6
    R_LINK      = 7
    R_SYSTEM    = 8


class RuleVariable(IntEnum, start = 0):
    R_DEMAND
    R_HEAD
    R_GRADE
    R_LEVEL
    R_PRESSURE
    R_FLOW
    R_STATUS
    R_SETTING
    R_POWER
    R_TIME
    R_CLOCKTIME
    R_FILLTIME
    R_DRAINTIME


class RuleOperator(IntEnum, start = 0):
    R_EQ
    R_NE
    R_LE
    R_GE
    R_LT
    R_GT
    R_IS
    R_NOT
    R_BELOW
    R_ABOVE


class RuleStatus(IntEnum, start = 1):
    R_IS_OPEN
    R_IS_CLOSED
    R_IS_ACTIVE
%}
