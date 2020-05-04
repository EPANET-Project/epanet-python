#
#  output_metadata.py -
#
#  Created: February 20, 2020
#  Updated:
#
#  Author:     Michael E. Tryby
#              US EPA - ORD/CESER
#


from epanet.toolkit import output, output_enum


class OutputMetadata():
    '''
    Simple attribute name and unit lookup.
    '''

    _unit_labels_us_ = {
        output_enum.BaseUnits.HYD_HEAD: "ft",
        output_enum.BaseUnits.VELOCITY: "ft/sec",
        output_enum.BaseUnits.HEADLOSS: "ft/1000ft",
        output_enum.BaseUnits.UNITLESS: "unitless",
        output_enum.BaseUnits.NONE:     "",

        output_enum.FlowUnits.CFS:      "cu ft/s",
        output_enum.FlowUnits.GPM:      "gal/min",
        output_enum.FlowUnits.MGD:      "M gal/day",
        output_enum.FlowUnits.IMGD:     "M Imp gal/day",
        output_enum.FlowUnits.AFD:      "ac ft/day",

        output_enum.PresUnits.PSI:      "psi"
    }


    _unit_labels_si_ = {
        output_enum.BaseUnits.HYD_HEAD: "m",
        output_enum.BaseUnits.VELOCITY: "m/sec",
        output_enum.BaseUnits.HEADLOSS: "m/Km",
        output_enum.BaseUnits.UNITLESS: "unitless",
        output_enum.BaseUnits.NONE:     "",

        output_enum.FlowUnits.LPS:      "L/sec",
        output_enum.FlowUnits.LPM:      "L/min",
        output_enum.FlowUnits.MLD:      "M L/day",
        output_enum.FlowUnits.CMH:      "cu m/hr",
        output_enum.FlowUnits.CMD:      "cu m/day",

        output_enum.PresUnits.MTR:      "meters",
        output_enum.PresUnits.KPA:      "kPa"
    }

    _unit_labels_quality_ = {
        output_enum.RxUnits.MGH:        "mg/hr",
        output_enum.RxUnits.UGH:        "ug/hr",

        output_enum.QualUnits.NONE:     "",
        output_enum.QualUnits.MGL:      "mg/L",
        output_enum.QualUnits.UGL:      "ug/L",
        output_enum.QualUnits.HOURS:    "hrs",
        output_enum.QualUnits.PRCNT:    "%"
    }


    def __init__(self, output_handle):
        # If outputhandle not initialized use default settings
        if output_handle is None:
            self._units = {
                output_enum.UnitTypes.FLOW: output_enum.FlowUnits.GPM,
                output_enum.UnitTypes.PRES: output_enum.PresUnits.PSI,
                output_enum.UnitTypes.QUAL: output_enum.QualUnits.NONE
            }
        # Else quary the output api for unit settings
        else:
            self._units = {}
            for u in output_enum.UnitTypes:
                self._units[u] = output.get_units(output_handle, u)

        # Determine unit system from flow setting
        if self._units[output_enum.UnitTypes.FLOW] <= output_enum.FlowUnits.AFD:
            self._unit_labels = type(self)._unit_labels_us_
        else:
            self._unit_labels = type(self)._unit_labels_si_

        self._unit_labels.update(type(self)._unit_labels_quality_)

        # Determine mass units from quality settings
        if self._units[output_enum.UnitTypes.QUAL] == output_enum.QualUnits.MGL:
            self._rx_rate = output_enum.RxUnits.MGH
        elif self._units[output_enum.UnitTypes.QUAL] == output_enum.QualUnits.UGL:
            self._rx_rate = output_enum.RxUnits.UGH
        else:
            self._rx_rate = output_enum.BaseUnits.NONE


        self._metadata = {
            output_enum.NodeAttribute.DEMAND:
                ("Demand", self._unit_labels[self._units[output_enum.UnitTypes.FLOW]]),
            output_enum.NodeAttribute.HEAD:
                ("Head", self._unit_labels[output_enum.BaseUnits.HYD_HEAD]),
            output_enum.NodeAttribute.PRESSURE:
                ("Pressure", self._unit_labels[self._units[output_enum.UnitTypes.PRES]]),
            output_enum.NodeAttribute.QUALITY:
                ("Quality", self._unit_labels[self._units[output_enum.UnitTypes.QUAL]]),

            output_enum.LinkAttribute.FLOW:
                ("Flow", self._unit_labels[self._units[output_enum.UnitTypes.FLOW]]),
            output_enum.LinkAttribute.VELOCITY:
                ("Velocity", self._unit_labels[output_enum.BaseUnits.VELOCITY]),
            output_enum.LinkAttribute.HEADLOSS:
                ("Unit Headloss", self._unit_labels[output_enum.BaseUnits.HEADLOSS]),
            output_enum.LinkAttribute.AVG_QUALITY:
                ("Quality", self._unit_labels[self._units[output_enum.UnitTypes.QUAL]]),
            output_enum.LinkAttribute.STATUS:
                ("Status", self._unit_labels[output_enum.BaseUnits.NONE]),
            output_enum.LinkAttribute.SETTING:
                ("Setting", self._unit_labels[output_enum.BaseUnits.NONE]),
            output_enum.LinkAttribute.RX_RATE:
                ("Reaction Rate", self._unit_labels[self._rx_rate]),
            output_enum.LinkAttribute.FRCTN_FCTR:
                ("Friction Factor", self._unit_labels[output_enum.BaseUnits.UNITLESS])
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
