#!/bin/bash

# set up up name of virtual env
python3.8 -m venv env 
PWD=`pwd`

echo "Current pwd: "$PWD
echo "1. Activate virtual environment!"
source $PWD/env/bin/activate

echo "2. Install necessary python packages!"
python3.8 -m pip install numpy scipy protobuf wheel

echo "3. Build visqol with bazel!"
bazel build :visqol -c opt