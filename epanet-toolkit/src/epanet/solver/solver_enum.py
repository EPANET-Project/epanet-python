# -*- coding: utf-8 -*-

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


class NodeProperty(Enum, start = 0):
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


class LinkProperty(Enum, start = 0):
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


class TimeParameter(Enum, start = 0):
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


class AnalysisStatistic(Enum, start = 0):
    ITERATIONS
    RELATIVEERROR
    MAXHEADERROR
    MAXFLOWCHANGE
    MASSBALANCE
    DEFICIENTNODES
    DEMANDREDUCTION


class ObjectType(Enum, start = 0):
    NODE
    LINK
    TIMEPAT
    CURVE
    CONTROL
    RULE


class CountType(Enum, start = 0):
    NODECOUNT
    TANKCOUNT
    LINKCOUNT
    PATCOUNT
    CURVECOUNT
    CONTROLCOUNT
    RULECOUNT


class NodeType(Enum, start = 0):
    JUNCTION
    RESERVOIR
    TANK


class LinkType(Enum, start = 0):
    CVPIPE
    PIPE
    PUMP
    PRV
    PSV
    PBV
    FCV
    TCV
    GPV


class LinkStatusType(Enum, start = 0):
    CLOSED
    OPEN


class PumpStatusType(Enum):
    PUMP_XHEAD      = 0
    PUMP_CLOSED     = 2
    PUMP_OPEN       = 3
    PUMP_XFLOW      = 5


class QualityType(Enum, start = 0):
    NONE
    CHEM
    AGE
    TRACE


class SourceType(Enum, start = 0):
    CONCEN
    MASS
    SETPOINT
    FLOWPACED


class HeadLossType(Enum, start = 0):
    HW
    DW
    CM


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


class DemandModel(Enum, start = 0):
    DDA
    PDA


class Option(Enum, start = 0):
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


class ControlType(Enum, start = 0):
    LOWLEVEL
    HILEVEL
    TIMER
    TIMEOFDAY


class StatisticType(Enum, start = 0):
    SERIES
    AVERAGE
    MINIMUM
    MAXIMUM
    RANGE


class MixingModel(Enum, start = 0):
    MIX1
    MIX2
    FIFO
    LIFO


class SaveInitOptions(Enum):
    NOSAVE        = 0
    SAVE          = 1
    INITFLOW      = 10
    SAVE_AND_INIT = 11


class PumpType(Enum, start = 0):
    CONST_HP
    POWER_FUNC
    CUSTOM
    NOCURVE


class CurveType(Enum, start = 0):
    VOLUME_CURVE
    PUMP_CURVE
    EFFIC_CURVE
    HLOSS_CURVE
    GENERIC_CURVE


class ActionCodeType(Enum, start = 0):
    UNCONDITIONAL
    CONDITIONAL


class StatusReport(Enum, start = 0):
    NO_REPORT
    NORMAL_REPORT
    FULL_REPORT


class RuleObject(Enum):
    R_NODE      = 6
    R_LINK      = 7
    R_SYSTEM    = 8


class RuleVariable(Enum, start = 0):
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


class RuleOperator(Enum, start = 0):
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


class RuleStatus(Enum, start = 1):
    R_IS_OPEN
    R_IS_CLOSED
    R_IS_ACTIVE
