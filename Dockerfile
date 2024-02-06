# Pull base image.
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y rename build-essential ninja-build ca-certificates pkg-config binutils-dev software-properties-common git wget curl liblua5.2-0 libfontconfig python3-dev libcurl4-openssl-dev valgrind libdw-dev libiberty-dev zlib1g-dev doxygen python3-pip freeglut3-dev libglew1.5-dev libglu1-mesa-dev libgl1-mesa-dev libssl-dev

RUN \
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null && \
  echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null && \
  apt-add-repository "deb https://apt.kitware.com/ubuntu/ focal main" && \
  curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
  chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

RUN \
  apt-get update && \
  apt-get install -y kitware-archive-keyring && \
  apt-get install -y nodejs gh cmake

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
