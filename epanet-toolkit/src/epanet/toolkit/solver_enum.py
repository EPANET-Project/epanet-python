#
#  solver_enum.py -
#
#  Created: February 19, 2020
#  Updated:
#
#  Author:     Michael E. Tryby
#              US EPA - ORD/CESER
#


from aenum import Enum


class NodeProperty(Enum):
    ELEVATION   = 0
    BASEDEMAND  = 1
    PATTERN     = 2
    EMITTER     = 3
    INITQUAL    = 4
    SOURCEQUAL  = 5
    SOURCEPAT   = 6
    SOURCETYPE  = 7
    TANKLEVEL   = 8
    DEMAND      = 9
    HEAD        = 10
    PRESSURE    = 11
    QUALITY     = 12
    SOURCEMASS  = 13
    INITVOLUME  = 14
    MIXMODEL    = 15
    MIXZONEVOL  = 16
    TANKDIAM    = 17
    MINVOLUME   = 18
    VOLCURVE    = 19
    MINLEVEL    = 20
    MAXLEVEL    = 21
    MIXFRACTION = 22
    TANK_KBULK  = 23
    TANKVOLUME  = 24
    MAXVOLUME   = 25


class LinkProperty(Enum):
    DIAMETER    = 0
    LENGTH      = 1
    ROUGHNESS   = 2
    MINORLOSS   = 3
    INITSTATUS  = 4
    INITSETTING = 5
    KBULK       = 6
    KWALL       = 7
    FLOW        = 8
    VELOCITY    = 9
    HEADLOSS    = 10
    STATUS      = 11
    SETTING     = 12
    ENERGY      = 13
    LINKQUAL    = 14
    LINKPATTERN = 15
    PUMP_STATE  = 16
    PUMP_EFFIC  = 17
    PUMP_POWER  = 18
    PUMP_HCURVE = 19
    PUMP_ECURVE = 20
    PUMP_ECOST  = 21
    PUMP_EPAT   = 22


class TimeParameter(Enum):
    DURATION      = 0
    HYDSTEP       = 1
    QUALSTEP      = 2
    PATTERNSTEP   = 3
    PATTERNSTART  = 4
    REPORTSTEP    = 5
    REPORTSTART   = 6
    RULESTEP      = 7
    STATISTIC     = 8
    PERIODS       = 9
    STARTTIME     = 10
    HTIME         = 11
    QTIME         = 12
    HALTFLAG      = 13
    NEXTEVENT     = 14
    NEXTEVENTTANK = 15


class AnalysisStatistic(Enum):
    ITERATIONS      = 0
    RELATIVEERROR   = 1
    MAXHEADERROR    = 2
    MAXFLOWCHANGE   = 3
    MASSBALANCE     = 4
    DEFICIENTNODES  = 5
    DEMANDREDUCTION = 6


class ObjectType(Enum):
    NODE    = 0
    LINK    = 1
    TIMEPAT = 2
    CURVE   = 3
    CONTROL = 4
    RULE    = 5


class CountType(Enum):
    NODECOUNT    = 0
    TANKCOUNT    = 1
    LINKCOUNT    = 2
    PATCOUNT     = 3
    CURVECOUNT   = 4
    CONTROLCOUNT = 5
    RULECOUNT    = 6


class NodeType(Enum):
    JUNCTION  = 0
    RESERVOIR = 1
    TANK      = 2


class LinkType(Enum):
    CVPIPE = 0
    PIPE   = 1
    PUMP   = 2
    PRV    = 3
    PSV    = 4
    PBV    = 5
    FCV    = 6
    TCV    = 7
    GPV    = 8


class LinkStatusType(Enum):
    CLOSED = 0
    OPEN   = 1


class PumpStatusType(Enum):
    PUMP_XHEAD  = 0
    PUMP_CLOSED = 2
    PUMP_OPEN   = 3
    PUMP_XFLOW  = 5


class QualityType(Enum):
    NONE  = 0
    CHEM  = 1
    AGE   = 2
    TRACE = 3


class SourceType(Enum):
    CONCEN    = 1
    MASS      = 2
    SETPOINT  = 3 
    FLOWPACED = 4


class HeadLossType(Enum):
    HW = 0
    DW = 1
    CM = 2


class FlowUnits(Enum):
    CFS  = 0
    GPM  = 1
    MGD  = 2
    IMGD = 3
    AFD  = 4
    LPS  = 5
    LPM  = 6
    MLD  = 7
    CMH  = 8
    CMD  = 9


class DemandModel(Enum):
    DDA = 0
    PDA = 1


class Option(Enum):
    TRIALS        = 0
    ACCURACY      = 1
    TOLERANCE     = 2
    EMITEXPON     = 3
    DEMANDMULT    = 4
    HEADERROR     = 5
    FLOWCHANGE    = 6
    HEADLOSSFORM  = 7
    GLOBALEFFIC   = 8
    GLOBALPRICE   = 9
    GLOBALPATTERN = 10
    DEMANDCHARGE  = 11
    SP_GRAVITY    = 12
    SP_VISCOS     = 13
    UNBALANCED    = 14
    CHECKFREQ     = 15
    MAXCHECK      = 16
    DAMPLIMIT     = 17
    SP_DIFFUS     = 18
    BULKORDER     = 19
    WALLORDER     = 20
    TANKORDER     = 21
    CONCENLIMIT   = 22


class ControlType(Enum):
    LOWLEVEL  = 0
    HILEVEL   = 1
    TIMER     = 2
    TIMEOFDAY = 3


class StatisticType(Enum):
    SERIES  = 0
    AVERAGE = 1
    MINIMUM = 2
    MAXIMUM = 3
    RANGE   = 4


class MixingModel(Enum):
    MIX1 = 0
    MIX2 = 1
    FIFO = 2
    LIFO = 3


class SaveInitOptions(Enum):
    NOSAVE        = 0
    SAVE          = 1
    INITFLOW      = 10
    SAVE_AND_INIT = 11


class PumpType(Enum):
    CONST_HP   = 0
    POWER_FUNC = 1
    CUSTOM     = 2
    NOCURVE    = 3


class CurveType(Enum):
    VOLUME_CURVE  = 0
    PUMP_CURVE    = 1
    EFFIC_CURVE   = 2
    HLOSS_CURVE   = 3
    GENERIC_CURVE = 4


class ActionCodeType(Enum):
    UNCONDITIONAL = 0
    CONDITIONAL   = 1


class StatusReport(Enum):
    NO_REPORT     = 0
    NORMAL_REPORT = 1
    FULL_REPORT   = 2


class RuleObject(Enum):
    R_NODE   = 6
    R_LINK   = 7
    R_SYSTEM = 8


class RuleVariable(Enum):
    R_DEMAND    = 0
    R_HEAD      = 1
    R_GRADE     = 2
    R_LEVEL     = 3
    R_PRESSURE  = 4
    R_FLOW      = 5
    R_STATUS    = 6
    R_SETTING   = 7
    R_POWER     = 8
    R_TIME      = 9
    R_CLOCKTIME = 10
    R_FILLTIME  = 11
    R_DRAINTIME = 12


class RuleOperator(Enum):
    R_EQ    = 0
    R_NE    = 1
    R_LE    = 2
    R_GE    = 3
    R_LT    = 4
    R_GT    = 5
    R_IS    = 6
    R_NOT   = 7
    R_BELOW = 8
    R_ABOVE = 9


class RuleStatus(Enum):
    R_IS_OPEN   = 1
    R_IS_CLOSED = 2
    R_IS_ACTIVE = 3
