# Option 1: https://stackoverflow.com/questions/20481225/how-can-i-use-a-local-image-as-the-base-image-with-a-dockerfile
# Option 2: https://stackoverflow.com/questions/44166971/pulling-from-a-local-docker-image-instead
#
# Right now I chose option 2
FROM local-amazonlinux:2023 AS buildstage0

# Download all necessary packages
# eventually!
# https://serverfault.com/questions/868600/can-i-install-a-recent-gcc-from-binaries-on-amazon-linux
RUN dnf install -y sudo
RUN dnf update -y && \
    dnf groupinstall 'Development Tools' -y && \
    dnf -y install gcc openssl-devel bzip2-devel libffi-devel wget tar which

# https://github.com/amazonlinux/amazon-linux-2023/issues/483
# https://github.com/amazonlinux/amazon-linux-2023/issues/483#issuecomment-2107107453
# https://developers.redhat.com/articles/2024/05/01/whats-new-red-hat-enterprise-linux-94#
# https://almalinux.pkgs.org/9/almalinux-appstream-x86_64/python3.12-devel-3.12.1-4.el9.x86_64.rpm.html
RUN dnf install -y \
    https://repo.almalinux.org/almalinux/9/AppStream/x86_64/os/Packages/python3.12-3.12.1-4.el9.x86_64.rpm \
    https://repo.almalinux.org/almalinux/9/AppStream/x86_64/os/Packages/python3.12-libs-3.12.1-4.el9.x86_64.rpm  \
    https://repo.almalinux.org/almalinux/9/AppStream/x86_64/os/Packages/python3.12-pip-wheel-23.2.1-4.el9.noarch.rpm \
    https://repo.almalinux.org/almalinux/9/AppStream/x86_64/os/Packages/libnsl2-2.0.0-1.el9.x86_64.rpm \
    https://repo.almalinux.org/almalinux/9/AppStream/x86_64/os/Packages/python3.12-devel-3.12.1-4.el9.x86_64.rpm

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

FROM buildstage2 AS buildstage3
# RUN chmod +x build.sh
# RUN source ./build.sh
