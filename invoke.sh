#!/bin/bash

# Specify container name
container_name="sipfront-compile-visqol-py311-aws-linux-2023"

# Pull docker image and tag it
docker pull amazonlinux:2023 && docker tag amazonlinux:2023 local-amazonlinux:2023

# Build Docker image
docker build --tag="local-amazonlinux:latest" .

# Capture the container ID
docker run --name $container_name local-amazonlinux:latest

# Copy visqol build folder to working directory
echo "Copying visqol build directory!"
docker cp $container_name:/visqol/build/lib/visqol/ ./build_test/

# Remove used container
echo "Removing container!"
docker rm $container_name