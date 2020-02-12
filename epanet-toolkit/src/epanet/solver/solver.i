/*
 *  solver.i - SWIG interface description file for EPANET toolkit
 *
 *  Created:    11/27/2017
 *  Modified:   2/7/2020
 *
 *  Author:     Michael E. Tryby
 *              US EPA - ORD/NRMRL
 *
 *  Build command:
 *    $ swig -I../include -python -py3 solver.i
 *
*/

%module(package="epanet") solver


%include "typemaps.i"
%include "cstring.i"


%{
#define SWIG_FILE_WITH_INIT
#include "epanet2_2.h"
%}


// RENAME FUNCTIONS ACCORDING TO PEP8
%rename(proj_create)              EN_createproject;
%rename(proj_delete)              EN_deleteproject;
%rename(proj_run)                 EN_runproject;
%rename(proj_init)                EN_init;
%rename(proj_open)                EN_open;
%rename(proj_get_title)           EN_gettitle;
%rename(proj_set_title)           EN_settitle;
%rename(proj_get_comment)         EN_getcomment;
%rename(proj_set_comment)         EN_setcomment;
%rename(proj_get_count)           EN_getcount;
%rename(proj_save_file)           EN_saveinpfile;
%rename(proj_close)               EN_close;

%rename(hydr_solve)               EN_solveH;
%rename(hydr_save)                EN_saveH;
%rename(hydr_open)                EN_openH;
%rename(hydr_init)                EN_initH;
%rename(hydr_run)                 EN_runH;
%rename(hydr_next)                EN_nextH;
%rename(hydr_close)               EN_closeH;
%rename(hydr_save_file)           EN_savehydfile;
%rename(hydr_use_file)            EN_usehydfile;

%rename(qual_solve)               EN_solveQ;
%rename(qual_open)                EN_openQ;
%rename(qual_init)                EN_initQ;
%rename(qual_run)                 EN_runQ;
%rename(qual_next)                EN_nextQ;
%rename(qual_step)                EN_stepQ;
%rename(qual_close)               EN_closeQ;

%rename(rprt_write_line)          EN_writeline;
%rename(rprt_write_results)       EN_report;
%rename(rprt_copy)                EN_copyreport;
%rename(rprt_clear)               EN_clearreport;
%rename(rprt_reset)               EN_resetreport;
%rename(rprt_set)                 EN_setreport;
%rename(rprt_set_level)           EN_setstatusreport;
%rename(rprt_anlys_stats)         EN_getstatistic;
%rename(rprt_get_result_index)    EN_getresultindex;

%rename(anlys_get_option)         EN_getoption;
%rename(anlys_set_option)         EN_setoption;
%rename(anlys_get_flow_units)     EN_getflowunits;
%rename(anlys_set_flow_units)     EN_setflowunits;
%rename(anlys_get_time_param)     EN_gettimeparam;
%rename(anlys_set_time_param)     EN_settimeparam;
%rename(anlys_get_qual_info)      EN_getqualinfo;
%rename(anlys_get_qual_type)      EN_getqualtype;
%rename(anlys_set_qual_type)      EN_setqualtype;

%rename(node_add)                 EN_addnode;
%rename(node_delete)              EN_deletenode;
%rename(node_get_index)           EN_getnodeindex;
%rename(node_get_id)              EN_getnodeid;
%rename(node_set_id)              EN_setnodeid;
%rename(node_get_type)            EN_getnodetype;
%rename(node_get_value)           EN_getnodevalue;
%rename(node_set_value)           EN_setnodevalue;
%rename(node_set_junc_data)       EN_setjuncdata;
%rename(node_set_tank_data)       EN_settankdata;
%rename(node_get_coord)           EN_getcoord;
%rename(node_set_coord)           EN_setcoord;

%rename(dmnd_get_model)           EN_getdemandmodel;
%rename(dmnd_set_model)           EN_setdemandmodel;
%rename(dmnd_add)                 EN_adddemand;
%rename(dmnd_delete)              EN_deletedemand;
%rename(demd_get_index)           EN_getdemandindex;
%rename(dmnd_get_count)           EN_getnumdemands;
%rename(dmnd_get_base)            EN_getbasedemand;
%rename(dmnd_set_base)            EN_setbasedemand;
%rename(dmnd_get_pattern)         EN_getdemandpattern;
%rename(dmnd_set_pattern)         EN_setdemandpattern;
%rename(dmnd_get_name)            EN_getdemandname;
%rename(dmnd_set_name)            EN_setdemandname;

%rename(link_add)                 EN_addlink;
%rename(link_delete)              EN_deletelink;
%rename(link_get_index)           EN_getlinkindex;
%rename(link_get_id)              EN_getlinkid;
%rename(link_set_id)              EN_setlinkid;
%rename(link_get_type)            EN_getlinktype;
%rename(link_set_type)            EN_setlinktype;
%rename(link_get_nodes)           EN_getlinknodes;
%rename(link_set_nodes)           EN_setlinknodes;
%rename(link_get_value)           EN_getlinkvalue;
%rename(link_set_value)           EN_setlinkvalue;
%rename(link_set_pipe_data)       EN_setpipedata;
%rename(link_get_vertex_count)    EN_getvertexcount;
%rename(link_get_vertex)          EN_getvertex;
%rename(link_set_vertices)        EN_setvertices;

%rename(pump_get_type)            EN_getpumptype;
%rename(pump_get_curve_index)     EN_getheadcurveindex;
%rename(pump_set_curve_index)     EN_setheadcurveindex;

%rename(ptrn_add)                 EN_addpattern;
%rename(ptrn_delete)              EN_deletepattern;
%rename(ptrn_get_index)           EN_getpatternindex;
%rename(ptrn_get_id)              EN_getpatternid;
%rename(ptrn_set_id)              EN_setpatternid;
%rename(ptrn_get_length)          EN_getpatternlen;
%rename(ptrn_get_value)           EN_getpatternvalue;
%rename(ptrn_set_value)           EN_setpatternvalue;
%rename(ptrn_get_avg_value)       EN_getaveragepatternvalue;
%rename(ptrn_set)                 EN_setpattern;

%rename(curv_add)                 EN_addcurve;
%rename(curv_delete)              EN_deletecurve;
%rename(curv_get_index)           EN_getcurveindex;
%rename(curv_get_id)              EN_getcurveid;
%rename(curve_set_id)             EN_setcurveid;
%rename(curv_get_length)          EN_getcurvelen;
%rename(curv_get_type)            EN_getcurvetype;
%rename(curv_get_value)           EN_getcurvevalue;
%rename(curv_set_value)           EN_setcurvevalue;
%rename(curv_get)                 EN_getcurve;
%rename(curv_set)                 EN_setcurve;

%rename(scntl_add)                EN_addcontrol;
%rename(scntl_delete)             EN_deletecontrol;
%rename(scntl_get)                EN_getcontrol;
%rename(scntl_set)                EN_setcontrol;

%rename(rcntl_add)                EN_addrule;
%rename(rcntl_delete)             EN_deleterule;
%rename(rcntl_get)                EN_getrule;
%rename(rcntl_get_id)             EN_getruleID;
%rename(rcntl_get_premise)        EN_getpremise;
%rename(rcntl_set_premise)        EN_setpremise;
%rename(rcntl_set_premise_index)  EN_setpremiseindex;
%rename(rcntl_set_premise_status) EN_setpremisestatus;
%rename(rcntl_set_premise_value)  EN_setpremisevalue;
%rename(rcntl_get_then_action)    EN_getthenaction;
%rename(rcntl_set_then_action)    EN_setthenaction;
%rename(rcntl_get_else_action)    EN_getelseaction;
%rename(rcntl_set_else_action)    EN_setelseaction;
%rename(rcntl_set_rule_priority)  EN_setrulepriority;

%rename(solver_get_error)         EN_getrerror;
%rename(solver_get_version)       EN_getversion;


/* DECLARE EPANET PROJECT POINTER */
//typedef struct Project *EN_Project;


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
%apply EnumeratedType {EN_NodeProperty, EN_LinkProperty, EN_TimeParameter,
    EN_AnalysisStatistic, EN_CountType, EN_NodeType, EN_LinkType, EN_QualityType,
    EN_SourceType, EN_HeadLossType, EN_FlowUnits, EN_DemandModel, EN_Option,
    EN_ControlType, EN_StatisticType, EN_MixingModel, EN_InitHydOption, EN_PumpType,
    EN_CurveType, EN_ActionCodeType, EN_RuleObject, EN_RuleVariable,
    EN_RuleOperator, EN_RuleStatus, EN_StatusReport};


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
%newobject proj_create;
%delobject proj_delete;


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


/* DEFINE ENUM TYPES */
%include "epanet2_enums.h"


/* CODE ADDED DIRECTLY TO SWIGGED INTERFACE MODULE */
%pythoncode%{

import enum

class NodeProperty(enum.Enum):
    ELEVATION   = EN_ELEVATION
    BASEDEMAND  = EN_BASEDEMAND
    PATTERN     = EN_PATTERN
    EMITTER     = EN_EMITTER
    INITQUAL    = EN_INITQUAL
    SOURCEQUAL  = EN_SOURCEQUAL
    SOURCEPAT   = EN_SOURCEPAT
    SOURCETYPE  = EN_SOURCETYPE
    TANKLEVEL   = EN_TANKLEVEL
    DEMAND      = EN_DEMAND
    HEAD        = EN_HEAD
    PRESSURE    = EN_PRESSURE
    QUALITY     = EN_QUALITY
    SOURCEMASS  = EN_SOURCEMASS
    INITVOLUME  = EN_INITVOLUME
    MIXMODEL    = EN_MIXMODEL
    MIXZONEVOL  = EN_MIXZONEVOL
    TANKDIAM    = EN_TANKDIAM
    MINVOLUME   = EN_MINVOLUME
    VOLCURVE    = EN_VOLCURVE
    MINLEVEL    = EN_MINLEVEL
    MAXLEVEL    = EN_MAXLEVEL
    MIXFRACTION = EN_MIXFRACTION
    TANK_KBULK  = EN_TANK_KBULK
    TANKVOLUME  = EN_TANKVOLUME
    MAXVOLUME   = EN_MAXVOLUME


class LinkProperty(enum.Enum):
    DIAMETER        = EN_DIAMETER
    LENGTH          = EN_LENGTH
    ROUGHNESS       = EN_ROUGHNESS
    MINORLOSS       = EN_MINORLOSS
    INITSTATUS      = EN_INITSTATUS
    INITSETTING     = EN_INITSETTING
    KBULK           = EN_KBULK
    KWALL           = EN_KWALL
    FLOW            = EN_FLOW
    VELOCITY        = EN_VELOCITY
    HEADLOSS        = EN_HEADLOSS
    STATUS          = EN_STATUS
    SETTING         = EN_SETTING
    ENERGY          = EN_ENERGY
    LINKQUAL        = EN_LINKQUAL
    LINKPATTERN     = EN_LINKPATTERN
    PUMP_STATE      = EN_PUMP_STATE
    PUMP_EFFIC      = EN_PUMP_EFFIC
    PUMP_POWER      = EN_PUMP_POWER
    PUMP_HCURVE     = EN_PUMP_HCURVE
    PUMP_ECURVE     = EN_PUMP_ECURVE
    PUMP_ECOST      = EN_PUMP_ECOST
    PUMP_EPAT       = EN_PUMP_EPAT


class TimeParameter(enum.Enum):
    DURATION     = EN_DURATION
    HYDSTEP      = EN_HYDSTEP
    QUALSTEP     = EN_QUALSTEP
    PATTERNSTEP  = EN_PATTERNSTEP
    PATTERNSTART = EN_PATTERNSTART
    REPORTSTEP   = EN_REPORTSTEP
    REPORTSTART  = EN_REPORTSTART
    RULESTEP     = EN_RULESTEP
    STATISTIC    = EN_STATISTIC
    PERIODS      = EN_PERIODS
    STARTTIME    = EN_STARTTIME
    HTIME        = EN_HTIME
    QTIME        = EN_QTIME
    HALTFLAG     = EN_HALTFLAG
    NEXTEVENT    = EN_NEXTEVENT
    NEXTEVENTTANK = EN_NEXTEVENTTANK


class AnalysisStatistic(enum.Enum):
    ITERATIONS    = EN_ITERATIONS
    RELATIVEERROR = EN_RELATIVEERROR
    MAXHEADERROR  = EN_MAXHEADERROR
    MAXFLOWCHANGE = EN_MAXFLOWCHANGE
    MASSBALANCE   = EN_MASSBALANCE


class CountType(enum.Enum):
    NODES         = EN_NODECOUNT
    TANKS         = EN_TANKCOUNT
    LINKS         = EN_LINKCOUNT
    PTRNS         = EN_PATCOUNT
    CURVS         = EN_CURVECOUNT
    CNTLS         = EN_CONTROLCOUNT
    RULES         = EN_RULECOUNT


class NodeType(enum.Enum):
    JUNCTION    = EN_JUNCTION
    RESERVOIR   = EN_RESERVOIR
    TANK        = EN_TANK


class LinkType(enum.Enum):
    CVPIPE       = EN_CVPIPE
    PIPE         = EN_PIPE
    PUMP         = EN_PUMP
    PRV          = EN_PRV
    PSV          = EN_PSV
    PBV          = EN_PBV
    FCV          = EN_FCV
    TCV          = EN_TCV
    GPV          = EN_GPV


class QualityType(enum.Enum):
    NONE        = EN_NONE
    CHEM        = EN_CHEM
    AGE         = EN_AGE
    TRACE       = EN_TRACE


class SourceType(enum.Enum):
    CONCEN      = EN_CONCEN
    MASS        = EN_MASS
    SETPOINT    = EN_SETPOINT
    FLOWPACED   = EN_FLOWPACED


class HeadLossType(enum.Enum):
    HW          = EN_HW
    DW          = EN_DW
    CM          = EN_CM


class FlowUnits(enum.Enum):
    CFS         = EN_CFS
    GPM         = EN_GPM
    MGD         = EN_MGD
    IMGD        = EN_IMGD
    AFD         = EN_AFD
    LPS         = EN_LPS
    LPM         = EN_LPM
    MLD         = EN_MLD
    CMH         = EN_CMH
    CMD         = EN_CMD


class DemandModel(enum.Enum):
    DDA         = EN_DDA
    PDA         = EN_PDA


class Option(enum.Enum):
    TRIALS         = 0
    ACCURACY       = 1
    TOLERANCE      = 2
    EMITEXPON      = 3
    DEMANDMULT     = 4
    HEADERROR      = 5
    FLOWCHANGE     = 6
    HEADLOSSFORM   = 7
    GLOBALEFFIC    = 8
    GLOBALPRICE    = 9
    GLOBALPATTERN  = 10
    DEMANDCHARGE   = 11
    SP_GRAVITY     = 12
    SP_VISCOS      = 13
    UNBALANCED     = 14
    CHECKFREQ      = 15
    MAXCHECK       = 16
    DAMPLIMIT      = 17
    SP_DIFFUS      = 18
    BULKORDER      = 19
    WALLORDER      = 20
    TANKORDER      = 21
    CONCENLIMIT    = 22


class ControlType(enum.Enum):
    LOWLEVEL    = EN_LOWLEVEL
    HILEVEL     = EN_HILEVEL
    TIMER       = EN_TIMER
    TIMEOFDAY   = EN_TIMEOFDAY


class StatisticType(enum.Enum):
    SERIES      = EN_SERIES
    AVERAGE     = EN_AVERAGE
    MINIMUM     = EN_MINIMUM
    MAXIMUM     = EN_MAXIMUM
    RANGE       = EN_RANGE


class MixingModel(enum.Enum):
    MIX1        = EN_MIX1
    MIX2        = EN_MIX2
    FIFO        = EN_FIFO
    LIFO        = EN_LIFO


class SaveOption(enum.Enum):
    NOSAVE        = EN_NOSAVE
    SAVE          = EN_SAVE
    INITFLOW      = EN_INITFLOW
    SAVE_AND_INIT = EN_SAVE_AND_INIT


class PumpType(enum.Enum):
    CONST_HP    = EN_CONST_HP
    POWER_FUNC  = EN_POWER_FUNC
    CUSTOM      = EN_CUSTOM
    NOCURVE     = EN_NOCURVE


class CurveType(enum.Enum):
    VOLUME_CURVE  = EN_VOLUME_CURVE
    PUMP_CURVE    = EN_PUMP_CURVE
    EFFIC_CURVE   = EN_EFFIC_CURVE
    HLOSS_CURVE   = EN_HLOSS_CURVE
    GENERIC_CURVE = EN_GENERIC_CURVE


class ActionCode(enum.Enum):
    UNCONDITIONAL = EN_UNCONDITIONAL
    CONDITIONAL   = EN_CONDITIONAL


class RuleObject(enum.Enum):
    R_NODE      = EN_R_NODE
    R_LINK      = EN_R_LINK
    R_SYSTEM    = EN_R_SYSTEM


class RuleVariable(enum.Enum):
    R_DEMAND    = EN_R_DEMAND
    R_HEAD      = EN_R_HEAD
    R_GRADE     = EN_R_GRADE
    R_LEVEL     = EN_R_LEVEL
    R_PRESSURE  = EN_R_PRESSURE
    R_FLOW      = EN_R_FLOW
    R_STATUS    = EN_R_STATUS
    R_SETTING   = EN_R_SETTING
    R_POWER     = EN_R_POWER
    R_TIME      = EN_R_TIME
    R_CLOCKTIME = EN_R_CLOCKTIME
    R_FILLTIME  = EN_R_FILLTIME
    R_DRAINTIME = EN_R_DRAINTIME


class RuleOperator(enum.Enum):
    R_EQ        = EN_R_EQ
    R_NE        = EN_R_NE
    R_LE        = EN_R_LE
    R_GE        = EN_R_GE
    R_LT        = EN_R_LT
    R_GT        = EN_R_GT
    R_IS        = EN_R_IS
    R_NOT       = EN_R_NOT
    R_BELOW     = EN_R_BELOW
    R_ABOVE     = EN_R_ABOVE


class RuleStatus(enum.Enum):
    R_IS_OPEN   = EN_R_IS_OPEN
    R_IS_CLOSED = EN_R_IS_CLOSED
    R_IS_ACTIVE = EN_R_IS_ACTIVE


class StatusReport(enum.Enum):
    NO_REPORT     = EN_NO_REPORT
    NORMAL_REPORT = EN_NORMAL_REPORT
    FULL_REPORT   = EN_FULL_REPORT

%}
