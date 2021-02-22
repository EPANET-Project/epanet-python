#
# setup.py - Setup script for epanet-toolkit python package
#
# Created:    Jul 2, 2018
# Modified:   May 4, 2020
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


# Cleans project tree (useful to run prior to sdist)
class CleanCommand(Command):
    ''' Cleans project tree '''
    user_options = []

    def initialize_options(self):
        pass

    def finalize_options(self):
        pass

    def run(self):
        if platform_system == "Windows":
            cmd = ['del' '/Q', 'tests\\data\\temp_*.*' '&&' \
            'rd' '/s/q', '_cmake_test_compile', '_skbuild', 'dist', '.pytest_cache', \
            'src\\epanet\\toolkit\\epanet_toolkit.egg-info', 'tests\\__pycache__']
            exe = "C:\\Windows\\System32\\cmd.exe"

        elif platform_system == "Linux":
            cmd = ["rm -vrf _skbuild/ dist/ **/build .pytest_cache/ **/__pycache__  \
            **/*.egg-info **/data/temp_*.* **/data/en* **/.DS_Store MANIFEST"]
            exe = "/bin/bash"

        elif platform_system == "Darwin":
            cmd = ['setopt extended_glob nullglob; rm -vrf _skbuild dist **/build .pytest_cache \
            **/__pycache__ **/*.egg-info **/data/(^test_*).* **/data/en* **/.DS_Store MANIFEST']
            exe = '/bin/zsh'

        p = subprocess.Popen(cmd, shell=True, executable=exe)
        p.wait()


# Set platform specific cmake args here
if platform_system == "Windows":
    cmake_args = ["-GVisual Studio 15 2017 Win64"]

elif platform_system == "Darwin":
    cmake_args = ["-GXcode", "-DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.10"]

else:
    cmake_args = ["-GUnix Makefiles"]


# Removes extraneous files from wheel
def exclude_files(cmake_manifest):
    print("INFO: processing cmake manifest")
    exclude_pats = ('runepanet', '.cmake', '.exe', '.h', '.lib', '.bas', \
    '.def', '.pas', '.vb', '.md', 'AUTHORS', 'LICENSE.txt')
    return list(filter(lambda name: not (name.endswith(exclude_pats)), cmake_manifest))


setup(
    name = "epanet-toolkit",
    version = "0.5.0",

    cmake_args = cmake_args,

    packages = ["epanet.toolkit"],
    package_dir = {"": "src"},

    zip_safe = False,

    install_requires = ["aenum"],

    cmdclass = {"clean": CleanCommand},

    cmake_process_manifest_hook = exclude_files
)
