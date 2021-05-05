#
#   test_metadata.py
#
#   Created:  May 5, 2021
#   Modified:
#
#   Author:    See AUTHORS
#
#   Unit testing for EPANET output metadata using pytest.
#


import os

import pytest

from epanet.toolkit import output, output_enum, output_metadata


DATA_PATH = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'data')
OUTPUT_FILE_EXAMPLE1 = os.path.join(DATA_PATH, 'test_Net1.out')


@pytest.fixture()
def handle(request):
    _handle = output.create_handle()
    output.open_file(_handle, OUTPUT_FILE_EXAMPLE1)

    def close():
        output.close_file(_handle)
        output.delete_handle(_handle)

    request.addfinalizer(close)
    return _handle


def test_output_metadata(handle):

    om = output_metadata.OutputMetadata(handle)

    ref = {
        output_enum.NodeAttribute.DEMAND:      ("Demand",          "gal/min"),
        output_enum.NodeAttribute.HEAD:        ("Head",            "ft"),
        output_enum.NodeAttribute.PRESSURE:    ("Pressure",        "psi"),
        output_enum.NodeAttribute.QUALITY:     ("Quality",         "mg/L"),

        output_enum.LinkAttribute.FLOW:        ("Flow",            "gal/min"),
        output_enum.LinkAttribute.VELOCITY:    ("Velocity",        "ft/sec"),
        output_enum.LinkAttribute.HEADLOSS:    ("Unit Headloss",   "ft/1000ft"),
        output_enum.LinkAttribute.AVG_QUALITY: ("Quality",         "mg/L"),
        output_enum.LinkAttribute.STATUS:      ("Status",          ""),
        output_enum.LinkAttribute.SETTING:     ("Setting",         ""),
        output_enum.LinkAttribute.RX_RATE:     ("Reaction Rate",   "mg/hr"),
        output_enum.LinkAttribute.FRCTN_FCTR:  ("Friction Factor", "unitless")}

    for attr in output_enum.NodeAttribute:
        temp = om.get_attribute_metadata(attr)
        assert temp == ref[attr]

    for attr in output_enum.LinkAttribute:
        temp = om.get_attribute_metadata(attr)
        assert temp == ref[attr]
