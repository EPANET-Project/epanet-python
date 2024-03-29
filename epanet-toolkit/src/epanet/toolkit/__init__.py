#
#  __init__.py - EPANET toolkit package
#
#  Created: August 15, 2018
#  Updated: February 20, 2020
#
#  Author:     Michael E. Tryby
#              US EPA - ORD/NRMRL
#

'''
A low level pythonic API for the epanet-solver and epanet-output dlls.
'''


__author__ = "Michael E. Tryby"
__copyright__ = "None"
__credits__ = "Maurizio Cingi"
__license__ = "CC0 1.0 Universal"

__version__ = "0.5.0"
__date__ = "February 20, 2020"

__maintainer__ = "Michael E. Tryby"
__email__ = "tryby.michael@epa.gov"
__status__ = "Development"


import os
import platform


# Adds directory containing epanet libraries to path
if platform.system() == "Windows":
    libdir = os.path.join(os.path.dirname(__file__), "../../epanet_toolkit")

    if hasattr(os, 'add_dll_directory'):
        os.add_dll_directory(libdir)
    else:
        os.environ["PATH"] = libdir + ";" + os.environ["PATH"]
