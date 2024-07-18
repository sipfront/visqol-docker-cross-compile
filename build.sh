#!/bin/bash

# set up up name of virtual env
python3.12 -m venv env
PWD=`pwd`

echo "Current pwd: "$PWD
echo "1. Activate virtual environment!"
source $PWD/env/bin/activate

# Install Setup tools manually
# [1] .. https://stackoverflow.com/a/76691103
# [2] .. https://stackoverflow.com/a/77360702
echo "2. Install necessary python packages!"
python3.12 -m pip install numpy scipy protobuf wheel setuptools

echo "3. Build visqol with bazel!"
bazel build :visqol -c opt

echo "4. Build .so visqol for python!"
python3.12 -m pip install .