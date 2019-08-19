# FROM openjdk:8-jre-alpine
FROM ubuntu:cosmic

MAINTAINER Thierry TOUIN <thierrytouin.pro@gmail.com>

ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    APPLICATION_SLEEP=0 \
    JAVA_OPTS=""


RUN ["apt-get", "-y", "update"]
RUN ["apt-get", "-y", "install", "sudo"]

RUN \
  # configure the "user1" user
  groupadd user1 && \
  useradd user1 -s /bin/bash -m -g user1 -G sudo && \
  echo 'user1:user1' |chpasswd && \
  mkdir /home/user1/app 

RUN \  
  # install utilities
  apt-get install -y \
    wget \
    curl \
    htop \
    vim \
    git \
    zip \
    bzip2 \
    fontconfig \
    python \
    g++ \
    libpng-dev \
    build-essential \
    maven

RUN ["apt-get", "-y", "install", "openjdk-8-jdk"]
RUN ["apt-get", "-y", "install", "openjdk-11-jdk"]
RUN ["apt-get", "-y", "install", "telnet"]
RUN ["apt-get", "-y", "install", "jq"]

# expose the working directory, the Tomcat port, the BrowserSync ports
USER user1
WORKDIR "/home/user1/app"
VOLUME ["/home/user1/app"]

EXPOSE 8080

# Keep container alive
CMD tail -f /dev/null
