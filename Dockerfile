# Pull base image.
FROM ubuntu:18.04

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential git wget && \
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - && \
  apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' && \
  apt-get update && \
  apt-get install -y cmake

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]