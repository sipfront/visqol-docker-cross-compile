#!/bin/bash

# Specify container name
container_name="sipfront-test"
aws_linux_2=0

# Pull docker image and tag it
if [ "$aws_linux_2" == 1 ]; then
    docker pull amazonlinux:2 && docker tag amazonlinux:2 local-amazonlinux:2
    docker build --tag="local-amazonlinux:latest" .
else
    docker pull amazonlinux:2023 && docker tag amazonlinux:2023 local-amazonlinux:2023
    docker build --tag="local-amazonlinux:latest" -f Dockerfile.aws2023 .
fi

# Capture the container ID
docker run --name $container_name local-amazonlinux:latest

# Copy visqol build folder to working directory
echo "Copying visqol build directory!"
if [ "$aws_linux_2" == 1 ]; then
    docker cp sipfront-test:/visqol/build/lib/visqol/ ./build_test/
else
    docker cp sipfront-test:/visqol/build/lib/visqol/ ./build_test_aws2023/

# Remove used container
echo "Removing container!"
docker rm $container_name