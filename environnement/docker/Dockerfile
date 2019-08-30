# FROM openjdk:8-jre-alpine
#FROM ubuntu:bionic 
#FROM ubuntu:cosmic
FROM ubuntu:disco


MAINTAINER Thierry TOUIN <thierrytouin.pro@gmail.com>

ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    APPLICATION_SLEEP=0 \
    JAVA_OPTS=""


RUN ["apt-get", "-y", "update"]
RUN ["apt-get", "-y", "install", "software-properties-common"]

## JAVA INSTALLATION
#RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
#RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
#RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends oracle-java8-installer && apt-get clean all

#RUN add-apt-repository -y ppa:webupd8team/java
#RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
#RUN ["apt-get", "-y", "update"]
#RUN ["apt-get", "-y", "install", "oracle-java8-installer"]

RUN apt-get -y install java-package


# Create user1
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
