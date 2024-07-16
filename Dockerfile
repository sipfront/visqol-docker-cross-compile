# Option 1: https://stackoverflow.com/questions/20481225/how-can-i-use-a-local-image-as-the-base-image-with-a-dockerfile
# Option 2: https://stackoverflow.com/questions/44166971/pulling-from-a-local-docker-image-instead
#
# Right now I chose option 2
FROM local-amazonlinux:2 AS buildstage0

# Download all necessary packages eventually!
# https://serverfault.com/questions/868600/can-i-install-a-recent-gcc-from-binaries-on-amazon-linux

RUN yum install -y sudo
RUN yum update -y && \
    yum groupinstall 'Development Tools' -y && \
    yum -y install gcc openssl-devel bzip2-devel libffi-devel wget tar which

# https://techviewleo.com/how-to-install-python-on-amazon-linux/
# https://stackoverflow.com/questions/66255730/python3-8-devel-package-for-amazon-linux
RUN sudo amazon-linux-extras enable python3.8
RUN yum install -y python3.8 python3.8-devel

# Set Up Bazel
FROM buildstage0 AS buildstage1
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.8.1/bazelisk-linux-amd64
RUN chmod +x bazelisk-linux-amd64
RUN sudo mv bazelisk-linux-amd64 /usr/local/bin/bazel

# Pull visqol repo
RUN git clone https://github.com/google/visqol.git

# Now we change the working directory!
WORKDIR /visqol

# Copy adapted file_path.h to container
# [1] https://stackoverflow.com/questions/55474690/stdfilesystem-has-not-been-declared-after-including-experimental-filesystem
# [2] https://stackoverflow.com/questions/45867379/why-does-gcc-not-seem-to-have-the-filesystem-standard-library
# [3] https://dev.to/0xbf/how-to-get-glibc-version-c-lang-26he
FROM buildstage1 AS buildstage2
COPY file_path.h src/include/
COPY .bazelrc setup.py test.py callee.wav caller.wav build.sh /visqol/

# FROM buildstage2 as buildstage3
RUN chmod +x build.sh
RUN source ./build.sh
