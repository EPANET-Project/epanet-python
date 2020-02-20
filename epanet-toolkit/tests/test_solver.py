#
#  test_solver.py
#
#  Created:    October 19, 2018
#  Author:     Michael E. Tryby
#              US EPA - ORD/NRMRL
#

import os

import pytest
import os.path as osp

from epanet.toolkit import solver, solver_enum


DATA_PATH = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'data')
INPUT_FILE_NET_1 = os.path.join(DATA_PATH, 'Net1.inp')
REPORT_FILE_TEST = os.path.join(DATA_PATH, 'test.rpt')
OUTPUT_FILE_TEST = os.path.join(DATA_PATH, 'test.out')


def test_createdelete():

    _handle = solver.proj_create()
    assert(_handle != None)

    _handle = solver.proj_delete(_handle)
    assert(_handle == None)


def test_run():
    _handle = solver.proj_create()

    solver.proj_run(_handle, INPUT_FILE_NET_1, REPORT_FILE_TEST, OUTPUT_FILE_TEST, None)
    assert osp.isfile(REPORT_FILE_TEST) == True
    assert osp.isfile(OUTPUT_FILE_TEST) == True

    solver.proj_delete(_handle)


def test_openrclose():
    _handle = solver.proj_create()
    solver.proj_open(_handle, INPUT_FILE_NET_1, REPORT_FILE_TEST, OUTPUT_FILE_TEST)

    solver.proj_close(_handle)
    solver.proj_delete(_handle)


def test_savereopen():
    input_file_reopen = os.path.join(DATA_PATH, 'test_reopen.inp')

    _handle = solver.proj_create()

    solver.proj_open(_handle, INPUT_FILE_NET_1, REPORT_FILE_TEST, OUTPUT_FILE_TEST)
    solver.proj_save_file(_handle, input_file_reopen)
    solver.proj_close(_handle)

    _handle = solver.proj_delete(_handle)

    _handle = solver.proj_create()

    solver.proj_open(_handle, input_file_reopen, REPORT_FILE_TEST, OUTPUT_FILE_TEST)
    solver.proj_close(_handle)

    _handle = solver.proj_delete(_handle)


@pytest.fixture()
def handle(request):
    _handle = solver.proj_create()
    solver.proj_open(_handle, INPUT_FILE_NET_1, REPORT_FILE_TEST, OUTPUT_FILE_TEST)

    def close():
        solver.proj_close(_handle)
        solver.proj_delete(_handle)

    request.addfinalizer(close)
    return _handle


def test_hyd_step(handle):
     solver.hydr_open(handle)

     solver.hydr_init(handle, solver_enum.SaveInitOptions.NOSAVE)

     while True:
         time = solver.hydr_run(handle)

         step = solver.hydr_next(handle)

         if not step > 0.:
             break

     solver.hydr_close(handle)


def test_qual_step(handle):
    solver.hydr_solve(handle)

    solver.qual_open(handle)

    solver.qual_init(handle, solver_enum.SaveInitOptions.NOSAVE)

    while True:
        time = solver.qual_run(handle)

        step = solver.qual_next(handle)

        if not step > 0.:
            break

    solver.qual_close(handle)


def test_report(handle):

    nlinks = solver.proj_get_count(handle, solver_enum.CountType.LINKCOUNT)
    assert nlinks == 13

    solver.hydr_solve(handle)
    solver.qual_solve(handle)

    solver.rprt_set(handle, 'NODES ALL')
    solver.rprt_write_results(handle)
    assert osp.isfile(REPORT_FILE_TEST) == True


def test_analysis(handle):
    test_value = [];

    for code in solver_enum.Option:
        test_value.append(solver.anlys_get_option(handle, code))

    funits = solver.anlys_get_flow_units(handle)
    assert funits == solver_enum.FlowUnits.GPM

    test_value.clear()
    ref_value = [86400, 3600, 300, 7200, 0, 3600, 0, 360, 0, 0, 0, 0, 0, 0, 3600, 0]

    for code in solver_enum.TimeParameter:
        test_value.append(solver.anlys_get_time_param(handle, code))
    assert test_value == ref_value

    qualinfo = solver.anlys_get_qual_info(handle)
    assert qualinfo == [solver_enum.QualityType.CHEM, 'Chlorine' ,'mg/L', 0]



def test_node(handle):
    index = solver.node_get_index(handle, '10')
    assert index == 1

    id = solver.node_get_id(handle, index)
    assert id == '10'

    type = solver.node_get_type(handle, index)
    assert type == solver_enum.NodeType.JUNCTION

    coord = solver.node_get_coord(handle, index)
    assert coord == [20.0, 70.0]


def test_demand(handle):
    index = solver.node_get_index(handle, '22')
    count = solver.dmnd_get_count(handle, index)
    assert count == 1

    model = solver.dmnd_get_model(handle)
    assert model == [solver_enum.DemandModel.DDA, 0.0, 0.1, 0.5]

    base = solver.dmnd_get_base(handle, index, count)
    assert base == 200.0

    ptrn = solver.dmnd_get_pattern(handle, index, count)
    assert ptrn == 1

    solver.dmnd_set_name(handle, index, count, 'default')
    name = solver.dmnd_get_name(handle, index, count)
    assert name == 'default'


def test_link(handle):
    index = solver.link_get_index(handle, '10')
    assert index == 1

    id = solver.link_get_id(handle, index)
    assert id == '10'

    type = solver.link_get_type(handle, index)
    assert type == solver_enum.LinkType.PIPE

    nodes = solver.link_get_nodes(handle, index)
    assert nodes == [1, 2]

    test_value = []
    ref_value = [18.0, 10530.0, 100.0, 0.0, 1.0, 100.0, -0.5, -1.0, 0.0, 0.0, 0.0, 0.0]
    for code in range(solver_enum.LinkProperty.SETTING.value):
        test_value.append(solver.link_get_value(handle, index, solver_enum.LinkProperty(code)))
    assert test_value == pytest.approx(ref_value)


def test_pump(handle):
    index = solver.link_get_index(handle, "9")
    assert index == 13

    type = solver.link_get_type(handle, index)
    assert type == solver_enum.LinkType.PUMP

    type = solver.pump_get_type(handle, index)
    assert type == solver_enum.PumpType.POWER_FUNC


def test_pattern(handle):
    index = solver.ptrn_get_index(handle, "1")
    assert index == 1

    length = solver.ptrn_get_length(handle, index)
    assert length == 12

    test_value = []
    ref_value = [1.0, 1.2, 1.4, 1.6, 1.4, 1.2, 1.0, 0.8, 0.6, 0.4, 0.6, 0.8]
    for i in range(1, length+1):
        test_value.append(solver.ptrn_get_value(handle, index, i))
    assert test_value == pytest.approx(ref_value)

    value = solver.ptrn_get_avg_value(handle, index)
    assert value == pytest.approx(1.0)


def test_curve(handle):
    index = solver.curv_get_index(handle, "1")
    assert index == 1

    length = solver.curv_get_length(handle, index)
    assert length == 1

    type = solver.curv_get_type(handle, index)
    assert type == solver_enum.CurveType.PUMP_CURVE

    value = solver.curv_get_value(handle, index, length)
    assert value == [1500.0, 250.0]


def test_simple_control(handle):

    value = solver.scntl_get(handle, 1)
    assert value == [solver_enum.ControlType.LOWLEVEL, 13, 1.0, 11, 110.0]

    value.clear()
    value = solver.scntl_get(handle, 2)
    assert value == [solver_enum.ControlType.HILEVEL, 13, 0.0, 11, 140.0]


WARNING_TEST_INP = os.path.join(DATA_PATH, 'test_warnings.inp')
WARNING_TEST_RPT = os.path.join(DATA_PATH, 'test_warnings.rpt')
WARNING_TEST_OUT = os.path.join(DATA_PATH, 'test_warnings.out')

@pytest.fixture()
def handle_warn(request):
    _handle = solver.proj_create()
    solver.proj_open(_handle, WARNING_TEST_INP, WARNING_TEST_RPT, WARNING_TEST_OUT)

    def close():
        solver.proj_close(_handle)
        solver.proj_delete(_handle)

    request.addfinalizer(close)
    return _handle


import warnings
warnings.simplefilter("default")

def test_hyd_warning(handle_warn):
    with pytest.warns(Warning):
        solver.hydr_open(handle_warn)
        solver.hydr_init(handle_warn, solver_enum.SaveInitOptions.NOSAVE)

        while True:
            time = solver.hydr_run(handle_warn)

            step = solver.hydr_next(handle_warn)

            if not step > 0.:
                break

        solver.hydr_close(handle_warn)


def test_exception(handle_warn):
    with pytest.raises(Exception):
        #solver.hydr_open(handle_warn)
        solver.hydr_init(handle_warn, solver_enum.SaveInitOptions.NOSAVE)

        while True:
            time = solver.hydr_run(handle_warn)

            step = solver.hydr_next(handle_warn)

            if not step > 0.:
                break

        solver.hydr_close(handle_warn)
