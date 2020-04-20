#
# setup.py - Setup script for epanet-toolkit python package
#
# Created:    7/2/2018
# Modified:   2/20/2020
#
# Author:     Michael E. Tryby
#             US EPA - ORD/NRMRL
#
# Suggested Usage:
#   python setup.py build
#   python setup.py bdist_wheel
#   python setup.py clean
#

import platform
import subprocess

from skbuild import setup
from setuptools import Command


# Determine platform
platform_system = platform.system()


class CleanCommand(Command):
    ''' Cleans project tree '''
    user_options = []
    def initialize_options(self):
        pass
    def finalize_options(self):
        pass
    def run(self):
        if platform_system == "Darwin":
            cmd = ['setopt extended_glob nullglob; rm -vrf _skbuild dist **/build .pytest_cache \
            **/__pycache__ **/*.egg-info **/data/(^test_*).* **/data/en* **/.DS_Store MANIFEST']
            subprocess.Popen(cmd, shell=True, executable='/bin/zsh')


# Set platform specific cmake args here
if platform_system == "Windows":
    cmake_args = ["-GVisual Studio 14 2015 Win64"]

elif platform_system == "Darwin":
    cmake_args = ["-DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.10"] #python v3.7

else:
    cmake_args = ["-GNinja"]


setup(
    name = "epanet-toolkit",
    version = "0.5.0",

#    description='',
#    long_description='',

    cmake_args = cmake_args,

    package_dir = {"": "src"},
    packages = ["epanet.toolkit"],

    zip_safe = False,

    install_requires = ["aenum"],

    cmdclass = {"clean": CleanCommand}
)
