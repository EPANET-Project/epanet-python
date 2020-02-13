# -*- coding: utf-8 -*-

#
#  __init__.py - EPANET output package
#
#  Created: August 15, 2018
#  Updated: February 13, 2020
#
#  Author:     Michael E. Tryby
#              US EPA - ORD/NRMRL
#

'''
A low level pythonic API for the epanet-output dll using SWIG.
'''


__author__ = "Michael Tryby"
__copyright__ = "None"
__credits__ = "Maurizio Cingi"
__license__ = "CC0 1.0 Universal"

__version__ = "0.3.0"
__date__ = "February 13, 2020"

__maintainer__ = "Michael Tryby"
__email__ = "tryby.michael@epa.gov"
__status  = "Development"


from aenum import Enum

from epanet.output import output


class Units(Enum, start = 1):
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


class OutputMetadata():
    '''
    Simple attribute name and unit lookup.
    '''

    _unit_labels_us_ = {
        Units.HYD_HEAD:         "ft",
        Units.VELOCITY:         "ft/sec",
        Units.HEADLOSS:         "ft/1000ft",
        Units.UNITLESS:         "unitless",
        Units.NONE:             "",

        output.FlowUnits.CFS:   "cu ft/s",
        output.FlowUnits.GPM:   "gal/min",
        output.FlowUnits.MGD:   "M gal/day",
        output.FlowUnits.IMGD:  "M Imp gal/day",
        output.FlowUnits.AFD:   "ac ft/day",

        output.PressUnits.PSI:  "psi"
    }

    _unit_labels_si_ = {
        Units.HYD_HEAD:         "m",
        Units.VELOCITY:         "m/sec",
        Units.HEADLOSS:         "m/Km",
        Units.UNITLESS:         "unitless",
        Units.NONE:             "",

        output.FlowUnits.LPS:   "L/sec",
        output.FlowUnits.LPM:   "L/min",
        output.FlowUnits.MLD:   "M L/day",
        output.FlowUnits.CMH:   "cu m/hr",
        output.FlowUnits.CMD:   "cu m/day",

        output.PressUnits.MTR:  "meters",
        output.PressUnits.KPA:  "kPa"
    }

    _unit_labels_quality_ = {
        RxUnits.MGH:            "mg/hr",
        RxUnits.UGH:            "ug/hr",

        output.QualUnits.NONE:  "",
        output.QualUnits.MGL:   "mg/L",
        output.QualUnits.UGL:   "ug/L",
        output.QualUnits.HOURS: "hrs",
        output.QualUnits.PRCNT: "%"
    }


    def __init__(self, output_handle):

        self.units = list()
        # If outputhandle not initialized use default settings
        if output_handle == None:
            self.units = [output.FlowUnits.GPM.value,
                          output.PressUnits.PSI.value,
                          output.QualUnits.NONE.value]
        # Else quary the output api for unit settings
        else:
            for u in output.Units:
                self.units.append(output.get_units(output_handle, u))

        # Convert unit settings to enums
        self._flow = output.FlowUnits(self.units[0])
        self._press = output.PressUnits(self.units[1])
        self._qual = output.QualUnits(self.units[2])

        # Determine unit system from flow setting
        if self._flow.value <= output.FlowUnits.AFD.value:
            self._unit_labels = type(self)._unit_labels_us_
        else:
            self._unit_labels = type(self)._unit_labels_si_
        self._unit_labels.update(type(self)._unit_labels_quality_)

        # Determine mass units from quality settings
        if self._qual == output.QualUnits.MGL:
            self._rx_rate = RxUnits.MGH
        elif self._qual == output.QualUnits.UGL:
            self._rx_rate = RxUnits.UGH
        else:
            self._rx_rate = Units.NONE


        self._metadata = {
            output.NodeAttribute.DEMAND:      ("Demand",          self._unit_labels[self._flow]),
            output.NodeAttribute.HEAD:        ("Head",            self._unit_labels[Units.HYD_HEAD]),
            output.NodeAttribute.PRESSURE:    ("Pressure",        self._unit_labels[self._press]),
            output.NodeAttribute.QUALITY:     ("Quality",         self._unit_labels[self._qual]),

            output.LinkAttribute.FLOW:        ("Flow",            self._unit_labels[self._flow]),
            output.LinkAttribute.VELOCITY:    ("Velocity",        self._unit_labels[Units.VELOCITY]),
            output.LinkAttribute.HEADLOSS:    ("Unit Headloss",   self._unit_labels[Units.HEADLOSS]),
            output.LinkAttribute.AVG_QUALITY: ("Quality",         self._unit_labels[self._qual]),
            output.LinkAttribute.STATUS:      ("Status",          self._unit_labels[Units.NONE]),
            output.LinkAttribute.SETTING:     ("Setting",         self._unit_labels[Units.NONE]),
            output.LinkAttribute.RX_RATE:     ("Reaction Rate",   self._unit_labels[self._rx_rate]),
            output.LinkAttribute.FRCTN_FCTR:  ("Friction Factor", self._unit_labels[Units.UNITLESS])
        }


    def get_attribute_metadata(self, attribute):
        '''
        Takes an attribute enum and returns a tuple with name and units.
        '''
        return self._metadata[attribute]


# Units of Measurement
#
# Units                     US Customary             SI Metric
#   Concentration              mg/L                     mg/L
#                              ug/L                     ug/L
#   Demand                     flow                     flow
#   Diameter                   in                       mm
#   Efficiency                 percent                  percent
#   Elevation                  feet                     meters
#   Emitter Coefficient        flow/(psi)^1/2           flow/(meters)^1/2
#   Energy                     kilowatt-hours           kilowatt-hours
#   Flow                       CFS                      LPS
#                              GPM                      LPM
#                              MGD                      MLD
#                              IMGD                     CMH
#                              AFD                      CMD
#   Friction Factor            unitless                 unitless
#   Hydraulic Head             feet                     meters
#   Length                     feet                     meters
#   Minor Loss Coefficient     unitless                 unitless
#   Power                      horsepower               kilowatts
#   Pressure                   psi                      meters
#   Reaction Coeff (Bulk)      1/day (1st-order)        1/day
#   Reaction Coeff (Wall)      mass/L/day (0th-order)   mass/L/day
#                              ft/day (1st-order)       meters/day (1st-order)
#   Roughness Coeff            10^-3 feet (DW)          mm (DW)
#                              unitless                 unitless
#   Source Mass Injection      mass/min                 mass/min
#   Velocity                   feet/sec                 meters/sec
#   Volume                     cubic feet               cubic meters
#   Water Age                  hours                    hours
