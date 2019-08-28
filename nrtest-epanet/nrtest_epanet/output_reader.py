# -*- coding: utf-8 -*-

#
#  output_reader.py
#
#  Date Created:  Aug 31, 2016
#  Date Modified: Aug 28, 2019
#
#  Author:       Michael E. Tryby
#                US EPA - ORD/NRMRL
#
'''
The module output_reader provides the class used to implement the output
generator.
'''

# project import
from epanet.output import output as oapi


def output_generator(path_ref):
    '''
    The output_generator is designed to iterate over an EPANET binary file and
    yield element attributes. It is useful for comparing contents of binary
    files for numerical regression testing.

    The generator yields a Python tuple containing an array of element
    attributes and a tuple containing the element type, period, and attribute.

    Arguments:
        path_ref - path to result file

    Raises:
        Exception()
        ...
    '''
    with OutputReader(path_ref) as br:

        for period_index in range(0, br.report_periods()):
            for element_type in oapi.ElementType:
                for attribute in br.elementAttributes[element_type]:

                    yield (br.element_attribute(element_type, period_index, attribute),
                           (element_type, period_index, attribute))


class OutputReader(object):
    '''
    Provides a minimal API used to implement output_generator.
    '''
    def __init__(self, filename):
        self.filepath = filename
        self.handle = None
        self.elementAttributes = {oapi.ElementType.NODE: oapi.NodeAttribute,
                                 oapi.ElementType.LINK: oapi.LinkAttribute}

        self.getElementAttribute = {oapi.ElementType.NODE: oapi.getnodeattribute,
                                    oapi.ElementType.LINK: oapi.getlinkattribute}

    def __enter__(self):
        self.handle = oapi.init()
        oapi.open(self.handle, self.filepath)
        return self

    def __exit__(self, type, value, traceback):
        oapi.close(self.handle)

    def report_periods(self):
        return oapi.gettimes(self.handle, oapi.Time.NUM_PERIODS)

    def element_attribute(self, element_type, time_index, attribute):
        return self.getElementAttribute[element_type](self.handle, time_index, attribute)
