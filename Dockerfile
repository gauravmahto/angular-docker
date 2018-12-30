# Build -> docker build --tag angular .

# Use Ubuntu as the base image
FROM ubuntu:18.04

LABEL maintainer="Gaurav Mahto <gauravm.git@gmail.com>"
LABEL projet="Angular Docker"

# Add a user for running applications.
RUN useradd docker
RUN mkdir -p /home/docker && chown docker:docker /home/docker

# Install sudo and dumb-init
RUN apt-get update && \
  apt-get clean && \
  apt-get install -y sudo && \
  sudo apt-get upgrade -y && \
  sudo apt-get install -y dumb-init

# Install x11vnc.
RUN sudo apt-get install -y x11vnc
# Install xvfb.
RUN sudo apt-get install -y xvfb
# Install fluxbox.
RUN sudo apt-get install -y fluxbox
# Install wget.
RUN sudo apt-get install -y wget
# Install wmctrl.
RUN sudo apt-get install -y wmctrl
RUN sudo apt-get install -y gnupg

# Set the Chrome repo.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
# Install Chrome.
RUN sudo apt-get update && apt-get -y install google-chrome-stable

# Install Java and ant.
RUN sudo apt-get install -y openjdk-8-jdk && \
  sudo apt-get install -y ant

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Install rsync, git, curl, node.
RUN  sudo apt-get install -y rsync && \
  sudo apt-get install -y git && \
  sudo apt-get install -y curl && \
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
  sudo apt-get install -y nodejs && \
  sudo apt-get install -y build-essential

# Install yarn.
RUN  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
  sudo apt-get update && \
  sudo apt-get install -y yarn

# Create angular dir
RUN mkdir -p /home/docker/angular && chown docker:docker /home/docker/angular
# Set the work dir
WORKDIR /home/docker/angular

COPY --chown=docker:docker tools/ ./tools/
COPY --chown=docker:docker package.json .
COPY --chown=docker:docker yarn.lock .

# Install the packages
RUN yarn install

# Copy the Angular sources
COPY --chown=docker:docker . .

COPY chrome-docker-bootstrap.sh /
CMD ["/chrome-docker-bootstrap.sh"]

# Not sure abot this.
# ENTRYPOINT ["dumb-init"]
