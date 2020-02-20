#
#  output_enum.py -
#
#  Created: February 18, 2020
#  Updated:
#
#  Author:     Michael E. Tryby
#              US EPA - ORD/CESER
#


from aenum import Enum, OrderedEnum


class ElementType(Enum, start = 1):
    NODE
    LINK

class UnitTypes(Enum, start = 1):
    FLOW
    PRES
    QUAL

class FlowUnits(OrderedEnum, start = 0):
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

class PresUnits(Enum, start = 0):
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

class BaseUnits(Enum, start = 1):
    FLOW_RATE
    HYD_HEAD
    PRESSURE
    CONCEN
    VELOCITY
    HEADLOSS
    RX_RATE
    UNITLESS
    NONE

class RxUnits(Enum, start = 1):
    MGH
    UGH
