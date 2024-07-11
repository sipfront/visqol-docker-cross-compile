#!/bin/bash

# Specify container name
container_name="sipfront-test"

aws_linux_2=0

# Pull docker image and tag it
if ["$aws_linux_2" == 1]; then
    docker pull amazonlinux:2 && docker tag amazonlinux:2 local-amazonlinux:2
else
    docker pull amazonlinux:2023 && docker tag amazonlinux:2023 local-amazonlinux:2023
fi


# Build Docker image
docker build --tag="local-amazonlinux:latest" .

# Capture the container ID
docker run --name $container_name local-amazonlinux:latest

# Copy visqol build folder to working directory
echo "Copying visqol build directory!"
docker cp sipfront-test:/visqol/build/lib/visqol/ ./build_test/

# Remove used container
echo "Removing container!"
docker rm $container_name