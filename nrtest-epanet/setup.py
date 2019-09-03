# -*- coding: utf-8 -*-

#
#  setup.py
#
#  Created on  Aug 30, 2016
#  Modified on Sept 3, 2019
#
#  Author:     Michael E. Tryby
#              US EPA - ORD/NRMRL
#
#  Build:
#    \>python setup.py bdist_wheel
#
''' Setup up script for nrtest_epanet package. '''


from setuptools import setup


entry_points = {
    'nrtest.compare': [
        'epanet allclose = nrtest_epanet:epanet_allclose_compare',
        'epanet mincdd = nrtest_epanet:epanet_mincdd_compare',
        'epanet report = nrtest_epanet:epanet_report_compare',
        # Add entry point for new comparison functions here
    ]
}

setup(
    name='nrtest-epanet',
    version='0.6.0',
    description="EPANET extension for nrtest",

    author="Michael E. Tryby",
    author_email='tryby.michael@epa.gov',
    url='https://github.com/USEPA',

    packages=['nrtest_epanet',],
    scripts=['scripts/report-diff',],

    entry_points=entry_points,

    install_requires=[
        'header_detail_footer>=2.3',
        'nrtest>=0.2.4',
        'numpy>=1.7.0',
        'epanet.output'
    ],
    keywords='nrtest_epanet',
    classifiers=[
        'Programming Language :: Python :: 3'
    ],
)
