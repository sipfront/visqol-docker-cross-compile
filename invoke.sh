#!/bin/bash

# Specify container name
container_name="sipfront-visqol-py312-aws-2023"
DIRECTORY="build_test"

# Pull docker image and tag it
docker pull amazonlinux:2023 && docker tag amazonlinux:2023 local-amazonlinux:2023

# Build Docker image
docker build --tag="local-amazonlinux:latest" .

# Capture the container ID
docker run --name $container_name local-amazonlinux:latest

if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does exist."
  mkdir $DIRECTORY
fi


# Copy visqol build folder to working directory
echo "Copying visqol build directory!"
docker cp $container_name:/visqol/build/lib/visqol/ $PWD/$DIRECTORY/
docker cp $container_name:/visqol/env/lib/python3.12/site-packages/_soundfile_data/ $PWD/

# Remove used container
echo "Removing container!"
docker rm $container_name