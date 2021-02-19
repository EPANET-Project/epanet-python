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


class ElementType(Enum):
    NODE = 1
    LINK = 2


class UnitTypes(Enum):
    FLOW = 1
    PRES = 2
    QUAL = 3


class FlowUnits(OrderedEnum):
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


class PresUnits(Enum):
    PSI = 0
    MTR = 1
    KPA = 2


class QualUnits(Enum):
    NONE  = 0
    MGL   = 1
    UGL   = 2
    HOURS = 3
    PRCNT = 4


class Time(Enum):
    REPORT_START = 1
    REPORT_STEP  = 2
    SIM_DURATION = 3
    NUM_PERIODS  = 4


class NodeAttribute(Enum):
    DEMAND   = 1
    HEAD     = 2
    PRESSURE = 3
    QUALITY  = 4


class LinkAttribute(Enum):
    FLOW        = 1
    VELOCITY    = 2
    HEADLOSS    = 3
    AVG_QUALITY = 4
    STATUS      = 5
    SETTING     = 6
    RX_RATE     = 7
    FRCTN_FCTR  = 8


class BaseUnits(Enum, start=1):
    FLOW_RATE = 1
    HYD_HEAD  = 2
    PRESSURE  = 3
    CONCEN    = 4
    VELOCITY  = 5
    HEADLOSS  = 6
    RX_RATE   = 7
    UNITLESS  = 8
    NONE      = 9


class RxUnits(Enum):
    MGH = 1
    UGH = 2
