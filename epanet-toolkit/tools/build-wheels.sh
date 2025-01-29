#!/bin/bash
set -e -x


# Setup and build in epanet-toolkit dir
mkdir -p ./dist
cd epanet-toolkit

# Build wheels
for PYBIN in /opt/python/cp{38,39,310,311,312}*/bin; do

    PYVERSION=$(${PYBIN}/python --version)
    echo "====================== BUILDING FOR $PYVERSION ======================"

    # Build wheel
    ${PYBIN}/python -m build --wheel --outdir ../dist

    # cleanup
    # echo "=== CLEANING UP ==="
    # ${PYBIN}/python setup.py clean > /dev/null
done


# Repairing and testing from epanet-python directory
cd ..

# Bundle external shared libraries into the wheels
for whl in ./dist/*-linux_x86_64.whl; do

    echo "=== REPAIRING WHEEL: $whl ==="

    auditwheel repair $whl -w ./dist
done


# Install packages and test
for PYBIN in /opt/python/cp{38,39,310,311,312}*/bin; do

    PYVERSION=$(${PYBIN}/python --version)
    echo "====================== TESTING FOR $PYVERSION ======================="

    # Setup python virtual environment for test
    ${PYBIN}/python -m venv --clear ./test-env
    source ./test-env/bin/activate

    python -m pip install -r epanet-toolkit/test-requirements.txt

    python -m pip install --verbose --no-index --find-links=./dist epanet_toolkit
    pytest --ignore=nrtest-epanet/

    deactivate
done

# Cleanup
rm -rf ./test-env
