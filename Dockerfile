# Pull base image.
FROM ubuntu:18.04

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential pkg-config binutils-dev software-properties-common git wget curl liblua5.2-0 python3-dev python3.6-dev python3.7-dev python3.8-dev libcurl4-openssl-dev libdw-dev libiberty-dev zlib1g-dev doxygen python3-pip freeglut3-dev libglew1.5-dev libglu1-mesa-dev libgl1-mesa-dev libssl-dev && \
  curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get install -y nodejs && \
  apt-get update && \
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - && \
  apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' && \
  apt-get update && \
  apt-get install -y cmake && \
  git clone https://github.com/SimonKagstrom/kcov kcov_src && \
  cd kcov_src && \
  cmake . && \
  cmake --build . -- -j2 && \
  cmake --build . --target install && \
  pip3 install -U Sphinx

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
