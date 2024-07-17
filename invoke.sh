#!/bin/bash

# Specify container name
container_name="sipfront-test"
aws_linux_2=1
while getopts a: flag
do
    case "${flag}" in
        a) aws_linux_2=${OPTARG};;
    esac
done

# Give directory
dir=""
if [ "$aws_linux_2" == 1 ]; then
    dir="build-binaries-aws-linux-2"
else
    dir="build-binaries-aws-linux-2023"
fi

# Check if directory already exists
if [[ ! -e $dir ]]; then
    mkdir $dir
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi


# Pull docker image and tag it
if [ "$aws_linux_2" == 1 ]; then
    docker pull amazonlinux:2 && docker tag amazonlinux:2 local-amazonlinux:2
    docker build --tag="local-amazonlinux:latest" -f Dockerfile.aws2 .
else
    docker pull amazonlinux:2023 && docker tag amazonlinux:2023 local-amazonlinux:2023
    docker build --tag="local-amazonlinux:latest" -f Dockerfile.aws2023 .
fi

# Capture the container ID
docker run --name $container_name local-amazonlinux:latest

# Copy visqol build folder to working directory
echo "Copying visqol build directory!"
docker cp sipfront-test:/visqol/build/lib/visqol/ $dir/visqol

# Remove used container
echo "Removing container!"
docker rm $container_name