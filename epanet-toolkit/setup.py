# -*- coding: utf-8 -*-

#
# setup.py - Setup script for epanet-toolkit python package
#
# Created:    7/2/2018
# Modified:   2/6/2020
#
# Author:     Michael E. Tryby
#             US EPA - ORD/NRMRL
#
# Usage:
#   python setup.py build -- -G"Visual Studio 15 2017 Win64" ..
#


from skbuild import setup


setup(
    name = 'epanet-toolkit',
    version = '0.5.0',

    package_dir={"":"epanet"},
    packages=['epanet.solver', 'epanet.output'],
    py_modules = ['solver', 'output'],

    package_data = {'epanet.solver':['*solver.*', '*.dylib', '*.dll', '*.so'],
                    'epanet.output':['*output.*', '*.dylib', '*.dll', '*.so']},

    zip_safe=False
)
