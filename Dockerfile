# Pull base image.
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y rename build-essential ninja-build cmake pkg-config binutils-dev software-properties-common git wget curl liblua5.2-0 libfontconfig python3-dev libcurl4-openssl-dev valgrind libdw-dev libiberty-dev zlib1g-dev doxygen python3-pip freeglut3-dev libglew1.5-dev libglu1-mesa-dev libgl1-mesa-dev libssl-dev && \
  curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
  chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
  apt-get update && \
  apt-get install -y nodejs gh && \
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
