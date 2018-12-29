# Build -> docker build --tag angular .

# Use Ubuntu as the base image
FROM ubuntu

LABEL maintainer "Gaurav Mahto <gauravm.git@gmail.com>"

# Install the dependencies
RUN apt-get update && \
  apt-get -y install sudo && \
  sudo apt-get upgrade -y && \
  sudo apt-get install -y openjdk-8-jdk && \
  sudo apt-get install -y ant

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN  sudo apt-get install -y rsync && \
  sudo apt-get install -y gnupg && \
  sudo apt-get install -y git && \
  sudo apt-get install -y curl && \
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
  sudo apt-get install -y nodejs

RUN  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
  sudo apt-get update && \
  sudo apt-get install -y yarn

RUN mkdir /angular
WORKDIR /angular

COPY tools/ ./tools/
COPY package.json .
COPY yarn.lock .

# Install the packages
RUN yarn install

# Copy the Angular sources
COPY . .

CMD ["node", "-v"]
